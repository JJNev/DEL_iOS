//
//  Player.swift
//  Die Ewige Liste
//
//  Created by Johannes Bagge on 29.07.18.
//  Copyright © 2018 jmb. All rights reserved.
//


class Player: Equatable {
    enum Color {
        case white, black
    }
    
    // MARK: -
    
    var color: Color
    var name: String
    var time: Int = 0
    
    // MARK: Life Cycle
    
    init(color: Color, name: String) {
        self.color = color
        self.name = name
    }
    
    // MARK: Equatable protocol
    
    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.color == rhs.color && lhs.name == rhs.name
    }
}
