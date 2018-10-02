//
//  RotatingView.swift
//  Die Ewige Liste
//
//  Created by Johannes Bagge on 02.10.18.
//  Copyright © 2018 jmb. All rights reserved.
//

import UIKit

@IBDesignable
class RotatingView: UIView {
    @IBInspectable var rotation: CGFloat = 0 {
        didSet {
            let radians = rotation / 180.0 * CGFloat(Double.pi)
            self.transform = CGAffineTransform(rotationAngle: radians)
        }
    }
}
