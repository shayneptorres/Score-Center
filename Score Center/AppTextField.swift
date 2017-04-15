//
//  AppTextField.swift
//  Score Center
//
//  Created by Shayne Torres on 3/8/17.
//  Copyright © 2017 sptorres. All rights reserved.
//

import UIKit

class AppTextField: UITextField {

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 20, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 20, dy: 0)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 2
    }

}
