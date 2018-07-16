//
//  RotatingLabel.swift
//  Die Ewige Liste
//
//  Created by Johannes Büro on 09.07.18.
//  Copyright © 2018 jmb. All rights reserved.
//

import UIKit

@IBDesignable
class RotatingLabel: UILabel {
    @IBInspectable var rotation: CGFloat = 0 {
        didSet {
            let radians = rotation / 180.0 * CGFloat(Double.pi)
            self.transform = CGAffineTransform(rotationAngle: radians)
        }
    }
}
