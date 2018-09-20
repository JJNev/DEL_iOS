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
        valueLabel.text = element.defaultValue as? String ?? ""
        unitLabel.text = element.unit
        stepper.maximumValue = element.maximum ?? 10
        stepper.minimumValue = element.minimum ?? 0
    }
}
