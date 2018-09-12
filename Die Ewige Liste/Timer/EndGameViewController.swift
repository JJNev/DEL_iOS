//
//  EndGameViewController.swift
//  Die Ewige Liste
//
//  Created by Johannes Bagge on 11.09.18.
//  Copyright © 2018 jmb. All rights reserved.
//

import UIKit

class EndGameViewController: UIViewController {
    @IBOutlet weak var timeTopPlayerLabel: UILabel!
    @IBOutlet weak var timeBottomPlayerLabel: UILabel!
    @IBOutlet weak var timeWinnerContentLabel: UILabel!
    @IBOutlet weak var timeTopPlayerContentLabel: UILabel!
    @IBOutlet weak var timeBottomPlayerContentLabel: UILabel!
    @IBOutlet weak var timeTotalContentLabel: UILabel!
    
    private var game: Game?
    private var list: List?
    
    // MARK: Life Cycle
    
    // MARK: Actions
    
    @IBAction func winnerSelectionChanged(_ sender: Any) {
        
    }
    
    @IBAction func proceedButtonTapped(_ sender: Any) {
        finalizeGame()
    }
    
    // MARK: Helper
    
    func setGame(_ game: Game, fromList list: List) {
        var game = game
        // TODO: Find winner by seg control string
        let winner = game.playerTop
        game.winner = winner
        game.loser = winner == game.playerTop ? game.playerBottom : game.playerTop
        
//        timeTopPlayerLabel.text = 
    }
    
    private func finalizeGame() {
        guard let game = game, let list = list else {
            return
        }
        list.games.append(game)
        // TODO: Leave screen
    }
}
