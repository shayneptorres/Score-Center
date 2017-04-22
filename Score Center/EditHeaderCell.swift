//
//  EditHeaderCell.swift
//  Score Center
//
//  Created by Shayne Torres on 4/16/17.
//  Copyright © 2017 sptorres. All rights reserved.
//

import UIKit

class EditHeaderCell: UITableViewCell, UITextViewDelegate {
    
    @IBOutlet weak var groupNameTextField: UITextField!
    @IBOutlet weak var descriptionTextArea: UITextView! {
        didSet {
            descriptionTextArea.delegate = self
        }
    }
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var makeActiveButton: UIButton!
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
        descriptionTextArea.text = (group?.desc != "" ? group?.desc : "Edit description")
        descriptionTextArea.layer.cornerRadius = 2
        descriptionTextArea.layer.masksToBounds = true
        
        let activeGroupID = UserDefaults.standard.value(forKey: UserDefaultsKey.activeGroup.rawValue) ?? -1
        print(activeGroupID)
        
        if activeGroupID as! Int == group?.id {
            makeActiveButton.isHidden = true
        } else {
            makeActiveButton.isHidden = false
        }
    }
    
    @IBAction func makeActive(_ sender: UIButton) {
        guard let delegate = delegate, let group = group else {return}
        UserDefaults.standard.set(group.id, forKey: UserDefaultsKey.activeGroup.rawValue)
        delegate.showDisplayMode()
    }
    
    @IBAction func save(_ sender: UIButton) {
        guard let delegate = delegate, var group = group else { return }
        group.update() {
            group.name = groupNameTextField.text!
            group.desc = descriptionTextArea.text == "Edit description" ? "" : descriptionTextArea.text
        }
        UserDefaults.standard.setValue(true, forKey: Update.groupsUpdated.rawValue)
        delegate.showDisplayMode()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if descriptionTextArea.text == "Edit description" { descriptionTextArea.text = "" }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if descriptionTextArea.text == "" { descriptionTextArea.text = "Edit description" }
    }
}
