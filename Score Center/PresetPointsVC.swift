//
//  PresetPointsVC.swift
//  Score Center
//
//  Created by Shayne Torres on 4/27/17.
//  Copyright © 2017 sptorres. All rights reserved.
//

import UIKit

class PresetPointsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            let nib = UINib(nibName: "PresetPointCell", bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: CellIdentifier.presetPointCell.rawValue)
            tableView.delegate = self
            tableView.dataSource = self
            tableView.estimatedRowHeight = 75
            tableView.rowHeight = UITableViewAutomaticDimension
        }
    }
    var group : Group?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
}

extension PresetPointsVC : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let group = group else {return 0}
        return group.presetPoints.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "addPresetScoreCell") as! AddPresetScoreCell
            cell.delegate = self
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.presetPointCell.rawValue) as! PresetPointCell
        cell.pointLabel.text = "\(String(describing: group?.presetPoints[indexPath.row].points.toDecimalFormat()))pts"
        return cell
    }
}

extension PresetPointsVC : PresetScoreCellDelegate {
    func add(score: Double) {
        guard var group = group else {
            return
        }
        var point = PresetPoint()
        point.points = score
        point.autoincrementID()
        group.update {
            group.presetPoints.append(point)
        }
        tableView.reloadData()
    }
}
