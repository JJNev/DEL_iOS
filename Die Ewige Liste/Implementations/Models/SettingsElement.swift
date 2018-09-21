//
//  SettingsElement.swift
//  Die Ewige Liste
//
//  Created by Johannes Bagge on 20.09.18.
//  Copyright © 2018 jmb. All rights reserved.
//

import Foundation

struct SettingsElement {
    enum SettingType: String {
        case stepper, switchControl
    }
    
    // MARK: -
    
    var title: String!
    var type: SettingType = .stepper
    var level: Int = 0
    var unit: String?
    var defaultValue: Any?
    var maximum: Double?
    var minimum: Double?
}
