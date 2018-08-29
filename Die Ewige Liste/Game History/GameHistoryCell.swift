//
//  GameHistoryCell.swift
//  Die Ewige Liste
//
//  Created by Johannes Bagge on 29.07.18.
//  Copyright © 2018 jmb. All rights reserved.
//

import UIKit

class GameHistoryCell: UITableViewCell {
    @IBOutlet weak var winnerContentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeTotalContentLabel: UILabel!
    @IBOutlet weak var timeWinnerContentLabel: UILabel!
    @IBOutlet weak var gameStateLabel: UILabel!
    
    var game: Game?
    
    // MARK: Helper
    
    private func fillUi(game: Game) {
        self.game = game
        timeTotalContentLabel.text = String(format: "%02d:%02d", game.totalTimeInSeconds / 60, game.totalTimeInSeconds % 60)
        if let endDate = game.dateEnded {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            dateFormatter.timeStyle = .short
            dateLabel.text = dateFormatter.string(from: endDate)
        }
        
        switch game.state {
        case GameState.new:
            gameStateLabel.text = "new".uppercased()
            break
        case GameState.running:
            gameStateLabel.text = "running".uppercased()
            break
        case GameState.paused:
            gameStateLabel.text = "paused".uppercased()
            break
        case GameState.ended:
            gameStateLabel.text = "ended".uppercased()
            winnerContentLabel.text = game.winner?.name
            timeWinnerContentLabel.text = game.timeWinner?.name
            break
        }
    }
}
