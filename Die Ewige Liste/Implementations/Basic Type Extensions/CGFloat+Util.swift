//
//  CGFloat+Util.swift
//  Die Ewige Liste
//
//  Created by Johannes Bagge on 14.09.18.
//  Copyright © 2018 jmb. All rights reserved.
//

import UIKit

extension CGFloat {
    // Returns value as a string of the format "minutes:seconds" or "minutes:seconds:milliseconds", if desired.
    func secondsToTimeString(includingMilliseconds: Bool = false) -> String {
        let (minutes, seconds, milliseconds) = secondsToTimeTriple()
        if includingMilliseconds {
            return String(format: "%02d:%02d:%02d", minutes, seconds, milliseconds)
        } else {
            return String(format: "%02d:%02d", minutes, seconds)
        }
    }
    
    // Returns value as a triple of the format (minutes, seconds, milliseconds).
    func secondsToTimeTriple() -> (Int, Int, Int) {
        let minutes = Int(self) / 60
        let seconds = Int(self) % 60
        let milliseconds = Int((self * 100).truncatingRemainder(dividingBy: 100))
        return (minutes, seconds, milliseconds)
    }
}
