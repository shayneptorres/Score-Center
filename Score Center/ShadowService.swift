//
//  ShadowService.swift
//  Score Center
//
//  Created by Shayne Torres on 3/6/17.
//  Copyright © 2017 sptorres. All rights reserved.
//

import Foundation
import UIKit

protocol ShadowService {
}

extension ShadowService {
    
    /**
     Iterates through each view in the shadow views array and applies the shadow
     
     - Author:
     Shayne Torres
     
     - Returns:
     void
     
     - Parameters:
     none
     */
    func applyShadowsTo(views: [UIView]){
        _ = views.map { sView in
            sView.applyShadow()
        }
    }
}
