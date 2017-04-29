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
    
    /// Updates the UI elements of the view controller
    func updateUI(){
        guard let team = team else {return}
        teamLabel.text = "\(team.name) with \(team.score.toDecimalFormat())pts"
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapDismiss))
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
    }
    
    func tapDismiss(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func addPoints(_ sender: UIButton) {
        guard var team = team, let update = Double(pointsTextField.text!), let delegate = delegate else {return}
        team.update {
            team.score += update
        }
        delegate.reloadData()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func removePoints(_ sender: UIButton) {
        guard var team = team, let update = Double(pointsTextField.text!), let delegate = delegate else {return}
        team.update {
            team.score -= update
        }
        delegate.reloadData()
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func cancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension ScoreManagerVC : UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: self.formContainer))! {
            return false
        }
        return true
    }
}

extension ScoreManagerVC : UITextFieldDelegate {
    
}
