//
//  SwitchItem.swift
//  Die Ewige Liste
//
//  Created by Johannes Bagge on 21.09.18.
//  Copyright © 2018 jmb. All rights reserved.
//

import Foundation

class SwitchItem: SettingsItem {
    var defaultValue: Bool
    var userValue: Bool?
    
    // MARK: Life Cycle
    
    init(title: String, key: String, indentationLevel: Int = 0, defaultValue: Bool) {
        self.defaultValue = defaultValue
        super.init(title: title, key: key, indentationLevel: indentationLevel)
    }
}
