//
//  GroupDetailViewController.swift
//  Score Center
//
//  Created by Shayne Torres on 3/9/17.
//  Copyright © 2017 sptorres. All rights reserved.
//

import UIKit

class GroupDetailViewController: UIViewController {
    
    let GROUP_HEADER_CELL = "GROUP_HEADER_CELL"

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            let headerNib = UINib(nibName: "GroupHeaderCell", bundle: nil)
            tableView.register(headerNib, forCellReuseIdentifier: GROUP_HEADER_CELL)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(group.name)
    }
    
    var group = Group()
    
    

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
            guard let header = tableView.dequeueReusableCell(withIdentifier: GROUP_HEADER_CELL) as? GroupHeaderCell else {
                return UITableViewCell()
            }
            header.group = self.group
            return header
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
