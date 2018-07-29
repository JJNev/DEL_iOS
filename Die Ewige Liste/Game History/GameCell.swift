//
//  GameCell.swift
//  Die Ewige Liste
//
//  Created by Johannes Bagge on 29.07.18.
//  Copyright © 2018 jmb. All rights reserved.
//

import UIKit

enum CellState {
    case expanded, collapsed
}

class GameCell: UITableViewCell {
    var cellState: CellState = .expanded
    
    // MARK: Helper
    
    private func switchCellState() {
        switch cellState {
        case .expanded:
            break
        case .collapsed:
            break
        }
    }
}
