//
//  SecondLevelAccordionCell.swift
//  NIVEA
//
//  Created by Johannes Büro on 24.05.18.
//  Copyright © 2018 neveling.net. All rights reserved.
//

import Foundation

class SecondLevelAccordionCell: AccordionCell {
    override var data: AccordionData? {
        didSet {
            didSetData()
        }
    }
    
    func didSetData() {}
}
