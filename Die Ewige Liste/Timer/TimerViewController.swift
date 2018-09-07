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
    
    @IBOutlet var midSeperatorYConstraint: NSLayoutConstraint!
    @IBOutlet var pauseResumeButton: UIButton!
    @IBOutlet var resetButton: UIButton!
    
    @IBOutlet var defaultBlackViews: [UIView]!
    @IBOutlet var defaultWhiteViews: [UIView]!
    
    private lazy var timer = Timer()
    private var timeTop = 0
    private var timeBottom = 0
    private var playerTop: Player!
    private var playerBottom: Player!
    private var currentPlayer: Player?
    private var gameState: Game.State = .new
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
    
    // MARK: Actions
    
    @IBAction func pauseResumeTapped(_ sender: Any) {
        switch gameState {
        case .running:
            timer.invalidate()
            gameState = .paused
            if let pauseButton = sender as? UIButton {
                pauseButton.setImage(#imageLiteral(resourceName: "play.png"), for: .normal)
            }
            break
        case .paused:
            startTimer(reset: false)
            gameState = .running
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
            currentPlayer = sender == tapGestureRecognizerTop ? playerTop : playerBottom
        }
        changeTurn()
        updatePauseButton()
        updateResetButton()
    }
    
    // MARK: Helper
    
    private func setupGame() {
        
        
        // TODO: Modal: Who plays which position/color?
        playerTop = Player(color: .white, name: list.playerOneName)
        playerBottom = Player(color: .black, name: list.playerTwoName)
        nameLabelTop.text = playerTop.name
        nameLabelBottom.text = playerBottom.name
        adjustColors()
    }
    
    private func adjustColors() {
        guard playerBottom.color != .black else {
            // This is the default case. Nothing to do.
            return
        }
        
        for view in defaultBlackViews + defaultWhiteViews {
            if let label = view as? UILabel {
                label.textColor = label.textColor == .white ? .black : .white
            } else {
                view.backgroundColor = view.backgroundColor == .white ? .black : .white
            }
        }
    }
    
    private func startTimer(reset: Bool) {
        gameState = .running
        if reset {timer.invalidate()}
        timer = .scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    private func changeTurn() {
        guard let unwrappedCurrentPlayer = currentPlayer else {
            return
        }
        
        currentPlayer = unwrappedCurrentPlayer == playerTop ? playerBottom : playerTop
        
        startTimer(reset: true)
        updateTapGestureRecognizers()
        updateMidSeperator()
        updatePlayerLabels()
    }
    
    private func resetGame() {
        timeTop = 0
        timeBottom = 0
        currentPlayer = .none
        gameState = .new
        updateUi()
    }
    
    private func endGame() {
        // TODO: Modal: Who won?
        let winner = playerTop
        // TODO: timeTop == timeBottom
        let timeWinner = timeTop > timeBottom ? playerBottom : playerTop
        
        game.dateEnded = Date()
        game.winner = winner
        game.loser = winner == playerTop ? playerBottom : playerTop
        game.state = .ended
        game.timeWinner = timeWinner
        game.totalTimeInSeconds = timeTop + timeBottom
        list.games.append(game)
        
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func updateTime() {
        guard let unwrappedCurrentPlayer = currentPlayer else {
            return
        }
        
        if unwrappedCurrentPlayer.color == .white {
            timeTop += 1
        } else if unwrappedCurrentPlayer.color == .black {
            timeBottom += 1
        }
        
        updateTimeLabels()
    }
    
    // MARK: Update UI
    
    private func updateUi() {
        updateTapGestureRecognizers()
        updatePauseButton()
        updateResetButton()
        updateTimeLabels()
        updatePlayerLabels()
        updateMidSeperator()
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
        switch gameState {
        case .running:
            pauseResumeButton.setImage(#imageLiteral(resourceName: "pause.png"), for: .normal)
            pauseResumeButton.isHidden = false
            break
        case .paused:
            pauseResumeButton.setImage(#imageLiteral(resourceName: "play.png"), for: .normal)
            pauseResumeButton.isHidden = false
            break
        case .new:
            pauseResumeButton.isHidden = true
        default:
            break
        }
        
        UIView.animate(
            withDuration: 0.1,
            delay: 0.0,
            options: .curveLinear,
            animations: {
                self.pauseResumeButton.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func updateResetButton() {
        switch gameState {
        case .new:
            fallthrough
        case .ended:
            resetButton.isHidden = true
            break
        default:
            resetButton.isHidden = false
            break
        }
    }
    
    private func updateTimeLabels() {
        if let unwrappedCurrentPlayer = currentPlayer {
            if unwrappedCurrentPlayer.color == .white {
                timeLabelTop.text = String(format: "%02d:%02d", timeTop / 60, timeTop % 60)
            } else if unwrappedCurrentPlayer.color == .black {
                timeLabelBottom.text = String(format: "%02d:%02d", timeBottom / 60, timeBottom % 60)
            }
        } else {
            timeLabelTop.text = String(format: "%02d:%02d", timeTop / 60, timeTop % 60)
            timeLabelBottom.text = String(format: "%02d:%02d", timeBottom / 60, timeBottom % 60)
        }
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
            withDuration: 0.1,
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
            withDuration: 0.1,
            delay: 0.0,
            options: [.curveEaseInOut, .allowUserInteraction, .beginFromCurrentState],
            animations: {
                self.view.layoutIfNeeded()
        }, completion: nil)
    }
}
