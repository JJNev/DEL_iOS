//
//  SettingsElement.swift
//  Die Ewige Liste
//
//  Created by Johannes Bagge on 20.09.18.
//  Copyright © 2018 jmb. All rights reserved.
//

import Foundation

class SettingsElement {
    var title: String
    let key: String
    let indentationLevel: Int
    
    // MARK: Life Cycle
    
    init(title: String, key: String, indentationLevel: Int = 0) {
        self.title = title
        self.key = key
        self.indentationLevel = indentationLevel
    }
}
