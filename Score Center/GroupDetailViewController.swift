//
//  GroupDetailViewController.swift
//  Score Center
//
//  Created by Shayne Torres on 3/9/17.
//  Copyright © 2017 sptorres. All rights reserved.
//

import UIKit

class GroupDetailViewController: UIViewController {
    
    var tableViewDelegate = GroupTableViewManager()

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableViewDelegate.tableView = tableView
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        self.tabBarController?.tabBar.isHidden = true
        tableViewDelegate.group = self.group
        tableViewDelegate.viewController = self
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
