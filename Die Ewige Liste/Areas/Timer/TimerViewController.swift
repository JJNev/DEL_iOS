//
//  TimerViewController.swift
//  Die Ewige Liste
//
//  Created by Johannes Büro on 09.07.18.
//  Copyright © 2018 jmb. All rights reserved.
//

import UIKit

fileprivate enum SeperatorConstraintConstants: CGFloat {
    case neutral = 0
    case whitePlaying = 100
    case blackPlaying = -100
}

class TimerViewController: UIViewController {
    @IBOutlet var timeLabelTop: RotatingLabel!
    @IBOutlet var timeLabelBottom: UILabel!
    @IBOutlet var tapGestureRecognizerTop: UITapGestureRecognizer!
    @IBOutlet var tapGestureRecognizerBottom: UITapGestureRecognizer!
    @IBOutlet var tapToEndLabelTop: RotatingLabel!
    @IBOutlet var tapToEndLabelBottom: UILabel!
    @IBOutlet weak var nameLabelTop: RotatingLabel!
    @IBOutlet weak var nameLabelBottom: UILabel!
    
    @IBOutlet weak var preGameControls: UIView!
    @IBOutlet weak var inGameControls: UIView!
    @IBOutlet var midSeperatorYConstraint: NSLayoutConstraint!
    @IBOutlet var pauseResumeButton: UIButton!
    @IBOutlet var resetButton: UIButton!
    @IBOutlet weak var endGameButton: UIButton!
    
    @IBOutlet var defaultBlackViews: [UIView]!
    @IBOutlet var defaultWhiteViews: [UIView]!
    
    private let defaultAnimationTime: TimeInterval = 0.1
    
    private lazy var timer = Timer()
    private var currentPlayer: Player?
    private var game: Game!

    var list: List!
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: Create new game and add to list
        setupGame()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let endGameViewController = segue.destination as? EndGameViewController {
            endGame()
            endGameViewController.setGame(game, fromList: list)
        }
    }
    
    // MARK: Actions
    
    @IBAction func pauseResumeTapped(_ sender: Any) {
        switch game.state {
        case .running:
            timer.invalidate()
            game.state = .paused
            if let pauseButton = sender as? UIButton {
                pauseButton.setImage(#imageLiteral(resourceName: "play.png"), for: .normal)
            }
            break
        case .paused:
            startTimer(reset: false)
            game.state = .running
            if let pauseButton = sender as? UIButton {
                pauseButton.setImage(#imageLiteral(resourceName: "pause.png"), for: .normal)
            }
            break
        default:
            break
        }
    }
    
    @IBAction func refreshTapped(_ sender: Any) {
        resetGame()
    }
    
    @IBAction func areaTapped(_ sender: UITapGestureRecognizer) {
        // Whoever taps first can start
        if currentPlayer == nil {
            // TODO: Who plays which color?
            currentPlayer = sender == tapGestureRecognizerTop ? game.playerBottom : game.playerTop
            startGame()
        }
        changeTurn()
    }
    
    @IBAction func swapSeatsTapped(_ sender: Any) {
        swapSeats()
    }
    
    @IBAction func swapColorsTapped(_ sender: Any) {
        swapColors()
    }
    
    
    // MARK: Helper
    
    private func startGame() {
        guard game.state != .running else {
            return
        }
        game.state = .running
        updateMidControls()
        updatePauseButton()
        
        UIView.animate(
            withDuration: defaultAnimationTime,
            delay: 0.0,
            options: [.curveEaseInOut, .allowUserInteraction, .beginFromCurrentState],
            animations: {
                self.preGameControls.layoutIfNeeded()
                self.inGameControls.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func setupGame() {
        game = Game(state: .new, dateStarted: Date(), dateEnded: nil, totalTime: 0, playerTop: Player(color: .white, name: list.playerOneName), playerBottom: Player(color: .black, name: list.playerTwoName), winner: nil, loser: nil, timeWinner: nil, settings: nil)
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
        for view in defaultBlackViews + defaultWhiteViews {
            if let label = view as? UILabel {
                label.textColor = label.textColor == .white ? .black : .white
            } else {
                view.backgroundColor = view.backgroundColor == .white ? .black : .white
            }
        }
    }
    
    private func startTimer(reset: Bool) {
        game.state = .running
        if reset {timer.invalidate()}
        timer = .scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    private func changeTurn() {
        guard let unwrappedCurrentPlayer = currentPlayer else {
            return
        }
        currentPlayer = unwrappedCurrentPlayer == game.playerTop ? game.playerBottom : game.playerTop
        
        startTimer(reset: true)
        updateTapGestureRecognizers()
        updateMidSeperator()
        updatePlayerLabels()
    }
    
    private func resetGame() {
        game.playerTop.time = 0
        game.playerBottom.time = 0
        currentPlayer = .none
        game.state = .new
        updateUi()
    }
    
    @objc private func updateTime() {
        guard let unwrappedCurrentPlayer = currentPlayer else {
            return
        }
        
        if unwrappedCurrentPlayer.color == .white {
            game.playerTop.time += 1
        } else if unwrappedCurrentPlayer.color == .black {
            game.playerBottom.time += 1
        }
        
        updateTimeLabels()
    }
    
    private func endGame() {
        timer.invalidate()
        game.state = .ended
        game.dateEnded = Date()
        game.totalTime = game.playerTop.time + game.playerBottom.time
        
        // TODO: game.playerTop.time == game.playerBottom.time
        let timeWinner = game.playerTop.time > game.playerBottom.time ? game.playerBottom : game.playerTop
        game.timeWinner = timeWinner
    }
    
    // MARK: Update UI
    
    private func updateUi() {
        updateTapGestureRecognizers()
        updatePauseButton()
        updateTimeLabels()
        updatePlayerLabels()
        updateMidSeperator()
        updateMidControls()
    }
    
    private func updateMidControls() {
        switch game.state {
        case .paused:
            fallthrough
        case .running:
            preGameControls.isHidden = true
            preGameControls.isUserInteractionEnabled = false
            inGameControls.isHidden = false
            inGameControls.isUserInteractionEnabled = true
            break
        default:
            preGameControls.isHidden = false
            preGameControls.isUserInteractionEnabled = true
            inGameControls.isHidden = true
            inGameControls.isUserInteractionEnabled = false
            break
        }
    }
    
    private func updateTapGestureRecognizers() {
        if let unwrappedCurrentPlayer = currentPlayer {
            if unwrappedCurrentPlayer.color == .white {
                tapGestureRecognizerTop.isEnabled = true
                tapGestureRecognizerBottom.isEnabled = false
            } else if unwrappedCurrentPlayer.color == .black {
                tapGestureRecognizerTop.isEnabled = false
                tapGestureRecognizerBottom.isEnabled = true
            }
        } else {
            tapGestureRecognizerTop.isEnabled = true
            tapGestureRecognizerBottom.isEnabled = true
        }
    }
    
    private func updatePauseButton() {
        switch game.state {
        case .running:
            pauseResumeButton.setImage(#imageLiteral(resourceName: "pause.png"), for: .normal)
            break
        case .paused:
            pauseResumeButton.setImage(#imageLiteral(resourceName: "play.png"), for: .normal)
            break
        default:
            break
        }
        
        UIView.animate(
            withDuration: defaultAnimationTime,
            delay: 0.0,
            options: .curveLinear,
            animations: {
                self.pauseResumeButton.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func updateTimeLabels() {
        if let unwrappedCurrentPlayer = currentPlayer {
            if unwrappedCurrentPlayer.color == .white {
                timeLabelTop.text = game.playerTop.time.toTimeString()
            } else if unwrappedCurrentPlayer.color == .black {
                timeLabelBottom.text = game.playerBottom.time.toTimeString()
            }
        } else {
            timeLabelTop.text = game.playerTop.time.toTimeString()
            timeLabelBottom.text = game.playerBottom.time.toTimeString()
        }
    }
    
    private func updateNameLabels() {
        nameLabelTop.text = game.playerTop.name
        nameLabelBottom.text = game.playerBottom.name
    }
    
    private func updatePlayerLabels() {
        if let unwrappedCurrentPlayer = currentPlayer {
            if unwrappedCurrentPlayer.color == .white {
                tapToEndLabelTop.isHidden = false
                tapToEndLabelBottom.isHidden = true
            } else if unwrappedCurrentPlayer.color == .black {
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
    
    private func updateMidSeperator() {
        if let unwrappedCurrentPlayer = currentPlayer {
            if unwrappedCurrentPlayer.color == .white {
                midSeperatorYConstraint.constant = SeperatorConstraintConstants.whitePlaying.rawValue
            } else if unwrappedCurrentPlayer.color == .black {
                midSeperatorYConstraint.constant = SeperatorConstraintConstants.blackPlaying.rawValue
            }
        } else {
            midSeperatorYConstraint.constant = SeperatorConstraintConstants.neutral.rawValue
        }
        
        UIView.animate(
            withDuration: defaultAnimationTime,
            delay: 0.0,
            options: [.curveEaseInOut, .allowUserInteraction, .beginFromCurrentState],
            animations: {
                self.view.layoutIfNeeded()
        }, completion: nil)
    }
}
