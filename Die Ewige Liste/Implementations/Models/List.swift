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
//    var settingsVersions: [Int : [SettingsItem]] = [:]
    var games: [Game] = [] {
        didSet {
            updatePoints()
            ListService.standard.saveLists()
        }
    }
    
    // TODO: Load this
    // Initiated with default values.
    private (set) var userSettings: [String : Double] = [
        Constants.SettingsIdentifier.gameWinPoints : 3,
        Constants.SettingsIdentifier.timeWinPoints : 1,
        Constants.SettingsIdentifier.enableChallenge : true.toDouble()
    ]
    
    // MARK: Life Cycle
    
    init(playerOneName: String, playerTwoName: String) {
        self.playerOneName = playerOneName
        self.playerTwoName = playerTwoName
    }
    
    // MARK: Public
    
    // TODO: Might remove arguments (/whole function?) here if defaults are kept in userSettings array
    func getValue<T>(for settingsItem: SettingsItem) -> T? {
        if let stepperItem = settingsItem as? StepperItem {
            return userSettings[stepperItem.key] != nil ? (userSettings[stepperItem.key] as! T) : (stepperItem.defaultValue as! T)
        } else if let switchItem = settingsItem as? SwitchItem {
            return userSettings[switchItem.key] != nil ? (userSettings[switchItem.key]!.toBool() as! T) : (switchItem.defaultValue as! T)
        }
        return nil
    }
    
    // MARK: Helpers
    
    private func updatePoints() {
        playerOnePoints = 0
        playerTwoPoints = 0
        
        for game in games {
            let pointsForGameWin = Int(userSettings[Constants.SettingsIdentifier.gameWinPoints] ?? 3)
            let pointsForTimeWin = Int(userSettings[Constants.SettingsIdentifier.timeWinPoints] ?? 1)
            
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
