//
//  GradientView.swift
//  Die Ewige Liste
//
//  Created by Johannes Bagge on 17.09.18.
//  Copyright © 2018 jmb. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIView {
    override class var layerClass: AnyClass {
        get {
            return CAGradientLayer.self
        }
    }
    
    @IBInspectable var isHorizontal: Bool = true {
        didSet {
            configureGradientLayer()
        }
    }
    
    @IBInspectable var gradientColor1: UIColor? {
        didSet {
            configureGradientLayer()
        }
    }
    
    @IBInspectable var gradientColor2: UIColor? {
        didSet {
            configureGradientLayer()
        }
    }
    
    @IBInspectable var gradientColor3: UIColor? {
        didSet {
            configureGradientLayer()
        }
    }
    
    @IBInspectable var gradientColor4: UIColor? {
        didSet {
            configureGradientLayer()
        }
    }
    
    @IBInspectable var gradientLocation1: CGFloat = 0.0 {
        didSet {
            configureGradientLayer()
        }
    }
    
    // Standard value 1.0 to fit the standard usecase of a two-colored gradience.
    @IBInspectable var gradientLocation2: CGFloat = 1.0 {
        didSet {
            configureGradientLayer()
        }
    }
    
    @IBInspectable var gradientLocation3: CGFloat = 0.0 {
        didSet {
            configureGradientLayer()
        }
    }
    
    @IBInspectable var gradientLocation4: CGFloat = 0.0 {
        didSet {
            configureGradientLayer()
        }
    }
    
    private func configureGradientLayer() {
        let gradientLayer = self.layer as! CAGradientLayer
        
        if (isHorizontal) {
            gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint = CGPoint (x: 1, y: 0.5)
        } else {
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
            gradientLayer.endPoint = CGPoint (x: 0.5, y: 1)
        }
        
        // Gather gradient locations.
        var locations = [NSNumber]()
        for gradientLocation in [gradientLocation1 as NSNumber, gradientLocation2 as NSNumber, gradientLocation3 as NSNumber, gradientLocation4 as NSNumber] {
            locations.append(gradientLocation)
        }
        
        // Gather gradient colors.
        var colors = [CGColor]()
        for var gradientColor in [gradientColor1, gradientColor2, gradientColor3, gradientColor4] where gradientColor != nil {
            // Replace the clearColor from interface builder with one that doesn't have a black channel which would lead to a grayish gradience otherwise.
            if let unwrappedGradientColor = gradientColor {
                // Get color components R G B A from the chosen color.
                let colorComponents = unwrappedGradientColor.cgColor.components!
                
                // Check if this is UIColor.clearColor().
                var isClearColor = true
                loop: for colorComponent in colorComponents {
                    if colorComponent != 0.0 {
                        isClearColor = false
                        break loop
                    }
                }
                
                // Replace the grayish clearColor with a real clear.
                if isClearColor {
                    gradientColor = UIColor.white.withAlphaComponent(0)
                }
            }
            
            colors.append(gradientColor!.cgColor)
        }
        
        // Make sure to only add a location if a corresponding color exists (and vice versa).
        if colors.count != locations.count {
            let minValues = min(colors.count, locations.count)
            
            if colors.count > minValues {
                colors = Array(colors.prefix(minValues))
            }
            
            if locations.count > minValues {
                locations = Array(locations.prefix(minValues))
            }
        }
        
        // Set gradient locations and colors.
        gradientLayer.locations = locations
        gradientLayer.colors = colors
    }
}
