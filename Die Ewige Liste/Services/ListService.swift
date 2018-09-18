//
//  ListService.swift
//  Die Ewige Liste
//
//  Created by Johannes Bagge on 28.08.18.
//  Copyright © 2018 jmb. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

class ListService {
    // TODO: Might replace this with dependency injection structure
    // A global singleton to be used from everywhere
    static let standard = ListService()
    
    private (set) var lists: [List] = []
    var dataLoadedNotificationIdentifier = "listDataLoaded"
    
    // MARK: Public
    
    func loadData() {
        loadListData()
    }

    func addList(_ list: List) {
        lists.append(list)
        sendDataLoadedNotification()
        saveLists()
    }
    
    func removeList(atIndex index: Int) {
        lists.remove(at: index)
        saveLists()
    }
    
    // MARK: Private
    
    private func sendDataLoadedNotification() {
        NotificationCenter.default.post(name: Notification.Name.init(dataLoadedNotificationIdentifier), object: nil)
    }

    private func loadListData() {
        // TODO: Load data
        lists = getLists() ?? []
        sendDataLoadedNotification()
    }
    
    // MARK: Debug
    
    private func addDummyData() {
        let list = List(playerOneName: "Tom", playerTwoName: "Johannes")
        let newGame = Game(state: .ended, dateStarted: Date(), dateEnded: Date(), totalTimeInSeconds: 178, playerTop: Player(color: .white, name: "Tom"), playerBottom: Player(color: .black, name: "Johannes"), winner: Player(color: .white, name: "Tom"), loser: Player(color: .black, name: "Johannes"), timeWinner: Player(color: .black, name: "Johannes"))
        list.addGame(newGame)
        lists.append(list)
    }
    
    // MARK: Persistence
    
    // TODO: Might make this private again + add an observer to the lists variable
    func saveLists() {
        if let listsData = try? PropertyListEncoder().encode(lists) {
            KeychainWrapper.standard.set(listsData, forKey: Constants.KeychainIdentifier.lists)
        }
    }
    
    private func getLists() -> [List]? {
        let listsData = KeychainWrapper.standard.data(forKey: Constants.KeychainIdentifier.lists)
        if let listsData = listsData {
            if let lists = try? PropertyListDecoder().decode(Array<List>.self, from: listsData) {
                return lists
            }
        }
        return nil
    }
}
