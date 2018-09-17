//
//  Game.swift
//  Die Ewige Liste
//
//  Created by Johannes Bagge on 29.07.18.
//  Copyright © 2018 jmb. All rights reserved.
//

import UIKit

struct Game {
    enum State {
        case new, running, paused, ended
    }
    
    // MARK: -
    
    var state: State = .new
    var dateStarted: Date?
    var dateEnded: Date?
    var totalTimeInSeconds: CGFloat = 0.0
    var playerTop: Player!
    var playerBottom: Player!
    var winner: Player?
    var loser: Player?
    var timeWinner: Player?
    var settings: Dictionary<String, Any>?
}
