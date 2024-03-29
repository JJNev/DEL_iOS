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
    
    // MARK: Public
    
    func setGame(_ game: Game) {
        timeTotalContentLabel.text = game.totalTimeInSeconds.secondsToTimeString()
        if let endDate = game.dateEnded {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            dateFormatter.timeStyle = .short
            dateLabel.text = dateFormatter.string(from: endDate)
        }
        
        switch game.state {
        case .new:
            gameStateLabel.text = "new".uppercased()
            break
        case .running:
            gameStateLabel.text = "running".uppercased()
            break
        case .paused:
            gameStateLabel.text = "paused".uppercased()
            break
        case .challenged:
            gameStateLabel.text = "challenged".uppercased()
            break
        case .ended:
            gameStateLabel.text = "ended".uppercased()
            winnerContentLabel.text = game.winner?.name
            timeWinnerContentLabel.text = game.timeWinner?.name
            break
        }
    }
}
