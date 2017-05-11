//
//  GroupHeaderCell.swift
//  Score Center
//
//  Created by Shayne Torres on 4/15/17.
//  Copyright © 2017 sptorres. All rights reserved.
//

import UIKit

class GroupHeaderCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    var delegate : HeaderCellDelegate?
    
    class var cellHeight : CGFloat { get { return 145 } }
    
    var group : Group? {
        didSet {
            updateUI()
            selectionStyle = .none
        }
    }
    
    func updateUI(){
        guard group != nil else { return }
        groupNameLabel.text = group?.name
        descriptionLabel.text = group?.desc == "" ? "Description for group \(group!.name)" : group?.desc
    }
    
    @IBAction func edit(_ sender: UIButton) {
        guard let delegate = delegate else {return}
        delegate.showEditMode()
    }
    
    
}
