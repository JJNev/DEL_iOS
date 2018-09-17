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

    func addList(_ list: List) {
        lists.append(list)
        sendDataLoadedNotification()
    }
    
    func removeList(atIndex index: Int) {
        lists.remove(at: index)
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
        let list = List(playerOneName: "Tom", playerTwoName: "Johannes")
        let newGame = Game(state: .ended, dateStarted: Date(), dateEnded: Date(), totalTimeInSeconds: 178, playerTop: Player(color: .white, name: "Tom"), playerBottom: Player(color: .black, name: "Johannes"), winner: Player(color: .white, name: "Tom"), loser: Player(color: .black, name: "Johannes"), timeWinner: Player(color: .black, name: "Johannes"), settings: nil)
        list.addGame(newGame)
        lists.append(list)
    }
}
