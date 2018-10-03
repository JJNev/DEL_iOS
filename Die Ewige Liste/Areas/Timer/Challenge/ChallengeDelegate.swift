//
//  ChallengeDelegate.swift
//  Die Ewige Liste
//
//  Created by Johannes Bagge on 02.10.18.
//  Copyright © 2018 jmb. All rights reserved.
//

import Foundation

protocol ChallengeDelegate {
    func challengeAccepted(accepted: Bool, by challengedPlayer: Player)
}
