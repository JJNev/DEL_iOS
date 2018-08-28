//
//  ListCell.swift
//  Die Ewige Liste
//
//  Created by Johannes Bagge on 28.08.18.
//  Copyright © 2018 jmb. All rights reserved.
//

import UIKit

class ListCell: UITableViewCell {
    @IBOutlet weak var playerOneNameLabel: UILabel!
    @IBOutlet weak var playerTwoNameLabel: UILabel!
    @IBOutlet weak var playerOnePointsLabel: UILabel!
    @IBOutlet weak var playerTwoPointsLabel: UILabel!
    @IBOutlet weak var gamesPlayedLabel: UILabel!
    
    func setList(list: List) {
        playerOneNameLabel.text = list.playerOneName
        playerTwoNameLabel.text = list.playerTwoName
        gamesPlayedLabel.text = String(list.games.count)
    }
}
