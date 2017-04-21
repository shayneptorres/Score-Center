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
    
    var group = Group()
    
    var headerDisplayMode : HeaderCellDisplayMode = .displaying {
        didSet {
            tableView.reloadData()
        }
    }
    
    

}

// MARK: - TableView Methods
extension GroupDetailViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
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
            break
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
