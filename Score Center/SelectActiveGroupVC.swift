//
//  SelectActiveGroupVC.swift
//  Score Center
//
//  Created by Shayne Torres on 4/24/17.
//  Copyright © 2017 sptorres. All rights reserved.
//

import UIKit

class SelectActiveGroupVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!{
        didSet {
            tableView.delegate = groupsTableViewManager
            tableView.dataSource = groupsTableViewManager
            tableView.separatorStyle = .none
            let nib = UINib(nibName: "GroupTableViewCell", bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: CellIdentifier.groupCell.rawValue)
        }
    }
    
    var groupsTableViewManager = GroupsTableViewManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groupsTableViewManager.viewController = self
    }
    
    

}
