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
    @IBOutlet var midSeperatorYConstraint: NSLayoutConstraint!
    @IBOutlet var timeWhiteLabel: RotatingLabel!
    @IBOutlet var timeBlackLabel: UILabel!
    @IBOutlet var tapGestureRecognizerWhite: UITapGestureRecognizer!
    @IBOutlet var tapGestureRecognizerBlack: UITapGestureRecognizer!
    @IBOutlet var tapToEndLabelWhite: RotatingLabel!
    @IBOutlet var tapToEndLabelBlack: UILabel!
    @IBOutlet var pauseResumeButton: UIButton!
    @IBOutlet var resetButton: UIButton!
    
    private lazy var timer = Timer()
    private var timeWhite = 0
    private var timeBlack = 0
    private lazy var playerOne: Player = Player(color: .black, name: list.playerOneName)
    private lazy var playerTwo: Player = Player(color: .white, name: list.playerTwoName)
    private var currentPlayer: Player?
    private var gameState: Game.State = .new
    
    var list: List!
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: Create new game and add to list
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
            currentPlayer = sender == tapGestureRecognizerWhite ? playerOne : playerTwo
        }
        changeTurn()
        updatePauseButton()
        updateResetButton()
    }
    
    // MARK: Helper
    
    private func startTimer(reset: Bool) {
        gameState = .running
        if reset {timer.invalidate()}
        timer = .scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    private func changeTurn() {
        guard let unwrappedCurrentPlayer = currentPlayer else {
            return
        }
        
        currentPlayer = unwrappedCurrentPlayer == playerOne ? playerTwo : playerOne
        
        startTimer(reset: true)
        updateTapGestureRecognizers()
        updateMidSeperator()
        updatePlayerLabels()
    }
    
    private func resetGame() {
        timeWhite = 0
        timeBlack = 0
        currentPlayer = .none
        gameState = .new
        updateUi()
    }
    
    
    @objc private func updateTime() {
        guard let unwrappedCurrentPlayer = currentPlayer else {
            return
        }
        
        if unwrappedCurrentPlayer.color == .white {
            timeWhite += 1
        } else if unwrappedCurrentPlayer.color == .black {
            timeBlack += 1
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
                tapGestureRecognizerWhite.isEnabled = true
                tapGestureRecognizerBlack.isEnabled = false
            } else if unwrappedCurrentPlayer.color == .black {
                tapGestureRecognizerWhite.isEnabled = false
                tapGestureRecognizerBlack.isEnabled = true
            }
        } else {
            tapGestureRecognizerWhite.isEnabled = true
            tapGestureRecognizerBlack.isEnabled = true
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
                timeWhiteLabel.text = String(format: "%02d:%02d", timeWhite / 60, timeWhite % 60)
            } else if unwrappedCurrentPlayer.color == .black {
                timeBlackLabel.text = String(format: "%02d:%02d", timeBlack / 60, timeBlack % 60)
            }
        } else {
            timeWhiteLabel.text = String(format: "%02d:%02d", timeWhite / 60, timeWhite % 60)
            timeBlackLabel.text = String(format: "%02d:%02d", timeBlack / 60, timeBlack % 60)
        }
    }
    
    private func updatePlayerLabels() {
        if let unwrappedCurrentPlayer = currentPlayer {
            if unwrappedCurrentPlayer.color == .white {
                tapToEndLabelWhite.isHidden = false
                tapToEndLabelBlack.isHidden = true
            } else if unwrappedCurrentPlayer.color == .black {
                tapToEndLabelWhite.isHidden = true
                tapToEndLabelBlack.isHidden = false
            }
        } else {
            tapToEndLabelWhite.isHidden = true
            tapToEndLabelBlack.isHidden = true
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
