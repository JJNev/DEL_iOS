//
//  AccordionData.swift
//  NIVEA
//
//  Created by Johannes Büro on 28.05.18.
//  Copyright © 2018 neveling.net. All rights reserved.
//

import Foundation

class AccordionData {
    let text: String
    let children: [AccordionData]?
    var isExpanded = false
    
    init(text: String, children: [AccordionData]?) {
        self.text = text
        self.children = children
    }
}
