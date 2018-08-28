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
    private var currentPlayer: Player?
    private var gameState: GameState = .new
    
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
            // TODO: Add player names from "List" element
            currentPlayer = sender == tapGestureRecognizerWhite ? Player(color: .black, name: "") : .white
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
        switch currentPlayer {
        case .white:
            currentPlayer = .black
            break
        case .black:
            currentPlayer = .white
            break
        case .none:
            break
        }
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
        switch currentPlayer {
        case .white:
            timeWhite += 1
            break
        case .black:
            timeBlack += 1
            break
        case .none:
            break
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
        switch currentPlayer {
        case .white:
            tapGestureRecognizerWhite.isEnabled = true
            tapGestureRecognizerBlack.isEnabled = false
            break
        case .black:
            tapGestureRecognizerWhite.isEnabled = false
            tapGestureRecognizerBlack.isEnabled = true
            break
        case .none:
            tapGestureRecognizerWhite.isEnabled = true
            tapGestureRecognizerBlack.isEnabled = true
            break
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
        switch currentPlayer {
        case .white:
            timeWhiteLabel.text = String(format: "%02d:%02d", timeWhite / 60, timeWhite % 60)
            break
        case .black:
            timeBlackLabel.text = String(format: "%02d:%02d", timeBlack / 60, timeBlack % 60)
            break
        case .none:
            timeWhiteLabel.text = String(format: "%02d:%02d", timeWhite / 60, timeWhite % 60)
            timeBlackLabel.text = String(format: "%02d:%02d", timeBlack / 60, timeBlack % 60)
            break
        }
    }
    
    private func updatePlayerLabels() {
        switch currentPlayer {
        case .white:
            tapToEndLabelWhite.isHidden = false
            tapToEndLabelBlack.isHidden = true
            break
        case .black:
            tapToEndLabelWhite.isHidden = true
            tapToEndLabelBlack.isHidden = false
            break
        case .none:
            tapToEndLabelWhite.isHidden = true
            tapToEndLabelBlack.isHidden = true
            break
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
        switch currentPlayer {
        case .white:
            midSeperatorYConstraint.constant = SeperatorConstraintConstants.whitePlaying.rawValue
            break
        case .black:
            midSeperatorYConstraint.constant = SeperatorConstraintConstants.blackPlaying.rawValue
            break
        case .none:
            midSeperatorYConstraint.constant = SeperatorConstraintConstants.neutral.rawValue
            break
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
