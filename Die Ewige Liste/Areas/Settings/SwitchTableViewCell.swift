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
    
    private var element: SwitchElement!
    
    // MARK: Public
    
    override func setElement(_ element: SettingsElement) {
        super.setElement(element)
        if let switchElement = element as? SwitchElement {
            self.element = switchElement
            switchControl.setOn(getValue(), animated: false)
        }
    }
    
    // MARK: Actions
    
    @IBAction func buttonValueChanged(_ sender: Any) {
        // TODO: Adjust settings
    }
    
    // MARK: Helper
    
    private func getValue() -> Bool {
        if let userSetting = list.userSettings[element.title] {
            return userSetting.toBool()
        } else {
            return element.defaultValue
        }
    }
}
