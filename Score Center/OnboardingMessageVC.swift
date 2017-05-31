//
//  OnboardingMessageVC.swift
//  Score Center
//
//  Created by Shayne Torres on 5/11/17.
//  Copyright © 2017 sptorres. All rights reserved.
//

import UIKit

class OnboardingMessageVC: UIViewController {
    
    @IBOutlet weak var headerMessage: UILabel!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    
    var header = ""
    var msg = ""
    var buttonTitle = ""
    var onboardingKey : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        headerMessage.text = header
        message.text = msg
        dismissButton.setTitle(buttonTitle, for: .normal)
        view.layer.cornerRadius = 2
        view.layer.masksToBounds = true
    }
    
    func set(headerMessage: String, message: String, buttonTitle: String){
        self.header = headerMessage
        self.msg = message
        self.buttonTitle = buttonTitle
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        dismiss(animated: true, completion: {
            if let key = self.onboardingKey {
                UserDefaults.standard.set(true, forKey: key)
            }
        })
    }
    
    @IBAction func skipTutorials(_ sender: UIButton) {
        dismiss(animated: true, completion: {
            UserDefaults.standard.set(true, forKey: UserDefaultsKey.firstTimeActiveGroup.rawValue)
            UserDefaults.standard.set(true, forKey: UserDefaultsKey.firstTimePresetPoints.rawValue)
            UserDefaults.standard.set(true, forKey: UserDefaultsKey.firstTimeGroupDetail.rawValue)
        })
    }
    
}
