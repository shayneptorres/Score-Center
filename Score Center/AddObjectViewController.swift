//
//  AddObjectViewController.swift
//  Score Center
//
//  Created by Shayne Torres on 3/9/17.
//  Copyright © 2017 sptorres. All rights reserved.
//

import UIKit

protocol AddObjectDelegate {
    func reloadData()
    func showTabBar()
}

enum AddObjectValue {
    case group
    case team
}

class AddObjectViewController: UIViewController {

    @IBOutlet weak var objectNameTextField: AppTextField!
    
    var delegate : AddObjectDelegate?
    var addObjectValue = AddObjectValue.group
    var group : Group?
    var team : Team?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI(){
        switch addObjectValue {
        case .group:
            objectNameTextField.placeholder = "Group name"
        case .team:
            objectNameTextField.placeholder = "Team name"
        }
    }
    
    
    @IBAction func addButtonWasPressed(_ sender: UIButton) {
        if objectNameTextField.text == "" {return}
        switch addObjectValue {
        case .group:
            var newGroup = Group()
            newGroup.name = objectNameTextField.text!
            newGroup.save()
        case .team:
            var newTeam = Team()
            newTeam.name = objectNameTextField.text!
            newTeam.autoincrementID()
            group?.add(team: newTeam)
            UserDefaults.standard.setValue(true, forKey: Update.groupsUpdated.rawValue)
            break
        }
        self.dismiss(animated: true, completion: {
            self.delegate?.reloadData()
            self.delegate?.showTabBar()
        })
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: {self.delegate?.showTabBar()})
    }
    

}
