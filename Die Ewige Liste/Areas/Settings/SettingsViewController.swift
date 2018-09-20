//
//  SettingsViewController.swift
//  Die Ewige Liste
//
//  Created by Johannes Bagge on 19.09.18.
//  Copyright © 2018 jmb. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let settingsElementsRoot = [
        [
            "title": "Game Win Points",
            "type": "stepper"
        ],
        [
            "title": "Time Win Points",
            "type": "stepper"
        ],
        [
            "title": "Enable Challenge",
            "type": "Bool",
            "children": [
                [
                    "title": "Challenge Win Penalty",
                    "type": "Stepper"
                ],
                [
                    "title": "Challenge Loss Penalty",
                    "type": "Stepper"
                ]
            ]
        ]
    ]
    
    let settingElements: [[SettingsElement]] = []
    
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingElements[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (settingElements[indexPath.section][indexPath.row]).type {
        case .stepper:
            if let stepperCell = tableView.dequeueReusableCell(withIdentifier: "stepperCell") as? StepperTableViewCell {
                // TODO: Init cell
                return stepperCell
            }
        case .switchControl:
            if let switchCell = tableView.dequeueReusableCell(withIdentifier: "switchCell") as? SwitchTableViewCell {
                // TODO: Init cell
                return switchCell
            }
        }
        
        return UITableViewCell()
    }
}
