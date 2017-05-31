//
//  GroupDetailTableView.swift
//  Score Center
//
//  Created by Shayne Torres on 4/22/17.
//  Copyright © 2017 sptorres. All rights reserved.
//

import UIKit

class GroupDetailTableViewManager : NSObject, UITableViewDelegate, UITableViewDataSource {
    
    override init() {
        super.init()
    }
    
    var tableView = UITableView() {
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
    
    
    var group : Group? {
        didSet {
            tableView.reloadData()
        }
    }
    var headerDisplayMode = HeaderCellDisplayMode.displaying {
        didSet {
            tableView.reloadData()
        }
    }
    var selectedTeam : Team?
    var viewController : UIViewController?
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return group?.teams.count ?? 0
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
                header.group = group
                header.delegate = self
                header.containerView.applyShadow()
                return header
            } else {
                guard let header = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.editHeaderCell.rawValue) as? EditHeaderCell else {
                    return UITableViewCell()
                }
                header.group = group
                header.delegate = self
                header.containerView.applyShadow()
                return header
            }
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.teamCell.rawValue) as? TeamCell else {return UITableViewCell()}
            cell.rank = indexPath.row + 1
            cell.team = group?.teams.sorted(by: {$0.score > $1.score})[indexPath.row]
            cell.containerView.applyShadow()
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
        switch indexPath.section {
        case 0:
            break
        case 1:
            selectedTeam = group?.teams.sorted(by: {$0.score > $1.score})[indexPath.row]
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "try") as! ScoreManagerVC
            vc.team = selectedTeam
            vc.group = group
            vc.delegate = (viewController as! ScoreManagerDelegate)
            viewController?.tabBarController?.present(vc, animated: true, completion: nil)
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
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            group?.teams[indexPath.row].delete()
            UserDefaults.standard.setValue(true, forKey: Update.groupsUpdated.rawValue)
            self.tableView.reloadData()
        }
    }
}

extension GroupDetailTableViewManager : HeaderCellDelegate {
    func showEditMode() {
        headerDisplayMode = .editing
    }
    
    func showDisplayMode() {
        headerDisplayMode = .displaying
    }
}
