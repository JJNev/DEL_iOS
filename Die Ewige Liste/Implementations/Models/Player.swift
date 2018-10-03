//
//  Player.swift
//  Die Ewige Liste
//
//  Created by Johannes Bagge on 29.07.18.
//  Copyright © 2018 jmb. All rights reserved.
//

import UIKit

enum Color: String, Codable {
    case white, black
}

// MARK: -

class Player: Equatable, Codable {
    var color: Color
    var name: String
    var timeInSeconds: CGFloat = 0.0
    
    // MARK: Life Cycle
    
    init(color: Color, name: String) {
        self.color = color
        self.name = name
    }
    
    // MARK: Equatable
    
    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.color == rhs.color && lhs.name == rhs.name
    }
}


