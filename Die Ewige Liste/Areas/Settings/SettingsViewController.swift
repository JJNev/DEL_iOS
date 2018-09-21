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
    
    private var settingElements: [[SettingsElement]] = []
    var list: List! {
        didSet {
            // TODO: Init
        }
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSettings()
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingElements[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (settingElements[indexPath.section][indexPath.row]).type {
        case .stepper:
            if let stepperCell = tableView.dequeueReusableCell(withIdentifier: "stepperCell") as? StepperTableViewCell {
                stepperCell.setElement(settingElements[indexPath.section][indexPath.row])
                return stepperCell
            }
        case .switchControl:
            if let switchCell = tableView.dequeueReusableCell(withIdentifier: "switchCell") as? SwitchTableViewCell {
                switchCell.setElement(settingElements[indexPath.section][indexPath.row])
                return switchCell
            }
        }
        
        return UITableViewCell()
    }
    
    // MARK: Helper
    
    private func loadSettings() {
        let sectionOne = [
            SettingsElement(title: "Game Win Points", type: .stepper, level: 0, unit: nil, defaultValue: 3, maximum: 99, minimum: 1),
            SettingsElement(title: "Time Win Points", type: .stepper, level: 0, unit: nil, defaultValue: 1, maximum: 99, minimum: 0),
            SettingsElement(title: "Enable Challenge", type: .switchControl, level: 0, unit: nil, defaultValue: nil, maximum: nil, minimum: nil)
        ]
        settingElements.append(sectionOne)
        settingsTableView.reloadData()
    }
}
