//
//  Game.swift
//  Die Ewige Liste
//
//  Created by Johannes Bagge on 29.07.18.
//  Copyright © 2018 jmb. All rights reserved.
//

import Foundation

struct Game {
    var gameState: GameState?
    
    let dateStarted: Date?
    let dateEnded: Date?
    let winner: Player?
    let loser: Player?
    let settings: Dictionary<String, Any>?
}
