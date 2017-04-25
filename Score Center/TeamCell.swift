//
//  TeamCell.swift
//  Score Center
//
//  Created by Shayne Torres on 4/21/17.
//  Copyright © 2017 sptorres. All rights reserved.
//

import UIKit

class TeamCell: UITableViewCell {
    
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    
    var team : Team? {
        didSet {
            updateUI()
        }
    }
    
    var rank = Int()
    
    func updateUI(){
        guard let team = team else {return}
        rankLabel.text = rank.ordinalString()
        teamNameLabel.text = team.name
        pointsLabel.text = "\(team.score.toDecimalFormat())pts"
    }
    
}
