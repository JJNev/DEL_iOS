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
//    var settings: Dictionary<String, Any>?
    
//    // MARK: Life Cycle
//
//    init(state: State, dateStarted: Date?, dateEnded: Date?, totalTimeInSeconds: CGFloat, playerTop: Player, playerBottom: Player, winner: Player?, loser: Player?, timeWinner: Player?, settings: Dictionary<String, Any>?) {
//        self.state = state
//        self.dateStarted = dateStarted
//        self.dateEnded = dateEnded
//        self.totalTimeInSeconds = totalTimeInSeconds
//        self.playerTop = playerTop
//        self.playerBottom = playerBottom
//        self.winner = winner
//        self.loser = loser
//        self.timeWinner = timeWinner
//        self.settings = settings
//    }
//
//    // MARK: Coding
//
//    required convenience init?(coder aDecoder: NSCoder) {
//        let state = aDecoder.decodeObject(forKey: "state") as! State
//        let dateStarted = aDecoder.decodeObject(forKey: "dateStarted") as! Date?
//        let dateEnded = aDecoder.decodeObject(forKey: "dateEnded") as! Date?
//        let totalTimeInSeconds = aDecoder.decodeObject(forKey: "totalTimeInSeconds") as! CGFloat
//        let playerTop = aDecoder.decodeObject(forKey: "playerTop") as! Player
//        let playerBottom = aDecoder.decodeObject(forKey: "playerBottom") as! Player
//        let winner = aDecoder.decodeObject(forKey: "winner") as! Player?
//        let loser = aDecoder.decodeObject(forKey: "loser") as! Player?
//        let timeWinner = aDecoder.decodeObject(forKey: "timeWinner") as! Player?
//        let settings = aDecoder.decodeObject(forKey: "settings") as! Dictionary<String, Any>?
//        self.init(state: state, dateStarted: dateStarted, dateEnded: dateEnded, totalTimeInSeconds: totalTimeInSeconds, playerTop: playerTop, playerBottom: playerBottom, winner: winner, loser: loser, timeWinner: timeWinner, settings: settings)
//    }
//
//    func encode(with aCoder: NSCoder) {
//        aCoder.encode(state, forKey: "state")
//        aCoder.encode(dateStarted, forKey: "dateStarted")
//        aCoder.encode(dateEnded, forKey: "dateEnded")
//        aCoder.encode(totalTimeInSeconds, forKey: "totalTimeInSeconds")
//        aCoder.encode(playerTop, forKey: "playerTop")
//        aCoder.encode(playerBottom, forKey: "playerBottom")
//        aCoder.encode(winner, forKey: "winner")
//        aCoder.encode(loser, forKey: "loser")
//        aCoder.encode(timeWinner, forKey: "timeWinner")
//        aCoder.encode(settings, forKey: "settings")
//    }
}
