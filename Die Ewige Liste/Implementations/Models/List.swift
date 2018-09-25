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
    var pointsPlayerTop: Int = 0
    var pointsPlayerBottom: Int = 0
    //    var settingsVersions: [Int : [SettingsItem]] = [:]
    private var userSettings: [String : Double] = [:] {
        didSet { dataChanged() }
    }
    var games: [Game] = [] {
        didSet { dataChanged() }
    }
    
    // MARK: Life Cycle
    
    init(playerOneName: String, playerTwoName: String) {
        self.playerOneName = playerOneName
        self.playerTwoName = playerTwoName
    }
    
    // MARK: Public
    
    func getSettingValue(for key: String) -> Double {
        return userSettings[key] ?? Constants.Settings.defaults[key] ?? 0
    }
    
    func updateSetting(for key: String, to value: Double) {
        userSettings[key] = value
    }
    
    // MARK: Helpers
    
    private func updatePoints() {
        pointsPlayerTop = 0
        pointsPlayerBottom = 0
        let gameWinPoints = Int(getSettingValue(for: Constants.Settings.Keys.gameWinPoints))
        let timeWinPoints = Int(getSettingValue(for: Constants.Settings.Keys.timeWinPoints))
        
        for game in games {
            if let winner = game.winner {
                if winner.name == playerOneName {
                    pointsPlayerTop += gameWinPoints
                } else if winner.name == playerTwoName {
                    pointsPlayerBottom += gameWinPoints
                }
            }
            
            if let timeWinner = game.timeWinner {
                if timeWinner.name == playerOneName {
                    pointsPlayerTop += timeWinPoints
                } else if timeWinner.name == playerTwoName {
                    pointsPlayerBottom += timeWinPoints
                }
            }
        }
    }
    
    private func dataChanged() {
        updatePoints()
        ListService.standard.saveLists()
    }
}
