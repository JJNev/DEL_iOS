//
//  StepperElement.swift
//  Die Ewige Liste
//
//  Created by Johannes Bagge on 21.09.18.
//  Copyright © 2018 jmb. All rights reserved.
//

import Foundation

class StepperElement: SettingsElement {
    var unit: String?
    var defaultValue: Double = 0.0
    var maximum: Double
    var minimum: Double
    
    init(title: String, level: Int = 0, unit: String? = nil, defaultValue: Double, maximum: Double, minimum: Double) {
        self.unit = unit
        self.defaultValue = defaultValue
        self.maximum = maximum
        self.minimum = minimum
        super.init(title: title, level: level)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
        // TODO: Implement
    }
}
