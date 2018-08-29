//
//  ListService.swift
//  Die Ewige Liste
//
//  Created by Johannes Bagge on 28.08.18.
//  Copyright © 2018 jmb. All rights reserved.
//

import Foundation

class ListService {
    private (set) var lists: [List] = []
    var dataLoadedNotificationIdentifier = "listDataLoaded"
    
    // MARK: Public
    
    func loadData() {
        loadListData()
    }

    func addList(list: List) {
        lists.append(list)
        sendDataLoadedNotification()
    }
    
    // MARK: Private
    
    private func sendDataLoadedNotification() {
        NotificationCenter.default.post(name: Notification.Name.init(dataLoadedNotificationIdentifier), object: nil)
    }

    private func loadListData() {
        // TODO: Load data
        addDummyData()
        sendDataLoadedNotification()
    }
    
    // MARK: Debug
    
    private func addDummyData() {
        lists.append(List(playerOneName: "Tom", playerTwoName: "Johannes"))
    }
}
