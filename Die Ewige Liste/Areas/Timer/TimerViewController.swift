//
//  TimerViewController.swift
//  Die Ewige Liste
//
//  Created by Johannes Büro on 09.07.18.
//  Copyright © 2018 jmb. All rights reserved.
//

import UIKit

fileprivate enum SeparatorConstraintConstants: CGFloat {
    case neutral = 0
    case topPlaying = 100
    case bottomPlaying = -100
}

class TimerViewController: UIViewController, ChallengeDelegate {
    @IBOutlet var timeLabelTop: RotatingLabel!
    @IBOutlet var timeLabelBottom: UILabel!
    @IBOutlet var tapGestureRecognizerTop: UITapGestureRecognizer!
    @IBOutlet var tapGestureRecognizerBottom: UITapGestureRecognizer!
    @IBOutlet var tapToEndLabelTop: RotatingLabel!
    @IBOutlet var tapToEndLabelBottom: UILabel!
    @IBOutlet weak var nameLabelTop: RotatingLabel!
    @IBOutlet weak var nameLabelBottom: UILabel!
    @IBOutlet weak var flagButtonTop: UIView!
    @IBOutlet weak var flagButtonBottom: UIButton!
    @IBOutlet weak var challengeContainerTop: UIView!
    @IBOutlet weak var challengeContainerBottom: UIView!
    
    @IBOutlet weak var preGameControls: UIView!
    @IBOutlet weak var inGameControls: UIView!
    @IBOutlet var midSeparatorYConstraint: NSLayoutConstraint!
    @IBOutlet var pauseResumeButton: UIButton!
    @IBOutlet var resetButton: UIButton!
    @IBOutlet weak var endGameButton: UIButton!
    
    @IBOutlet var topPlayerColorViews: [UIView]!
    @IBOutlet var bottomPlayerColorViews: [UIView]!
    
    private let defaultAnimationTime: TimeInterval = 0.2
    
    private lazy var timer = Timer()
    private var currentPlayer: Player?
    private var game: Game!

    var list: List!
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGame()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.backgroundColor = .clear
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.isNavigationBarHidden = false
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let endGameViewController = segue.destination as? EndGameViewController {
            endGame()
            updatePauseButton(animated: false)
            endGameViewController.setGame(game, fromList: list)
        }
    }
    
    // MARK: Actions
    
    @IBAction func pauseResumeTapped(_ sender: Any) {
        togglePauseResumeGame()
    }
    
    @IBAction func refreshTapped(_ sender: Any) {
        resetGame()
    }
    
    @IBAction func areaTapped(_ sender: UITapGestureRecognizer) {
        // Whoever taps first can start
        if currentPlayer == nil {
            currentPlayer = sender == tapGestureRecognizerTop ? game.playerBottom : game.playerTop
            startGame()
        }
        changeTurn()
        updatePauseButton()
        updateNavigationBar()
    }
    
    @IBAction func swapSeatsTapped(_ sender: Any) {
        swapSeats()
    }
    
    @IBAction func swapColorsTapped(_ sender: Any) {
        swapColors()
    }
    
    @IBAction func flagTapped(_ sender: Any) {
        let challengedPlayer = ((sender as! UIButton) == flagButtonTop) ? game.playerBottom : game.playerTop
        showChallengeUi(for: challengedPlayer!)
    }
    
    // MARK: Challenge Delegate
    
    func challengeAccepted(accepted: Bool, by challengedPlayer: Player) {
        let penalty = CGFloat(list.getSettingValue(for: Constants.Settings.Keys.challengePenalty))
        if accepted {
            challengedPlayer.timeInSeconds += penalty
        } else {
            let otherPlayer = challengedPlayer == game.playerTop ? game.playerBottom! : game.playerTop!
            otherPlayer.timeInSeconds += penalty
        }
        resumeGame()
        updateTimeLabels(both: true)
        updateMidControls()
    }
    
    // MARK: Helper
    
    private func startGame() {
        guard game.state != .running else {
            return
        }
        game.state = .running
        updateMidControls()
        updatePauseButton()
        updateNavigationBar()
        updateFlagButtons()
        
        UIView.animate(
            withDuration: defaultAnimationTime,
            delay: 0.0,
            options: [.curveEaseInOut, .allowUserInteraction, .beginFromCurrentState],
            animations: {
                self.preGameControls.layoutIfNeeded()
                self.inGameControls.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func togglePauseResumeGame() {
        switch game.state {
        case .running:
            pauseGame()
            break
        default:
            resumeGame()
            break
        }
    }
    
    private func pauseGame() {
        timer.invalidate()
        game.state = .paused
        updatePauseButton()
        updateNavigationBar()
    }
    
    private func resumeGame() {
        startTimer(reset: false)
        game.state = .running
        updatePauseButton()
        updateNavigationBar()
        updateFlagButtons()
        updateTapGestureRecognizers()
    }
    
    private func resetGame() {
        game.playerTop.timeInSeconds = 0
        game.playerBottom.timeInSeconds = 0
        currentPlayer = nil
        game.state = .new
        updateUi()
    }
    
    private func setupGame() {
        game = Game(state: .new, dateStarted: Date(), dateEnded: nil, totalTimeInSeconds: 0, playerTop: Player(color: .white, name: list.playerOneName), playerBottom: Player(color: .black, name: list.playerTwoName), winner: nil, loser: nil, timeWinner: nil)
        updateNameLabels()
    }
    
    private func swapSeats() {
        let newPlayerTop = Player(color: game.playerTop.color, name: game.playerBottom.name)
        let newPlayerBottom = Player(color: game.playerBottom.color, name: game.playerTop.name)
        game.playerBottom = newPlayerBottom
        game.playerTop = newPlayerTop
        updateNameLabels()
    }
    
    private func swapColors() {
        UIApplication.shared.statusBarStyle = UIApplication.shared.statusBarStyle == .lightContent ? .default : .lightContent
        for view in topPlayerColorViews + bottomPlayerColorViews {
            if let label = view as? UILabel {
                label.textColor = label.textColor == .white ? .black : .white
            } else if let button = view as? UtilButton {
                button.borderColor = button.borderColor == .white ? .black : .white
                button.tintColor = button.tintColor == .white ? .black : .white
            } else {
                view.backgroundColor = view.backgroundColor == .white ? .black : .white
            }
        }
        
        let newPlayerTop = Player(color: game.playerBottom.color, name: game.playerTop.name)
        let newPlayerBottom = Player(color: game.playerTop.color, name: game.playerBottom.name)
        game.playerTop = newPlayerTop
        game.playerBottom = newPlayerBottom
    }
    
    private func startTimer(reset: Bool) {
        game.state = .running
        // TODO: Consider using two timers for more precision.
        if reset {timer.invalidate()}
        timer = .scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    private func changeTurn() {
        guard let unwrappedCurrentPlayer = currentPlayer else {
            return
        }
        currentPlayer = unwrappedCurrentPlayer == game.playerTop ? game.playerBottom : game.playerTop
        
        startTimer(reset: true)
        updateTapGestureRecognizers()
        updateMidSeparator()
        updatePlayerLabels()
    }
    
    @objc private func updateTime() {
        guard let unwrappedCurrentPlayer = currentPlayer else {
            return
        }
        unwrappedCurrentPlayer.timeInSeconds += 0.01
        updateTimeLabels()
    }
    
    private func endGame() {
        timer.invalidate()
        game.state = .ended
        game.dateEnded = Date()
        game.totalTimeInSeconds = game.playerTop.timeInSeconds + game.playerBottom.timeInSeconds
        
        // TODO: game.playerTop.time == game.playerBottom.time
        let timeWinner = game.playerTop.timeInSeconds > game.playerBottom.timeInSeconds ? game.playerBottom : game.playerTop
        game.timeWinner = timeWinner
    }
    
    private func showChallengeUi(for challengedPlayer: Player) {
        if let container = challengedPlayer == game.playerTop ? challengeContainerTop : challengeContainerBottom {
            let challengeView: ChallengeView! = ChallengeView(frame: container.bounds)
            challengeView.delegate = self
            challengeView.challengedPlayer = challengedPlayer
            challengeView.colorScheme = challengedPlayer.color == .white ? .black : .white
            container.addSubview(challengeView)
            challengeView.startAnimation()
        }
        game.state = .challenged
        timer.invalidate()
        updateMidControls()
        updateFlagButtons()
        updateTapGestureRecognizers()
    }
    
    // MARK: Update UI
    
    private func updateUi() {
        updateTapGestureRecognizers()
        updatePauseButton()
        updateTimeLabels()
        updatePlayerLabels()
        updateMidSeparator()
        updateMidControls()
        updateNavigationBar()
        updateFlagButtons()
    }
    
    private func updateMidControls() {
        switch game.state {
        case .paused:
            fallthrough
        case .running:
            preGameControls.isHidden = true
            inGameControls.isHidden = false
            break
        case .challenged:
            preGameControls.isHidden = true
            inGameControls.isHidden = true
        default:
            preGameControls.isHidden = false
            inGameControls.isHidden = true
            break
        }
        preGameControls.isUserInteractionEnabled = !preGameControls.isHidden
        inGameControls.isUserInteractionEnabled = !inGameControls.isHidden
    }
    
    private func updateNavigationBar() {
        switch game.state {
        case .running:
            navigationController?.setNavigationBarHidden(true, animated: true)
            break
        default:
            navigationController?.setNavigationBarHidden(false, animated: false)
            break
        }
    }
    
    private func updateMidSeparator() {
        if let unwrappedCurrentPlayer = currentPlayer {
            if unwrappedCurrentPlayer == game.playerTop {
                midSeparatorYConstraint.constant = SeparatorConstraintConstants.topPlaying.rawValue
            } else if unwrappedCurrentPlayer == game.playerBottom {
                midSeparatorYConstraint.constant = SeparatorConstraintConstants.bottomPlaying.rawValue
            }
        } else {
            midSeparatorYConstraint.constant = SeparatorConstraintConstants.neutral.rawValue
        }
        
        UIView.animate(
            withDuration: defaultAnimationTime,
            delay: 0.0,
            options: [.curveEaseInOut, .allowUserInteraction, .beginFromCurrentState],
            animations: {
                self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func updateTapGestureRecognizers() {
        switch game.state {
        case .new:
            tapGestureRecognizerTop.isEnabled = true
            tapGestureRecognizerBottom.isEnabled = true
            break
        case .challenged:
            tapGestureRecognizerTop.isEnabled = false
            tapGestureRecognizerBottom.isEnabled = false
        default:
            if let unwrappedCurrentPlayer = currentPlayer {
                if unwrappedCurrentPlayer == game.playerTop {
                    tapGestureRecognizerTop.isEnabled = true
                    tapGestureRecognizerBottom.isEnabled = false
                } else if unwrappedCurrentPlayer == game.playerBottom {
                    tapGestureRecognizerTop.isEnabled = false
                    tapGestureRecognizerBottom.isEnabled = true
                }
            }
            break
        }
    }
    
    private func updatePauseButton(animated: Bool = true) {
        switch game.state {
        case .running:
            pauseResumeButton.setImage(#imageLiteral(resourceName: "pause.png"), for: .normal)
            break
        default:
            pauseResumeButton.setImage(#imageLiteral(resourceName: "play.png"), for: .normal)
            break
        }
        
        if animated {
            UIView.animate(
                withDuration: defaultAnimationTime,
                delay: 0.0,
                options: .curveLinear,
                animations: {
                    self.pauseResumeButton.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    private func updateTimeLabels(both: Bool = false) {
        if let unwrappedCurrentPlayer = currentPlayer, !both {
            if unwrappedCurrentPlayer == game.playerTop {
                timeLabelTop.text = game.playerTop.timeInSeconds.secondsToTimeString()
            } else if unwrappedCurrentPlayer == game.playerBottom {
                timeLabelBottom.text = game.playerBottom.timeInSeconds.secondsToTimeString()
            }
        } else {
            timeLabelTop.text = game.playerTop.timeInSeconds.secondsToTimeString()
            timeLabelBottom.text = game.playerBottom.timeInSeconds.secondsToTimeString()
        }
    }
    
    private func updateNameLabels() {
        nameLabelTop.text = game.playerTop.name
        nameLabelBottom.text = game.playerBottom.name
    }
    
    private func updatePlayerLabels() {
        if let unwrappedCurrentPlayer = currentPlayer {
            if unwrappedCurrentPlayer == game.playerTop {
                tapToEndLabelTop.isHidden = false
                tapToEndLabelBottom.isHidden = true
            } else if unwrappedCurrentPlayer == game.playerBottom {
                tapToEndLabelTop.isHidden = true
                tapToEndLabelBottom.isHidden = false
            }
        } else {
            tapToEndLabelTop.isHidden = true
            tapToEndLabelBottom.isHidden = true
        }
        
        UIView.animate(
            withDuration: defaultAnimationTime,
            delay: 0.0,
            options: .curveLinear,
            animations: {
                self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func updateFlagButtons() {
        switch game.state {
        case .running:
            flagButtonTop.isHidden = false
            flagButtonBottom.isHidden = false
            break
        default:
            flagButtonTop.isHidden = true
            flagButtonBottom.isHidden = true
            break
        }
        
        UIView.animate(
            withDuration: defaultAnimationTime,
            delay: 0.0,
            options: .curveLinear,
            animations: {
                self.flagButtonTop.layoutIfNeeded()
                self.flagButtonBottom.layoutIfNeeded()
        }, completion: nil)
    }
}
