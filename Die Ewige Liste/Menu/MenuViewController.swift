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
    
    
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listService.lists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "listCell") as? ListCell {
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let list = listService.lists[indexPath.row]
        // TODO Load something ..?
    }
    
    // MARK: Actions
    
    @IBAction func createNewListTapped(_ sender: Any) {
        guard playerOneTextField.text != "" && playerTwoTextField.text != "" else {
            return
        }
        listService.lists.append(List(playerOneName: playerTwoTextField.text!, playerTwoName: playerTwoTextField.text!))
        listTableView.reloadData()
    }
}
