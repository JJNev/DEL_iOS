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
    
    // MARK: Public
    
    override func setElement(_ element: SettingsElement) {
        super.setElement(element)
        if let stepperElement = element as? StepperElement {
            valueLabel.text = String(Int(stepperElement.defaultValue))
            stepper.value = stepperElement.defaultValue
            unitLabel.text = stepperElement.unit
            stepper.maximumValue = stepperElement.maximum
            stepper.minimumValue = stepperElement.minimum
        }
    }
    
    // MARK: Actions
    
    @IBAction func stepperValueChanged(_ sender: Any) {
        valueLabel.text = String(Int(stepper.value))
        // TODO: Adjust settings
    }
}
