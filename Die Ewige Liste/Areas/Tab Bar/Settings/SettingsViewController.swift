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
    
    private var settingsItems: [[SettingsItem]] = []
    var list: List! {
        didSet {
            // Necessary hack to load view hierarchy.
            _ = view
            
            loadSettingItems()
        }
    }
    
    // MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingsItems.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsItems[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch settingsItems[indexPath.section][indexPath.row].self {
        case is StepperItem:
            if let stepperCell = tableView.dequeueReusableCell(withIdentifier: "stepperCell") as? StepperTableViewCell {
                stepperCell.list = list
                stepperCell.setItem(settingsItems[indexPath.section][indexPath.row])
                return stepperCell
            }
        case is SwitchItem:
            if let switchCell = tableView.dequeueReusableCell(withIdentifier: "switchCell") as? SwitchTableViewCell {
                switchCell.list = list
                switchCell.setItem(settingsItems[indexPath.section][indexPath.row])
                return switchCell
            }
        default:
            break
        }
        
        return UITableViewCell()
    }
    
    // MARK: Helper
    
    private func loadSettingItems() {
        let sectionOne = [
            StepperItem(title: "Game Win Points", key: Constants.Settings.Keys.gameWinPoints, maximum: 99, minimum: 1),
            StepperItem(title: "Time Win Points", key: Constants.Settings.Keys.timeWinPoints, maximum: 99, minimum: 0),
        ]
        let sectionTwo = [
            SwitchItem(title: "Enable Challenge", key: Constants.Settings.Keys.enableChallenge)
        ]
        settingsItems.append(sectionOne)
        settingsItems.append(sectionTwo)
        settingsTableView.reloadData()
    }
}
