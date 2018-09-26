//
//  BorderView.swift
//  Die Ewige Liste
//
//  Created by Johannes Bagge on 13.09.18.
//  Copyright © 2018 jmb. All rights reserved.
//

import UIKit

@IBDesignable
class BorderView: UIView {
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
            if borderColor != nil {
                layer.borderColor = borderColor?.cgColor
            }
        }
    }
}
