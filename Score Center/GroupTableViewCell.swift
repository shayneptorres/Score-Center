//
//  GroupTableViewCell.swift
//  Score Center
//
//  Created by Shayne Torres on 3/6/17.
//  Copyright © 2017 sptorres. All rights reserved.
//

import UIKit

class GroupTableViewCell: UITableViewCell {
    
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var bodyView: UIView!
    
    var group = Group() {
        didSet{
            updateUI()
        }
    }
    
    /**
     Updates the UI for the cell to display the group information
     
     Shayne Torres
     
     - Parameters:
     -
     
     - Return:
     -
     */
    func updateUI(){
        groupNameLabel.text = group.name
        countLabel.text = "\(group.teams.count)"
    }
    
    func addShadow(){
        bodyView.applyShadow()
    }
    
}
