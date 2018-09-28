//
//  ChallengeViewController.swift
//  Die Ewige Liste
//
//  Created by Johannes Bagge on 28.09.18.
//  Copyright © 2018 jmb. All rights reserved.
//

import UIKit

class ChallengeViewController: UIViewController {
    @IBOutlet weak var separatorStaticContainer: UIView!
    @IBOutlet weak var separatorWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var topStaticContainer: UIView!
    @IBOutlet weak var topSlideConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomStaticContainer: UIView!
    @IBOutlet weak var bottomSlideConstraint: NSLayoutConstraint!
    @IBOutlet weak var buttonContainer: UIView!
    
    @IBOutlet var labels: [UILabel]!
    @IBOutlet var buttons: [BorderButton]!
    @IBOutlet weak var separatorView: GradientView!
    
    var colorScheme: Color = .black {
        didSet {
            adjustColorScheme()
        }
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareAnimation()
    }
    
    // MARK: Public
    
    func startAnimation() {
        animateSeparator()
        animateTopLabel()
        animateBottomLabel()
        animateButtonContainer()
    }
    
    // MARK: Helper
    
    private func adjustColorScheme() {
        let newColor = UIColor.white
        
        for label in labels {
            label.textColor = newColor
        }
        
        for button in buttons {
            button.borderColor = newColor
            // TODO: Which one?
//            button.imageView?.tintColor = newColor
            button.tintColor = newColor
        }
        
        separatorView.gradientColor2 = newColor
        separatorView.gradientColor3 = newColor
    }
    
    private func prepareAnimation() {
        separatorWidthConstraint.constant = 0
        topSlideConstraint.constant = topStaticContainer.frame.height
        bottomSlideConstraint.constant = bottomStaticContainer.frame.height
        topStaticContainer.alpha = 0
        bottomStaticContainer.alpha = 0
        buttonContainer.alpha = 0
    }
    
    private func animateSeparator() {
        separatorWidthConstraint.constant = separatorStaticContainer.frame.width
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.separatorStaticContainer.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func animateTopLabel() {
        topSlideConstraint.constant = 0
        UIView.animate(withDuration: 0.3, delay: 0.2, options: .curveEaseOut, animations: {
            self.topStaticContainer.layoutIfNeeded()
            self.topStaticContainer.alpha = 1.0
        }, completion: nil)
    }
    
    private func animateBottomLabel() {
        bottomSlideConstraint.constant = 0
        UIView.animate(withDuration: 0.3, delay: 0.65, options: .curveEaseOut, animations: {
            self.bottomStaticContainer.layoutIfNeeded()
            self.bottomStaticContainer.alpha = 1.0
        }, completion: nil)
    }
    
    private func animateButtonContainer() {
        UIView.animate(withDuration: 0.3, delay: 1.2, options: .curveLinear, animations: {
            self.buttonContainer.alpha = 1.0
        }, completion: nil)
    }
}
