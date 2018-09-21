//
//  Game.swift
//  Die Ewige Liste
//
//  Created by Johannes Bagge on 29.07.18.
//  Copyright © 2018 jmb. All rights reserved.
//

import UIKit

enum State: String, Codable {
    case new, running, paused, ended
}

// MARK: -

struct Game: Codable {
    var state: State = .new
    var dateStarted: Date?
    var dateEnded: Date?
    var totalTimeInSeconds: CGFloat = 0.0
    var playerTop: Player!
    var playerBottom: Player!
    var winner: Player?
    var loser: Player?
    var timeWinner: Player?
//    var settingsVersion: Double!
}
