//
//  AddPresetScoreCell.swift
//  Score Center
//
//  Created by Shayne Torres on 4/28/17.
//  Copyright © 2017 sptorres. All rights reserved.
//

import UIKit

protocol PresetScoreCellDelegate {
    func add(score: Double)
}

class AddPresetScoreCell: UITableViewCell {
    
    var delegate : PresetScoreCellDelegate?

    @IBOutlet weak var pointsLabel: AppTextField!

    @IBAction func addPoints(_ sender: UIButton) {
        guard let points = Double(pointsLabel.text!) else {
            return
        }
        delegate?.add(score: points)
    }
    
    
}
