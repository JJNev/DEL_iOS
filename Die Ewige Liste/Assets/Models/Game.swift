//
//  Game.swift
//  Die Ewige Liste
//
//  Created by Johannes Bagge on 29.07.18.
//  Copyright © 2018 jmb. All rights reserved.
//

import Foundation

struct Game {
    enum State {
        case new, running, paused, ended
    }
    
    // MARK: -
    
    var state: State = .new
    let dateStarted: Date?
    let dateEnded: Date?
    let totalTimeInSeconds: Int = 0
    let winner: Player?
    let loser: Player?
    let timeWinner: Player?
    let settings: Dictionary<String, Any>?
}
