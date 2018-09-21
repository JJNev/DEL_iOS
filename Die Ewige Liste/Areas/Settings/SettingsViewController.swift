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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingElements.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingElements[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch settingElements[indexPath.section][indexPath.row].self {
        case is StepperElement:
            if let stepperCell = tableView.dequeueReusableCell(withIdentifier: "stepperCell") as? StepperTableViewCell {
                stepperCell.setElement(settingElements[indexPath.section][indexPath.row])
                return stepperCell
            }
        case is SwitchElement:
            if let switchCell = tableView.dequeueReusableCell(withIdentifier: "switchCell") as? SwitchTableViewCell {
                switchCell.setElement(settingElements[indexPath.section][indexPath.row])
                return switchCell
            }
        default:
            break
        }
        
        return UITableViewCell()
    }
    
    // MARK: Helper
    
    private func loadSettings() {
        let sectionOne = [
            StepperElement(title: "Game Win Points", defaultValue: 3, maximum: 99, minimum: 1),
            StepperElement(title: "Time Win Points", defaultValue: 1, maximum: 99, minimum: 0),
        ]
        let sectionTwo = [
            SwitchElement(title: "Enable Challenge", defaultValue: true)
        ]
        settingElements.append(sectionOne)
        settingElements.append(sectionTwo)
        settingsTableView.reloadData()
    }
}
