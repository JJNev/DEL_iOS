//
//  Game.swift
//  Die Ewige Liste
//
//  Created by Johannes Bagge on 29.07.18.
//  Copyright © 2018 jmb. All rights reserved.
//

import Foundation

struct Game {
    var state: GameState = GameState.new
    
    let dateStarted: Date?
    let dateEnded: Date?
    let totalTimeInSeconds: Int = 0
    let winner: Player?
    let loser: Player?
    let timeWinner: Player?
    let settings: Dictionary<String, Any>?
}
