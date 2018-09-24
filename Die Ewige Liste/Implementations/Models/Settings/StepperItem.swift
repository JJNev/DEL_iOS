//
//  StepperItem.swift
//  Die Ewige Liste
//
//  Created by Johannes Bagge on 21.09.18.
//  Copyright © 2018 jmb. All rights reserved.
//

import Foundation

class StepperItem: SettingsItem {
    var unit: String?
    var maximum: Double
    var minimum: Double
    var defaultValue: Double = 0.0
    var userValue: Double?
    
    // MARK: Life Cycle
    
    init(title: String, key: String, indentationLevel: Int = 0, unit: String? = nil, defaultValue: Double, maximum: Double, minimum: Double) {
        self.unit = unit
        self.defaultValue = defaultValue
        self.maximum = maximum
        self.minimum = minimum
        super.init(title: title, key: key, indentationLevel: indentationLevel)
    }
}
