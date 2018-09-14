//
//  Int+Util.swift
//  Die Ewige Liste
//
//  Created by Johannes Bagge on 14.09.18.
//  Copyright © 2018 jmb. All rights reserved.
//

import Foundation

extension Int {
    func toTimeString() -> String {
        return String(format: "%02d:%02d", self / 60, self % 60)
    }
}
