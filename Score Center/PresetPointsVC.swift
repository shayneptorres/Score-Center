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
        }
    }
    var group : Group?
    
    var onboarded : Bool {
        get {
            return UserDefaults.standard.bool(forKey: UserDefaultsKey.firstTimePresetPoints.rawValue)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKey.firstTimePresetPoints.rawValue)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        
        if !onboarded {
            let onboard = UIStoryboard(name: "Onboarding", bundle: nil)
            guard let messageVC = onboard.instantiateViewController(withIdentifier: "onboardMessage") as? OnboardingMessageVC else {
                return
            }
            messageVC.modalPresentationStyle = .overFullScreen
            messageVC.set(headerMessage: "Preset Points",
                          message: "Here is where you can add preset points. Preset points come in handy when you need to add or remove a specific score value multiple times. When you add values here, they will show up whenever you are editing the score of the current active team.\n\nWhile editing scores, tap on the preset point to autofill the textfield",
                          buttonTitle: "Awesome!")
            messageVC.onboardingKey = UserDefaultsKey.firstTimePresetPoints.rawValue
            navigationController?.present(messageVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func addPoints(_ sender: UIButton) {
        guard let score = Double(scoreTextField.text!) else {
            return
        }
        add(score: score)
    }
    
    @IBOutlet weak var scoreTextField: AppTextField! {
        didSet {
            scoreTextField.delegate = self
        }
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.presetPointCell.rawValue) as! PresetPointCell
        cell.pointLabel.text = "\(String(describing: group!.presetPoints[indexPath.row].points.toDecimalFormat()))pts"
        cell.body.applyShadow()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return PresetPointCell.cellHeight
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch  editingStyle {
        case .delete:
            group?.presetPoints[indexPath.row].delete()
            tableView.reloadData()
        default:
            break
        }
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
        scoreTextField.text = ""
        tableView.reloadData()
    }
}

extension PresetPointsVC : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
