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
    
    var lists: [List] = [] {
        didSet {
            saveLists()
            sendDataLoadedNotification()
        }
    }
    var dataLoadedNotificationIdentifier = "listDataLoaded"
    
    // MARK: Public
    
    func loadData() {
        loadListData()
    }
    
    func saveLists() {
        if let listsData = try? PropertyListEncoder().encode(lists) {
            KeychainWrapper.standard.set(listsData, forKey: Constants.KeychainIdentifier.lists)
        }
    }
    
    // MARK: Helper
    
    private func loadListData() {
        lists = getLists() ?? []
        sendDataLoadedNotification()
    }
    
    private func sendDataLoadedNotification() {
        NotificationCenter.default.post(name: Notification.Name.init(dataLoadedNotificationIdentifier), object: nil)
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
