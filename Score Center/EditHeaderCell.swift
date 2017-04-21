//
//  EditHeaderCell.swift
//  Score Center
//
//  Created by Shayne Torres on 4/16/17.
//  Copyright © 2017 sptorres. All rights reserved.
//

import UIKit

class EditHeaderCell: UITableViewCell {
    
    @IBOutlet weak var groupNameTextField: UITextField!
    @IBOutlet weak var descriptionTextArea: UITextView!
    @IBOutlet weak var saveButton: UIButton!
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
        groupNameTextField.text = group?.name
        descriptionTextArea.text = group?.desc
    }
    
    @IBAction func save(_ sender: UIButton) {
        guard let delegate = delegate, var group = group else { return }
        group.update() {
            group.name = groupNameTextField.text!
            group.desc = descriptionTextArea.text
        }
        UserDefaults.standard.setValue(true, forKey: Update.groupsUpdated.rawValue)
        delegate.showDisplayMode()
    }
    
    
}
