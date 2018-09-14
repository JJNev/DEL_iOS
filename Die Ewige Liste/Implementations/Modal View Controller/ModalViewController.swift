//
//  ModalViewController.swift
//  Die Ewige Liste
//
//  Created by Johannes Bagge on 14.09.18.
//  Copyright © 2018 jmb. All rights reserved.
//

import UIKit

class ModalViewController: UIViewController {
    
    // MARK: Public
    
    func hide() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Actions
    
    @IBAction func singleTapRecognized(_ sender: UITapGestureRecognizer) {
        // Make sure to only dismiss the modalView if the outside area was tapped. Do nothing if the dialog box was tapped.
        let recognizedPoint = sender.location(in: view)
        let hitView = view.hitTest(recognizedPoint, with: nil)
        
        if hitView == view {
            hide()
        }
    }
}
