//
//  AccordionViewController.swift
//  NIVEA
//
//  Created by Johannes Büro on 20.06.18.
//  Copyright © 2018 neveling.net. All rights reserved.
//

import UIKit

class AccordionViewController: UIViewController, UITableViewDelegate {
    var displayedRows: [AccordionData] = []
    // Holds (index, parent)
    var lastCellExpanded : (Int, Int) = (-1, -1)
    let noCellExpanded = (-1, -1)
    
    // Settings
    var allowMultipleExpandedCells = true
    var rowAnimation: UITableViewRowAnimation = .fade
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard tableView.cellForRow(at: indexPath) is FirstLevelAccordionCell else {
            return
        }
        
        tableView.beginUpdates()
        updateCells(forIndexPath: indexPath, inTableView: tableView)
        tableView.endUpdates()
    }
    
    // Helper
    
    private func collapseItem(atIndexPath indexPath: IndexPath, inTableView tableView: UITableView) {
        let selectedDataSet = displayedRows[indexPath.row]
        let range = indexPath.row + 1...indexPath.row + selectedDataSet.children!.count
        let indexPaths = range.map{return IndexPath(row: $0, section: indexPath.section)}
        
        // If the cell is currently allocated, change the arrow's state
        if let cell = tableView.cellForRow(at: indexPath), cell is FirstLevelAccordionCell {
            (cell as! FirstLevelAccordionCell).arrowImageView.selected = false
        }
        selectedDataSet.isExpanded = false
        tableView.deleteRows(at: indexPaths, with: rowAnimation)
        displayedRows.removeSubrange(range)
        
    }
    
    private func expandItem(atIndexPath indexPath: IndexPath, inTableView tableView: UITableView) {
        let selectedDataSet = displayedRows[indexPath.row]
        let range = indexPath.row + 1...indexPath.row + selectedDataSet.children!.count
        let indexPaths = range.map{return IndexPath(row: $0, section: indexPath.section)}
        
        // If the cell is currently allocated, change the arrow's state
        if let cell = tableView.cellForRow(at: indexPath), cell is FirstLevelAccordionCell {
            (cell as! FirstLevelAccordionCell).arrowImageView.selected = true
        }
        selectedDataSet.isExpanded = true
        tableView.insertRows(at: indexPaths, with: rowAnimation)
        displayedRows.insert(contentsOf: selectedDataSet.children! as [AccordionData], at: indexPath.row + 1)
    }
    
    private func updateCells(forIndexPath indexPath: IndexPath, inTableView tableView: UITableView) {
        let selectedDataSet = displayedRows[indexPath.row]
        if selectedDataSet.isExpanded {
            collapseItem(atIndexPath: indexPath, inTableView: tableView)
            lastCellExpanded = noCellExpanded
        } else {
            if !allowMultipleExpandedCells {
                if lastCellExpanded != noCellExpanded {
                    let (indexOfCellExpanded, parentOfCellExpanded) = lastCellExpanded
                    collapseItem(atIndexPath: IndexPath(row: indexOfCellExpanded, section: 0), inTableView: tableView)
                    if indexPath.row > parentOfCellExpanded {
                        let newIndex = indexPath.row - (displayedRows[parentOfCellExpanded].children != nil ? displayedRows[parentOfCellExpanded].children!.count : 0)
                        expandItem(atIndexPath: IndexPath(row: newIndex, section: indexPath.section), inTableView: tableView)
                        lastCellExpanded = (newIndex, indexPath.row)
                    } else {
                        expandItem(atIndexPath: indexPath, inTableView: tableView)
                        lastCellExpanded = (indexPath.row, indexPath.row)
                    }
                } else {
                    expandItem(atIndexPath: indexPath, inTableView: tableView)
                    lastCellExpanded = (indexPath.row, indexPath.row)
                }
            } else {
                expandItem(atIndexPath: indexPath, inTableView: tableView)
            }
        }
    }
}
