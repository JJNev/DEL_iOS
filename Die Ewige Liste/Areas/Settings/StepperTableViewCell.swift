//
//  StepperTableViewCell.swift
//  Die Ewige Liste
//
//  Created by Johannes Bagge on 20.09.18.
//  Copyright © 2018 jmb. All rights reserved.
//

import UIKit

class StepperTableViewCell: SettingsTableViewCell {
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    private var element: StepperElement!
    
    // MARK: Public
    
    override func setElement(_ element: SettingsElement) {
        super.setElement(element)
        if let stepperElement = element as? StepperElement {
            self.element = stepperElement
            unitLabel.text = stepperElement.unit
            stepper.maximumValue = stepperElement.maximum
            stepper.minimumValue = stepperElement.minimum
            let value = getValue()
            valueLabel.text = String(Int(value))
            stepper.value = value
        }
    }
    
    // MARK: Actions
    
    @IBAction func stepperValueChanged(_ sender: Any) {
        valueLabel.text = String(Int(stepper.value))
        // TODO: Adjust settings
    }
    
    // MARK: Helper
    
    private func getValue() -> Double {
        if let userSetting = list.userSettings[element.title] {
            return userSetting
        } else {
            return element.defaultValue
        }
    }
}
