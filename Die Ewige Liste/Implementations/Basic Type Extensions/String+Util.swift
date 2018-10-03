//
//  String+Util.swift
//  Die Ewige Liste
//
//  Created by Johannes Bagge on 12.09.18.
//  Copyright © 2018 jmb. All rights reserved.
//

import Foundation

extension String {
    func replace(_ oldString: String, with newString: String) -> String {
        return self.replacingOccurrences(of: oldString, with: newString, options: NSString.CompareOptions.literal, range: nil)
    }
    
    func contains(_ s: String) -> Bool {
        return (self.range(of: s) != nil) ? true : false
    }
    
    func trimmingWhitespaceFromBeginningAndEnd() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}
