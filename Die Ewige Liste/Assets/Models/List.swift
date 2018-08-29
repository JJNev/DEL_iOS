//
//  List.swift
//  Die Ewige Liste
//
//  Created by Johannes Bagge on 27.08.18.
//  Copyright © 2018 jmb. All rights reserved.
//

import Foundation

class List {
    var playerOneName: String
    var playerTwoName: String
    var games: [Game] = []
    
    init(playerOneName: String, playerTwoName: String) {
        self.playerOneName = playerOneName
        self.playerTwoName = playerTwoName
    }
}