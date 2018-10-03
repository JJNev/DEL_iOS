//
//  MatchOverviewTabBarController.swift
//  Die Ewige Liste
//
//  Created by Johannes Bagge on 21.09.18.
//  Copyright © 2018 jmb. All rights reserved.
//

import UIKit

class MatchOverviewTabBarController: UITabBarController {
    var list: List! {
        didSet {
            passList()
            setupUi()
        }
    }
    
    // MARK: Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        selectedIndex = 0
    }
    
    // MARK: Actions
    
    @objc private func newGameTapped() {
        if let timerViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "timerViewController") as? TimerViewController {
            timerViewController.list = list
            show(timerViewController, sender: self)
        }
    }
    
    // MARK: Helper
    
    private func passList() {
        for viewController in self.viewControllers! {
            if let gameHistoryViewController = viewController as? GameHistoryViewController {
                gameHistoryViewController.list = list
            } else if let settingsViewController = viewController as? SettingsViewController {
                settingsViewController.list = list
            }
        }
    }
    
    private func setupUi() {
        title = "\(list.playerOneName) vs \(list.playerTwoName)"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newGameTapped))
    }
}
