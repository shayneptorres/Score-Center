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
    @IBOutlet weak var formContainer: UIView!
    
    var delegate : AddObjectDelegate?
    var addObjectValue = AddObjectValue.group
    var group : Group?
    var team : Team?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapDismiss))
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }
    
    func tapDismiss(){
        self.dismiss(animated: true, completion: {self.delegate?.showTabBar()})
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        objectNameTextField.becomeFirstResponder()
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
        objectNameTextField.resignFirstResponder()
        self.dismiss(animated: true, completion: {
            self.delegate?.reloadData()
            self.delegate?.showTabBar()
        })
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: {self.delegate?.showTabBar()})
    }
}

extension AddObjectViewController : UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: formContainer))! {
            return false
        }
        objectNameTextField.resignFirstResponder()
        return true
    }
}
