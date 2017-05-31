//
//  GroupsTableViewManager.swift
//  Score Center
//
//  Created by Shayne Torres on 4/24/17.
//  Copyright © 2017 sptorres. All rights reserved.
//

import Foundation
import UIKit

class GroupsTableViewManager : NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var tableView : UITableView? {
        didSet {
            tableView?.delegate = self
            tableView?.dataSource = self
        }
    }
    var viewController : UIViewController?
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let groups = Group.getAll() as? [Group] else {return 0}
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.groupCell.rawValue) as? GroupTableViewCell,
        let groups = Group.getAll() as? [Group] else {
            return UITableViewCell()
        }
        cell.group = groups[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let groups = Group.getAll() as? [Group] else {
                return
        }
        Group.setActiveGroup(withId: groups[indexPath.row].id)
        viewController?.navigationController?.popToRootViewController(animated: true)
    }

}
