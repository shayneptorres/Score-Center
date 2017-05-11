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
    
    @IBOutlet weak var addPointButton: UIButton!
    @IBOutlet weak var removePointsButton: UIButton!
    
    var team : Team?
    var delegate : ScoreManagerDelegate?
    var group : Group?
    
    @IBOutlet weak var collectionViewContainer: UIView!
    
    @IBOutlet weak var containerHeight: NSLayoutConstraint!
    
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
        
        if group?.presetPoints.count == 0 {
            collectionViewContainer.isHidden = true
            formHeight.constant = 180
        } else {
            
            formHeight.constant = 240
        }
    }
    
    func tapDismiss(){
        self.dismiss(animated: true, completion: nil)
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

    @IBAction func cancel(_ sender: UIButton) {
        pointsTextField.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func unwind(sender: UIStoryboardSegue){
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
