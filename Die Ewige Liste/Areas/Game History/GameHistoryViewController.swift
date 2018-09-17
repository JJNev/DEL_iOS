//
//  GameHistoryViewController.swift
//  Die Ewige Liste
//
//  Created by Johannes Bagge on 29.07.18.
//  Copyright © 2018 jmb. All rights reserved.
//

import UIKit

class GameHistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var namePlayerTopLabel: UILabel!
    @IBOutlet weak var namePlayerBottomLabel: UILabel!
    @IBOutlet weak var pointsPlayerTopLabel: UILabel!
    @IBOutlet weak var pointsPlayerBottomLabel: UILabel!
    @IBOutlet weak var gameHistoryTableView: UITableView!
    
    var list: List! {
        didSet {
            setupUi()
        }
    }
    
    // MARK: Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUi()
    }
    
    // MARK: UITableViewDataSource
    
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
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard list != nil else {
            return
        }
        if editingStyle == .delete {
            list.removeGame(at: indexPath.row)
            updateUi()
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
        // Necessary hack to load view hierarchy.
        _ = view
        
        navigationItem.title = "\(list.playerOneName) vs \(list.playerTwoName)"
        namePlayerTopLabel.text = list.playerOneName
        namePlayerBottomLabel.text = list.playerTwoName
        updateUi()
    }
    
    private func updateUi() {
        pointsPlayerTopLabel.text = String(list.playerOnePoints)
        pointsPlayerBottomLabel.text = String(list.playerTwoPoints)
        gameHistoryTableView.reloadData()
    }
}
