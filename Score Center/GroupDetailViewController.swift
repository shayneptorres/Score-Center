//
//  GroupDetailViewController.swift
//  Score Center
//
//  Created by Shayne Torres on 3/9/17.
//  Copyright © 2017 sptorres. All rights reserved.
//

import UIKit

class GroupDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            var headerNib = UINib(nibName: "GroupHeaderCell", bundle: nil)
            tableView.register(headerNib, forCellReuseIdentifier: CellIdentifier.groupHeaderCell.rawValue)
            headerNib = UINib(nibName: "EditHeaderCell", bundle: nil)
            tableView.register(headerNib, forCellReuseIdentifier: CellIdentifier.editHeaderCell.rawValue)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(group.name)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let groupsUpdated = UserDefaults.standard.value(forKey: Update.groupsUpdated.rawValue) as? Bool else {
            return
        }
        if groupsUpdated {
            tableView.reloadData()
            UserDefaults.standard.setValue(false, forKey: Update.groupsUpdated.rawValue)
        }
    }
    
    var group = Group()
    
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
        default:
            break
        }
    }

}

// MARK: - TableView Methods
extension GroupDetailViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return group.teams.count
        } else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if headerDisplayMode == .displaying {
                guard let header = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.groupHeaderCell.rawValue) as? GroupHeaderCell else {
                    return UITableViewCell()
                }
                header.group = self.group
                header.delegate = self
                return header
            } else {
                guard let header = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.editHeaderCell.rawValue) as? EditHeaderCell else {
                    return UITableViewCell()
                }
                header.group = self.group
                header.delegate = self
                return header
            }
        case 1:
            let cell = UITableViewCell()
            cell.textLabel?.text = group.teams[indexPath.row].name
            return cell
        default:
            break
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return GroupHeaderCell.cellHeight
        case 1:
            return 50
        default:
            return 50
        }
    }
}

extension GroupDetailViewController : HeaderCellDelegate {
    func showEditMode() {
        headerDisplayMode = .editing
    }
    
    func showDisplayMode() {
        headerDisplayMode = .displaying
    }
}

extension GroupDetailViewController : AddObjectDelegate {
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
