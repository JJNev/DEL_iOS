//
//  Constants.swift
//  Die Ewige Liste
//
//  Created by Johannes Bagge on 17.09.18.
//  Copyright © 2018 jmb. All rights reserved.
//

import Foundation

struct Constants {
    struct KeychainIdentifier {
        static let lists = "lists"
    }
    
    struct Settings {
        struct Keys {
            static let gameWinPoints = "gameWinPoints"
            static let timeWinPoints = "timeWinPoints"
            static let enableChallenge = "enableChallenge"
        }
        
        static let defaults = [
            Keys.gameWinPoints : 3.0,
            Keys.timeWinPoints : 1.0,
            Keys.enableChallenge : true.toDouble()
        ]
    }
}
