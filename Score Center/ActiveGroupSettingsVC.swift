//
//  ActiveGroupSettingsVC.swift
//  Score Center
//
//  Created by Shayne Torres on 4/24/17.
//  Copyright © 2017 sptorres. All rights reserved.
//

import UIKit

class ActiveGroupSettingsVC: UIViewController {
    
    @IBOutlet weak var changeGroupButton: UIButton! {
        didSet {
            changeGroupButton.applyShadow()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationItem.title = "Settings"
    }
    
    @IBAction func changeGroupButtonWasPressed(_ sender: UIButton) {
        performSegue(withIdentifier: SegueIdentifiers.showGroupsVC.rawValue, sender: self)
    }
    

}
