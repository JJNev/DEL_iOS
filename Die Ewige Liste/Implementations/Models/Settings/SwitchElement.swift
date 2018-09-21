//
//  SwitchElement.swift
//  Die Ewige Liste
//
//  Created by Johannes Bagge on 21.09.18.
//  Copyright © 2018 jmb. All rights reserved.
//

import Foundation

class SwitchElement: SettingsElement {
    var defaultValue: Bool
    
    init(title: String, level: Int = 0, defaultValue: Bool) {
        self.defaultValue = defaultValue
        super.init(title: title, level: level)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
        // TODO: Implement
    }
}
