//
//  List.swift
//  Die Ewige Liste
//
//  Created by Johannes Bagge on 27.08.18.
//  Copyright © 2018 jmb. All rights reserved.
//

import Foundation

class List: Codable {
    var playerOneName: String
    var playerTwoName: String
    var playerOnePoints: Int = 0
    var playerTwoPoints: Int = 0
//    var settingsVersions: [Int : [SettingsElement]] = [:]
    var games: [Game] = [] {
        didSet {
            updatePoints()
            ListService.standard.saveLists()
        }
    }
    
    // TODO: Load this
    private (set) var userSettings: [String : Double] = [
        "Game Win Points" : 4,
        "Time Win Points" : 0,
        "Enable Challenge" : false.toDouble()
    ]
    
    // MARK: Life Cycle
    
    init(playerOneName: String, playerTwoName: String) {
        self.playerOneName = playerOneName
        self.playerTwoName = playerTwoName
    }
    
    // MARK: Public
    
    func getValue<T>(for settingsElement: SettingsElement) -> T? {
        if let stepperElement = settingsElement as? StepperElement {
            return userSettings[stepperElement.key] != nil ? (userSettings[stepperElement.key] as! T) : (stepperElement.defaultValue as! T)
        } else if let switchElement = settingsElement as? SwitchElement {
            return userSettings[switchElement.key] != nil ? (userSettings[switchElement.key]!.toBool() as! T) : (switchElement.defaultValue as! T)
        }
        return nil
    }
    
    // MARK: Helpers
    
    private func updatePoints() {
        playerOnePoints = 0
        playerTwoPoints = 0
        
        for game in games {
            // TODO: Consider points from ruleset
            let pointsForGameWin = 3
            let pointsForTimeWin = 1
            
            if let winner = game.winner {
                if winner.name == playerOneName {
                    playerOnePoints += pointsForGameWin
                } else if winner.name == playerTwoName {
                    playerTwoPoints += pointsForGameWin
                }
            }
            
            if let timeWinner = game.timeWinner {
                if timeWinner.name == playerOneName {
                    playerOnePoints += pointsForTimeWin
                } else if timeWinner.name == playerTwoName {
                    playerTwoPoints += pointsForTimeWin
                }
            }
        }
    }
}
