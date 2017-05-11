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
    
    @IBOutlet weak var addPresetPointsButton: UIButton! {
        didSet {
            addPresetPointsButton.applyShadow()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationItem.title = "Settings"
    }
    
    @IBAction func changeGroupButtonWasPressed(_ sender: UIButton) {
        performSegue(withIdentifier: SegueIdentifiers.showGroupsVC.rawValue, sender: self)
    }
    
    @IBAction func addPresetPointsButtonWasPressed(_ sender: UIButton) {
        performSegue(withIdentifier: SegueIdentifiers.showPresetPoints.rawValue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {return}
        switch identifier {
        case SegueIdentifiers.showPresetPoints.rawValue:
            guard let sppvc = segue.destination as? PresetPointsVC, let id = UserDefaults.standard.value(forKey: UserDefaultsKey.activeGroup.rawValue) as? Int,
                let actGroup = Group.getOne(withId: id) as? Group else {
                return
            }
            sppvc.group = actGroup
        default:
            break
        }
    }

}
