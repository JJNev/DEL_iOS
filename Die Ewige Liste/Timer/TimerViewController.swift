//
//  TimerViewController.swift
//  Die Ewige Liste
//
//  Created by Johannes Büro on 09.07.18.
//  Copyright © 2018 jmb. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
    
    @IBOutlet var midSeperatorYConstraint: NSLayoutConstraint!
    @IBOutlet var timeWhiteLabel: RotatingLabel!
    @IBOutlet var timeBlackLabel: UILabel!
    @IBOutlet var tapGestureRecognizerWhite: UITapGestureRecognizer!
    @IBOutlet var tapGestureRecognizerBlack: UITapGestureRecognizer!
    @IBOutlet var tapToEndLabelWhite: RotatingLabel!
    @IBOutlet var tapToEndLabelBlack: UILabel!
    
    private lazy var timer = Timer()
    private var timeWhite = 0
    private var timeBlack = 0
    private var currentPlayer: Player = .none
    private var gameState: GameState = .new
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapToEndLabelBlack.isHidden = true
        tapToEndLabelWhite.isHidden = true
    }
    
    // MARK: Actions
    
    @IBAction func pauseTapped(_ sender: Any) {
        gameState = .paused
        timer.invalidate()
    }
    
    @IBAction func refreshTapped(_ sender: Any) {
        resetGame()
    }
    
    @IBAction func areaTapped(_ sender: UITapGestureRecognizer) {
        // Whoever taps first can start
        if currentPlayer == .none {
            currentPlayer = sender == tapGestureRecognizerWhite ? .black : .white
        }
        changeTurn()
    }
    
    // MARK: Helper
    
    private func startFreshTimer() {
        gameState = .running
        timer.invalidate()
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
        updateTapGestureRecognizers()
        updateMidSeperator()
        startFreshTimer()
        updatePlayerLabels()
    }
    
    private func resetGame() {
        timeWhite = 0
        timeBlack = 0
        currentPlayer = .none
        updateTimeLabels()
        updatePlayerLabels()
        updateMidSeperator()
        updateTapGestureRecognizers()
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
            tapToEndLabelWhite.isHidden = false
            tapToEndLabelBlack.isHidden = true
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

enum Player {
    case none, white, black
}

enum GameState {
    case new, running, paused, ended
}

enum SeperatorConstraintConstants: CGFloat {
    case neutral = 0
    case whitePlaying = 100
    case blackPlaying = -100
}
