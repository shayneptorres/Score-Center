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
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.backgroundColor = UIColor(netHex: 0xeeeeee)
            tableView.separatorStyle = .none
            var headerNib = UINib(nibName: "GroupHeaderCell", bundle: nil)
            tableView.register(headerNib, forCellReuseIdentifier: CellIdentifier.groupHeaderCell.rawValue)
            headerNib = UINib(nibName: "EditHeaderCell", bundle: nil)
            tableView.register(headerNib, forCellReuseIdentifier: CellIdentifier.editHeaderCell.rawValue)
            headerNib = UINib(nibName: "TeamCell", bundle: nil)
            tableView.register(headerNib, forCellReuseIdentifier: CellIdentifier.teamCell.rawValue)
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
//        guard let id = UserDefaults.standard.value(forKey: UserDefaultsKey.activeGroup.rawValue) as? Int,
//            let group = Group.getOne(withId: id) as? Group else {
//            return
//        }
//        self.group = group
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let id = UserDefaults.standard.value(forKey: UserDefaultsKey.activeGroup.rawValue) as? Int,
            let group = Group.getOne(withId: id) as? Group else {
                return
        }
        self.group = group
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "showAddObj":
            guard let aovc = segue.destination as? AddObjectViewController else {return}
            aovc.addObjectValue = .team
            aovc.group = self.group
            aovc.delegate = self
        case "showScoreEditor":
            guard let smvc = segue.destination as? ScoreManagerVC, let selectedTeam = selectedTeam else {return}
            smvc.team = selectedTeam
            smvc.delegate = self
        default:
            break
        }
    }
}

// MARK: - TableView Methods
extension ActiveGroupVC : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let group = group else {return 0}
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
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.teamCell.rawValue) as? TeamCell,
            let group = group else {return UITableViewCell()}
            cell.team = group.teams[indexPath.row]
            return cell
        default:
            break
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 1 {
            let v = UIView()
            v.backgroundColor = UIColor(netHex: 0xeeeeee)
            return v
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let group = group else {return}
        switch indexPath.section {
        case 0:
            break
        case 1:
            selectedTeam = group.teams[indexPath.row]
            performSegue(withIdentifier: "showScoreEditor", sender: self)
        default: break
        }
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard let group = group else {return}
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            group.teams[indexPath.row].delete()
            UserDefaults.standard.setValue(true, forKey: Update.groupsUpdated.rawValue)
            tableView.reloadData()
        }
    }
}

extension ActiveGroupVC : HeaderCellDelegate {
    func showEditMode() {
        headerDisplayMode = .editing
    }
    
    func showDisplayMode() {
        headerDisplayMode = .displaying
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
