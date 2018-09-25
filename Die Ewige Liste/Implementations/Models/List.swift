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
    private (set) var userSettings: [String : Double] = [
        Constants.Settings.Keys.gameWinPoints : 5,
        Constants.Settings.Keys.timeWinPoints : 0,
        Constants.Settings.Keys.enableChallenge : false.toDouble()
    ]
    
    // MARK: Life Cycle
    
    init(playerOneName: String, playerTwoName: String) {
        self.playerOneName = playerOneName
        self.playerTwoName = playerTwoName
    }
    
    // MARK: Public
    
    func getSettingValue(for key: String) -> Double {
        return userSettings[key] ?? Constants.Settings.defaults[key] ?? 0
    }
    
    // MARK: Helpers
    
    private func updatePoints() {
        playerOnePoints = 0
        playerTwoPoints = 0
        
        for game in games {
            let gameWinPoints = Int(getSettingValue(for: Constants.Settings.Keys.gameWinPoints))
            let timeWinPoints = Int(getSettingValue(for: Constants.Settings.Keys.timeWinPoints))
            
            if let winner = game.winner {
                if winner.name == playerOneName {
                    playerOnePoints += gameWinPoints
                } else if winner.name == playerTwoName {
                    playerTwoPoints += gameWinPoints
                }
            }
            
            if let timeWinner = game.timeWinner {
                if timeWinner.name == playerOneName {
                    playerOnePoints += timeWinPoints
                } else if timeWinner.name == playerTwoName {
                    playerTwoPoints += timeWinPoints
                }
            }
        }
    }
}
