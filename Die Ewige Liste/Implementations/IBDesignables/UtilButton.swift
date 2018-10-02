//
//  UtilButton.swift
//  Die Ewige Liste
//
//  Created by Johannes Bagge on 26.09.18.
//  Copyright © 2018 jmb. All rights reserved.
//

import UIKit

@IBDesignable
class UtilButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    
    @IBInspectable var circular: Bool = false {
        didSet {
            checkCircular()
        }
    }
    
    @IBInspectable var rotation: CGFloat = 0 {
        didSet {
            let radians = rotation / 180.0 * CGFloat(Double.pi)
            self.transform = CGAffineTransform(rotationAngle: radians)
        }
    }
    
    // MARK: Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        checkCircular()
    }
    
    // MARK: Helper
    
    private func checkCircular() {
        if circular {
            cornerRadius = frame.width / 2
        }
    }
}
