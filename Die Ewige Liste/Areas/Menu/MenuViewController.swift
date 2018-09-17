//
//  MenuViewController.swift
//  Die Ewige Liste
//
//  Created by Johannes Bagge on 28.08.18.
//  Copyright © 2018 jmb. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var playerOneTextField: UITextField!
    @IBOutlet weak var playerTwoTextField: UITextField!
    @IBOutlet weak var listTableView: UITableView!
    
    private lazy var listService: ListService = ListService()
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(listDataLoaded), name: Notification.Name.init(listService.dataLoadedNotificationIdentifier), object: nil)
        listService.loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listTableView.reloadData()
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listService.lists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "listCell") as? ListCell {
            cell.setList(listService.lists[indexPath.row])
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if let gameHistoryViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "gameHistoryViewController") as? GameHistoryViewController {
            gameHistoryViewController.list = listService.lists[indexPath.row]
            navigationController?.pushViewController(gameHistoryViewController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            listService.removeList(atIndex: indexPath.row)
            tableView.reloadData()
        }
    }
    
    // MARK: Actions
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func createNewListTapped(_ sender: Any) {
        guard playerOneTextField.text != "" && playerTwoTextField.text != "" else {
            return
        }
        listService.addList(List(playerOneName: playerOneTextField.text!, playerTwoName: playerTwoTextField.text!))
        view.endEditing(true)
        playerOneTextField.text = ""
        playerTwoTextField.text = ""
    }
    
    // MARK: Helper
    
    @objc private func listDataLoaded() {
        listTableView.reloadData()
    }
}
