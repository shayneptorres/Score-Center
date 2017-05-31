//
//  GroupDetailViewController.swift
//  Score Center
//
//  Created by Shayne Torres on 3/9/17.
//  Copyright © 2017 sptorres. All rights reserved.
//

import UIKit

class GroupDetailViewController: UIViewController {
    
    var tableViewDelegate = GroupDetailTableViewManager()

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableViewDelegate.tableView = tableView
        }
    }
    
    var onboarded : Bool {
        get {
            return UserDefaults.standard.bool(forKey: UserDefaultsKey.firstTimeGroupDetail.rawValue)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKey.firstTimeGroupDetail.rawValue)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        self.tabBarController?.tabBar.isHidden = true
        tableViewDelegate.group = self.group
        tableViewDelegate.viewController = self
        
        if !onboarded {
            let onboard = UIStoryboard(name: "Onboarding", bundle: nil)
            guard let messageVC = onboard.instantiateViewController(withIdentifier: "onboardMessage") as? OnboardingMessageVC else {
                return
            }
            messageVC.modalPresentationStyle = .overFullScreen
            messageVC.set(headerMessage: "Group Detail",
                          message: "Here is where you can manage specific groups. You can add teams to the group by tapping the button below. \n\n To add or subtract points from a team just tap it. \n\n If you want to make this group your 'Active Group' tap the edit button.",
                          buttonTitle: "Sweet!")
            messageVC.onboardingKey = UserDefaultsKey.firstTimeGroupDetail.rawValue
            navigationController?.present(messageVC, animated: true, completion: nil)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let groupsUpdated = UserDefaults.standard.value(forKey: Update.groupsUpdated.rawValue) as? Bool else {
            return
        }
        
        
        if groupsUpdated {
            reloadData()
            UserDefaults.standard.setValue(false, forKey: Update.groupsUpdated.rawValue)
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    var group = Group()
    var selectedTeam : Team?
    
    var headerDisplayMode : HeaderCellDisplayMode = .displaying {
        didSet {
            tableView.reloadData()
        }
    }
    
    @IBAction func addTeam(_ sender: UIButton) {
        performSegue(withIdentifier: "showAddObj", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "showAddObj":
            guard let aovc = segue.destination as? AddObjectViewController else {return}
            aovc.addObjectValue = .team
            aovc.group = self.group
            aovc.delegate = self
        case "showScoreEditor":
            guard let smvc = segue.destination as? ScoreManagerVC,
                let selectedTeam = tableViewDelegate.selectedTeam else {return}
            smvc.team = selectedTeam
            smvc.delegate = self
        default:
            break
        }
    }

}

extension GroupDetailViewController : AddObjectDelegate, ScoreManagerDelegate {
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
    }
}
