//
//  GameHistoryCell.swift
//  Die Ewige Liste
//
//  Created by Johannes Bagge on 29.07.18.
//  Copyright © 2018 jmb. All rights reserved.
//

import UIKit

enum CellState {
    case expanded, collapsed
}

class GameHistoryCell: UITableViewCell {
    @IBOutlet weak var winnerLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var gameTimeLabel: UILabel!
    @IBOutlet weak var timeWinnerLabel: UILabel!
    
    var cellState: CellState = .expanded
    var game: Game?
    
    // MARK: Helper
    
    private func switchCellState() {
        switch cellState {
        case .expanded:
            break
        case .collapsed:
            break
        }
    }
    
    private func fillUi() {
        guard let game = game else {
            return
        }
        winnerLabel.text += game.winnerName
        
    }
}
