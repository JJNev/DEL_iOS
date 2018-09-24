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
    
    private var item: SwitchItem!
    
    // MARK: Public
    
    override func setItem(_ item: SettingsItem) {
        super.setItem(item)
        if let switchItem = item as? SwitchItem {
            self.item = switchItem
            switchControl.setOn(list.getValue(for: switchItem)!, animated: false)
        }
    }
    
    // MARK: Actions
    
    @IBAction func buttonValueChanged(_ sender: Any) {
        // TODO: Adjust settings
    }
}
