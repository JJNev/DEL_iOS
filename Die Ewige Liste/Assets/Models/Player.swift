//
//  Player.swift
//  Die Ewige Liste
//
//  Created by Johannes Bagge on 29.07.18.
//  Copyright © 2018 jmb. All rights reserved.
//


class Player {
    enum Color {
        case white, black
    }

    var color: Color
    var name: String
    
    init(color: Color, name: String) {
        self.color = color
        self.name = name
    }
}
