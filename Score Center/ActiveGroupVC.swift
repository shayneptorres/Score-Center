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
        }
    }
    
    var tableViewDelegate = GroupTableViewManager()
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableViewDelegate.tableView = tableView
        }
    }
    
    var selectedTeam : Team?
    
    var headerDisplayMode : HeaderCellDisplayMode = .displaying {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isHidden = true
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
    }
}
