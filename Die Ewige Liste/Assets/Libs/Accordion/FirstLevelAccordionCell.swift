//
//  FirstLevelAccordionCell.swift
//  NIVEA
//
//  Created by Johannes Büro on 24.05.18.
//  Copyright © 2018 neveling.net. All rights reserved.
//

import UIKit

class FirstLevelAccordionCell: AccordionCell {
    @IBOutlet var headlineLabel: UILabel!
    @IBOutlet var arrowImageView: NIVImage!
    
    override var data: AccordionData? {
        didSet {
            headlineLabel.text = data?.text.uppercased()
        }
    }
}
