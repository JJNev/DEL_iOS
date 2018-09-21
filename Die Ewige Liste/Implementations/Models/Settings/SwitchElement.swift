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
    var userValue: Bool?
    
    // MARK: Life Cycle
    
    init(title: String, level: Int = 0, defaultValue: Bool) {
        self.defaultValue = defaultValue
        super.init(title: title, level: level)
    }
}
