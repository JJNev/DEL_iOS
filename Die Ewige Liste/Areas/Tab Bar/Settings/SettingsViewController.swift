//
//  SettingsViewController.swift
//  Die Ewige Liste
//
//  Created by Johannes Bagge on 19.09.18.
//  Copyright © 2018 jmb. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var settingsTableView: UITableView!
    
    private var settingsElements: [[SettingsElement]] = []
    var list: List! {
        didSet {
            // Necessary hack to load view hierarchy.
            _ = view
            
            loadSettingElements()
        }
    }
    
    // MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingsElements.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsElements[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch settingsElements[indexPath.section][indexPath.row].self {
        case is StepperElement:
            if let stepperCell = tableView.dequeueReusableCell(withIdentifier: "stepperCell") as? StepperTableViewCell {
                stepperCell.list = list
                stepperCell.setElement(settingsElements[indexPath.section][indexPath.row])
                return stepperCell
            }
        case is SwitchElement:
            if let switchCell = tableView.dequeueReusableCell(withIdentifier: "switchCell") as? SwitchTableViewCell {
                switchCell.list = list
                switchCell.setElement(settingsElements[indexPath.section][indexPath.row])
                return switchCell
            }
        default:
            break
        }
        
        return UITableViewCell()
    }
    
    // MARK: Helper
    
    private func loadSettingElements() {
        let sectionOne = [
            StepperElement(title: "Game Win Points", key: "gameWinPoints", defaultValue: 3, maximum: 99, minimum: 1),
            StepperElement(title: "Time Win Points", key: "timeWinPoints", defaultValue: 1, maximum: 99, minimum: 0),
        ]
        let sectionTwo = [
            SwitchElement(title: "Enable Challenge", key: "enableChallenge", defaultValue: true)
        ]
        settingsElements.append(sectionOne)
        settingsElements.append(sectionTwo)
        settingsTableView.reloadData()
    }
}
