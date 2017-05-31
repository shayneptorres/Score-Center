//
//  ActiveGroupVC.swift
//  Score Center
//
//  Created by Shayne Torres on 4/21/17.
//  Copyright © 2017 sptorres. All rights reserved.
//

import UIKit

class ActiveGroupVC: UIViewController {
    
    var group : Group? {
        didSet {
            tableView.reloadData()
            tableView.isHidden = false
            activeGroupMessageLabel.isHidden = true
        }
    }
    
    var onboarded : Bool {
        get {
            return UserDefaults.standard.bool(forKey: UserDefaultsKey.firstTimeActiveGroup.rawValue)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKey.firstTimeActiveGroup.rawValue)
        }
    }
    
    var tableViewDelegate = GroupDetailTableViewManager()
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableViewDelegate.tableView = tableView
        }
    }
    @IBOutlet weak var activeGroupMessageLabel: UILabel!
    
    var selectedTeam : Team?
    
    var headerDisplayMode : HeaderCellDisplayMode = .displaying {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isHidden = true
        activeGroupMessageLabel.isHidden = false
        self.navigationController?.navigationBar.barTintColor = UIColor.appBlue()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        if !onboarded {
            let onboard = UIStoryboard(name: "Onboarding", bundle: nil)
            guard let messageVC = onboard.instantiateViewController(withIdentifier: "onboardMessage") as? OnboardingMessageVC else {
                return
            }
            messageVC.modalPresentationStyle = .overFullScreen
            messageVC.set(headerMessage: "Welcome to Score Center",
                          message: "Score Center is the place you can manage of all your score tracking needs. To get started head over to the 'Groups' tab and add a group.\n\nAfter that make sure you return here to set your 'Active Group'.\n\nSetting an Active Group allows you to quickly manage team scores",
                          buttonTitle: "Got it!")
            messageVC.onboardingKey = UserDefaultsKey.firstTimeActiveGroup.rawValue
            navigationController?.present(messageVC, animated: true, completion: nil)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let id = UserDefaults.standard.value(forKey: UserDefaultsKey.activeGroup.rawValue) as? Int,
            let group = Group.getOne(withId: id) as? Group else {
                return
        }
        self.group = group
        tableViewDelegate.group = self.group
        tableViewDelegate.viewController = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "showAddObj":
            guard let aovc = segue.destination as? AddObjectViewController else {return}
            aovc.addObjectValue = .team
            aovc.group = self.group
            aovc.delegate = self
        default:
            break
        }
    }
    
    @IBAction func settingsButtonWasPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: SegueIdentifiers.showActiveGroupSettings.rawValue, sender: self)
    }
    
}

extension ActiveGroupVC : AddObjectDelegate, ScoreManagerDelegate {
    /**
     Retrieves all the groups in realm, assigns them to the groups data source, then reloads the tableview
     
     Shayne Torres
     
     - Parameters:
     -
     
     - Return:
     -
     */
    func reloadData(){
        tableView.reloadData()
    }
    
    func showTabBar() {
        tabBarController?.tabBar.isHidden = false
    }
}
