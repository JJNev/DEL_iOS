//
//  GameHistoryViewController.swift
//  Die Ewige Liste
//
//  Created by Johannes Bagge on 29.07.18.
//  Copyright © 2018 jmb. All rights reserved.
//

import UIKit

class GameHistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var list: List! {
        didSet {
            setupUi()
        }
    }
    
    // MARK UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "gameHistoryCell") as? GameHistoryCell {
            cell.setGame(list.games[indexPath.row])
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    // MARK: Actions
    
    @IBAction func newGameTapped(_ sender: Any) {
        if let timerViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "timerViewController") as? TimerViewController {
            timerViewController.list = list
            show(timerViewController, sender: self)
        }
    }
    
    // MARK: Helper
    
    private func setupUi() {
        navigationItem.title = "\(list.playerOneName) vs \(list.playerTwoName)"
    }
}
