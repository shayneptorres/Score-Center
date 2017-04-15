//
//  GroupHeaderCell.swift
//  Score Center
//
//  Created by Shayne Torres on 4/15/17.
//  Copyright © 2017 sptorres. All rights reserved.
//

import UIKit

class GroupHeaderCell: UITableViewCell {
    
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var totalPointsLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    var group : Group? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI(){
        guard group != nil else { return }
        groupNameLabel.text = group?.name
        descriptionLabel.text = group?.desc
        var totalPoints : Double = 0
        group?.teams.forEach({ totalPoints += $0.score })
    }
    
}
