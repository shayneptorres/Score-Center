//
//  Protocols.swift
//  Score Center
//
//  Created by Shayne Torres on 4/20/17.
//  Copyright © 2017 sptorres. All rights reserved.
//

import Foundation
import UIKit

protocol HeaderCellDelegate {
    func showEditMode()
    func showDisplayMode()
}

protocol ScoreManagerDelegate {
    func reloadData()
}
