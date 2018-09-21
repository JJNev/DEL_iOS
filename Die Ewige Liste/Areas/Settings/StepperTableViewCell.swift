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
        if let defaultValue = element.defaultValue as? Int {
            valueLabel.text = String(defaultValue)
            stepper.value = Double(defaultValue)
        }
        unitLabel.text = element.unit
        stepper.maximumValue = element.maximum ?? 10
        stepper.minimumValue = element.minimum ?? 0
    }
    
    // MARK: Actions
    
    @IBAction func stepperValueChanged(_ sender: Any) {
        valueLabel.text = String(Int(stepper.value))
    }
}
