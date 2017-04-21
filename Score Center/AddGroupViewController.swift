//
//  AddGroupViewController.swift
//  Score Center
//
//  Created by Shayne Torres on 3/7/17.
//  Copyright © 2017 sptorres. All rights reserved.
//

import UIKit

protocol AddGroupDelegate {
    func reloadGroups()
    func showTabBar()
}

class AddGroupViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var groupNameLabel: AppTextField!
    
    var delegate : AddGroupDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func addButtonWasPressed(_ sender: UIButton) {
        if groupNameLabel.text == "" {
        
        } else {
            var newGroup = Group()
            newGroup.name = groupNameLabel.text!
            newGroup.save()
            delegate?.reloadGroups()
            delegate?.showTabBar()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelXButtonWasPressed(_ sender: UIButton) {
        delegate?.showTabBar()
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
}
