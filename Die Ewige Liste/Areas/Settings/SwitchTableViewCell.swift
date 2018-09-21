//
//  SwitchTableViewCell.swift
//  Die Ewige Liste
//
//  Created by Johannes Bagge on 20.09.18.
//  Copyright © 2018 jmb. All rights reserved.
//

import UIKit

class SwitchTableViewCell: SettingsTableViewCell {
    @IBOutlet weak var switchControl: UISwitch!
    
    // MARK: Public
    
    override func setElement(_ element: SettingsElement) {
        super.setElement(element)
        if let switchElement = element as? SwitchElement {
            switchControl.setOn(switchElement.defaultValue, animated: false)
        }
    }
}
