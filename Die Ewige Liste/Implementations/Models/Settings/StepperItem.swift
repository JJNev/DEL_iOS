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
    var userValue: Double?
    
    // MARK: Life Cycle
    
    init(title: String, key: String, indentationLevel: Int = 0, unit: String? = nil, minimum: Double, maximum: Double) {
        self.unit = unit
        self.maximum = maximum
        self.minimum = minimum
        super.init(title: title, key: key, indentationLevel: indentationLevel)
    }
}
