//
//  SettingsTableViewCell.swift
//  Die Ewige Liste
//
//  Created by Johannes Bagge on 20.09.18.
//  Copyright © 2018 jmb. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    
    var list: List!
    
    // MARK: Public
    
    func setElement(_ element: SettingsElement) {
        titleLabel.text = element.title
    }
}
