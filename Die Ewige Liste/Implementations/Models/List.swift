//
//  List.swift
//  Die Ewige Liste
//
//  Created by Johannes Bagge on 27.08.18.
//  Copyright © 2018 jmb. All rights reserved.
//

import Foundation

class List: NSObject, NSCoding {
    private (set) var games: [Game] = []
    var playerOneName: String
    var playerTwoName: String
    var playerOnePoints: Int = 0
    var playerTwoPoints: Int = 0
    
    // MARK: Life Cycle
    
    init(playerOneName: String, playerTwoName: String) {
        self.playerOneName = playerOneName
        self.playerTwoName = playerTwoName
    }
    
    convenience init(playerOneName: String, playerTwoName: String, playerOnePoints: Int, playerTwoPoints: Int) {
        self.init(playerOneName: playerOneName, playerTwoName: playerTwoName)
        self.playerOnePoints = playerOnePoints
        self.playerTwoPoints = playerTwoPoints
    }
    
    convenience init(playerOneName: String, playerTwoName: String, games: [Game]) {
        self.init(playerOneName: playerOneName, playerTwoName: playerTwoName)
        self.games = games
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let games = aDecoder.decodeObject(forKey: "games") as! [Game]
        let playerOneName = aDecoder.decodeObject(forKey: "playerOneName") as! String
        let playerTwoName = aDecoder.decodeObject(forKey: "playerTwoName") as! String
        
        print("games: \(games)")
        
        self.init(playerOneName: playerOneName, playerTwoName: playerTwoName, games: games)
//        self.init(playerOneName: playerOneName, playerTwoName: playerTwoName)
        
        // TODO: Make sure  games and points are loaded
        updatePoints()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(games, forKey: "games")
        aCoder.encode(playerOneName, forKey: "playerOneName")
        aCoder.encode(playerTwoName, forKey: "playerTwoName")
        aCoder.encode(playerOnePoints, forKey: "playerOnePoints")
        aCoder.encode(playerTwoPoints, forKey: "playerTwoPoints")
    }
    
    // MARK: Public
    
    func addGame(_ game: Game) {
        games.append(game)
        updatePoints()
    }
    
    func removeGame(at index: Int) {
        games.remove(at: index)
        updatePoints()
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
