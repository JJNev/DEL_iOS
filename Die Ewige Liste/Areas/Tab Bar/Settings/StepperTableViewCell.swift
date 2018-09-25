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
    
    private var item: StepperItem!
    
    // MARK: Public
    
    override func setItem(_ item: SettingsItem) {
        super.setItem(item)
        if let stepperItem = item as? StepperItem {
            self.item = stepperItem
            unitLabel.text = stepperItem.unit
            stepper.maximumValue = stepperItem.maximum
            stepper.minimumValue = stepperItem.minimum
            let value: Double = list.getSettingValue(for: item.key)
            valueLabel.text = String(Int(value))
            stepper.value = value
        }
    }
    
    // MARK: Actions
    
    @IBAction func stepperValueChanged(_ sender: Any) {
        valueLabel.text = String(Int(stepper.value))
        // TODO: Adjust settings
    }
}
