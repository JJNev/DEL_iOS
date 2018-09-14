//
//  EndGameViewController.swift
//  Die Ewige Liste
//
//  Created by Johannes Bagge on 11.09.18.
//  Copyright © 2018 jmb. All rights reserved.
//

import UIKit

class EndGameViewController: ModalViewController {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var winnerSelectionSegmentedControl: UISegmentedControl!
    @IBOutlet weak var timeTopPlayerLabel: UILabel!
    @IBOutlet weak var timeBottomPlayerLabel: UILabel!
    @IBOutlet weak var timeWinnerContentLabel: UILabel!
    @IBOutlet weak var timeTopPlayerContentLabel: UILabel!
    @IBOutlet weak var timeBottomPlayerContentLabel: UILabel!
    @IBOutlet weak var timeTotalContentLabel: UILabel!
    @IBOutlet weak var pointsPlayerTopNameLabel: UILabel!
    @IBOutlet weak var pointsPlayerBottomNameLabel: UILabel!
    @IBOutlet weak var pointsPlayerTopContentLabel: UILabel!
    @IBOutlet weak var pointsPlayerBottomContentLabel: UILabel!
    
    private var game: Game!
    private var list: List?
    
    // MARK: Actions
    
    @IBAction func winnerSelectionChanged(_ sender: Any) {
        updatePoints()
    }
    
    @IBAction func proceedButtonTapped(_ sender: Any) {
        finalizeGame()
    }
    
    // MARK: Helper
    
    func setGame(_ game: Game, fromList list: List) {
        self.game = game
        self.list = list
        
        // Necessary hack to load view hierarchy.
        _ = view
        
        winnerSelectionSegmentedControl.setTitle(game.playerTop.name, forSegmentAt: 0)
        winnerSelectionSegmentedControl.setTitle(game.playerBottom.name, forSegmentAt: 1)
        timeTopPlayerLabel.text = "Time \(game.playerTop.name)"
        timeBottomPlayerLabel.text = "Time \(game.playerBottom.name)"
        timeWinnerContentLabel.text = game.timeWinner?.name
        timeTopPlayerContentLabel.text = game.playerTop.time.toTimeString()
        timeBottomPlayerContentLabel.text = game.playerBottom.time.toTimeString()
        timeTotalContentLabel.text = game.totalTime.toTimeString()
        pointsPlayerTopNameLabel.text = game.playerTop.name
        pointsPlayerBottomNameLabel.text = game.playerBottom.name
        updatePoints()
    }
    
    private func updatePoints() {
        // TODO: Consider active ruleset
        let pointsForGameWin = 3
        let pointsForTimeWin = 1
        var pointsPlayerTop = 0
        var pointsPlayerBottom = 0
        
        if winnerSelectionSegmentedControl.selectedSegmentIndex == 0 {
            pointsPlayerTop += pointsForGameWin
        } else {
            pointsPlayerBottom += pointsForGameWin
        }
        
        if let timeWinner = game.timeWinner {
            if timeWinner == game.playerTop {
                pointsPlayerTop += pointsForTimeWin
            } else {
                pointsPlayerBottom += pointsForTimeWin
            }
        }
        
        pointsPlayerTopContentLabel.text = String(pointsPlayerTop)
        pointsPlayerBottomContentLabel.text = String(pointsPlayerBottom)
    }
    
    private func finalizeGame() {
        guard let list = list else {
            return
        }
        game.winner = winnerSelectionSegmentedControl.selectedSegmentIndex == 0 ? game.playerTop : game.playerBottom
        game.loser = winnerSelectionSegmentedControl.selectedSegmentIndex == 0 ? game.playerBottom : game.playerTop
        list.games.append(game)
        
        if let navigationController = presentingViewController as? UINavigationController {
            dismiss(animated: false, completion: {
                navigationController.popViewController(animated: true)
            })
        }
    }
}
