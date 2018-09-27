//
//  NSLayoutConstraint+Util.swift
//  Die Ewige Liste
//
//  Created by Johannes Bagge on 27.09.18.
//  Copyright © 2018 jmb. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
    func constraintWithMultiplier(_ multiplier: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self.firstItem, attribute: self.firstAttribute, relatedBy: self.relation, toItem: self.secondItem, attribute: self.secondAttribute, multiplier: multiplier, constant: self.constant)
    }
}
