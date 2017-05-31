//
//  GroupsViewController.swift
//  Score Center
//
//  Created by Shayne Torres on 3/6/17.
//  Copyright © 2017 sptorres. All rights reserved.
//

import UIKit

class GroupsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!{
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            let nib = UINib(nibName: "GroupTableViewCell", bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: CellIdentifier.groupCell.rawValue)
        }
    }
    @IBOutlet weak var bottomButton: UIButton!
    @IBOutlet weak var backButton: UIBarButtonItem! {
        didSet {
        }
    }
    
    var groups = [Group]() {
        didSet {
            groups.sort { $0.updatedAt > $1.updatedAt}
            tableView.reloadData()
        }
    }
    var selectedGroup = Group()
    var manager = GroupsTableViewManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor.appBlue()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        guard let groupsUpdated = UserDefaults.standard.value(forKey: Update.groupsUpdated.rawValue) as? Bool else {
            return
        }
        if groupsUpdated {
            reloadData()
            UserDefaults.standard.setValue(false, forKey: Update.groupsUpdated.rawValue)
        }
    }
    
    
    @IBAction func addGroupButtonWasPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "showAddGroup", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "showAddGroup":
            self.tabBarController?.tabBar.isHidden = true
            guard let agvc = segue.destination as? AddObjectViewController  else {
                return
            }
            agvc.delegate = self
            agvc.addObjectValue = .group
        case "showGroupDetail":
            guard let gdvc = segue.destination as? GroupDetailViewController else {
                return
            }
            gdvc.group = selectedGroup
        default:
            break
        }
    }
    
}

extension GroupsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.groupCell.rawValue) as? GroupTableViewCell
        cell?.group = groups[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if groups[indexPath.row].id == UserDefaults.standard.integer(forKey: UserDefaultsKey.activeGroup.rawValue) {
            return false
        }
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            groups[indexPath.row].delete()
            reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedGroup = groups[indexPath.row]
        performSegue(withIdentifier: "showGroupDetail", sender: self)
    }
    
    
}

extension GroupsViewController : AddObjectDelegate {
    /**
     Retrieves all the groups in realm, assigns them to the groups data source, then reloads the tableview
     
     Shayne Torres
     
     - Parameters:
     -
     
     - Return:
     -
     */
    func reloadData(){
        guard let fetchedGroups = Group.getAll() as? [Group] else { return }
        groups = fetchedGroups
    }
    
    /**
     Unhides the tab bar in the case that it was hidden
     
     Shayne Torres
     
     - Parameters:
     -
     
     - Return:
     -
     */
    func showTabBar() {
        self.tabBarController?.tabBar.isHidden = false
    }
}
