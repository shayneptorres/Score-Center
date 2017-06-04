//
//  ScoreManagerVC.swift
//  Score Center
//
//  Created by Shayne Torres on 4/21/17.
//  Copyright © 2017 sptorres. All rights reserved.
//

import UIKit

class ScoreManagerVC: UIViewController {
    
    @IBOutlet weak var pointsTextField: AppTextField!
    @IBOutlet weak var teamLabel: UILabel!
    
    @IBOutlet weak var formContainer: UIView!
    
    @IBOutlet weak var addPointButton: UIButton! {
        didSet {
            addPointButton.layer.cornerRadius = 2
            addPointButton.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var removePointsButton: UIButton! {
        didSet {
            removePointsButton.layer.cornerRadius = 2
            removePointsButton.layer.masksToBounds = true
        }
    }
    
    var team : Team?
    var delegate : ScoreManagerDelegate?
    var group : Group?
    
    @IBOutlet weak var collectionViewContainer: UIView!
    
    
    @IBOutlet weak var formHeight: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        pointsTextField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.showTabBar()
    }
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    
    /// Updates the UI elements of the view controller
    func updateUI(){
        guard let team = team else {return}
        teamLabel.text = "\(team.name) with \(team.score.toDecimalFormat())pts"
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapDismiss))
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
        
        // Form container
        formContainer.layer.cornerRadius = 5
        formContainer.layer.masksToBounds = true
        formContainer.applyShadow()
        
    }
    
    func tapDismiss(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addPresetPoints(_ sender: UIButton) {
        guard var group = group else { return }
        
        if pointsTextField.text == "" {
            let presetPointAlert = UIAlertController(title: "Add preset point", message: "In order to add a preset point, please make sure you have entered a number value", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "Got it", style: .default, handler: nil)
            presetPointAlert.addAction(okayAction)
            self.present(presetPointAlert, animated: true, completion: {})
        } else {
            if let score = Double(pointsTextField.text!) {
                var tempArr = group.presetPoints.filter({ $0.points == score })
                if !tempArr.isEmpty {
                    // Throw up a warning, telling the use they cant add multiple scores
                    let presetPointAlert = UIAlertController(title: "Oops, that preset score already exists.", message: "You cannot have duplicate preset point values", preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "Sweet!", style: .default, handler: nil)
                    presetPointAlert.addAction(okayAction)
                    return
                }
                var points = PresetPoint()
                points.points = score
                points.autoincrementID()
                group.update {
                    group.presetPoints.append(points)
                }
                collectionView.reloadData()
            }
        }
        
    }
    
    @IBAction func getPresetPointsInfo(_ sender: UIButton) {
        let presetPointAlert = UIAlertController(title: "What are preset points", message: "Preset points, are specific point values that you can save ahead of time. Let's say you are need to add a certain score amount multiple times. Add it here and next time you go to add/remove points, you dont have to type the value again.", preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Sweet!", style: .default, handler: nil)
        presetPointAlert.addAction(okayAction)
        self.present(presetPointAlert, animated: true, completion: {})
    }
    
    @IBAction func addPoints(_ sender: UIButton) {
        guard var team = team,
            let update = Double(pointsTextField.text!),
            let delegate = delegate else {return}
        team.update {
            team.score += update
        }
        delegate.reloadData()
        pointsTextField.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func removePoints(_ sender: UIButton) {
        guard var team = team, let update = Double(pointsTextField.text!), let delegate = delegate else {return}
        team.update {
            team.score -= update
        }
        delegate.reloadData()
        pointsTextField.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clearScore(_ sender: UIButton) {
        guard var team = team else { return }
        team.update {
            team.score = 0
        }
        delegate?.reloadData()
        pointsTextField.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
    }
    

    @IBAction func cancel(_ sender: UIButton) {
        pointsTextField.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func unwind(sender: UIStoryboardSegue){
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let group = group else { return }
        if segue.identifier == "addPresetPointsFromScoreManager" {
            let presetScoreVC = segue.destination as! PresetPointsVC
            
        }
    }
}

extension ScoreManagerVC : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (group?.presetPoints.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let group = group else {
            return UICollectionViewCell()
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PresetPointCollection", for: indexPath) as! PresetPointCollectionCell
        cell.points.text = "\(String(describing: group.presetPoints[indexPath.row].points))"
        cell.body.layer.cornerRadius = 2
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        pointsTextField.text = String(describing: group!.presetPoints[indexPath.row].points)
        
    }
}

extension ScoreManagerVC : UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: self.formContainer))! {
            return false
        }
        pointsTextField.resignFirstResponder()
        return true
    }
}

extension ScoreManagerVC : UITextFieldDelegate {
    
}
