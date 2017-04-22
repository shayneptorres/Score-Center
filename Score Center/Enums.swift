//
//  Enums.swift
//  Score Center
//
//  Created by Shayne Torres on 4/20/17.
//  Copyright © 2017 sptorres. All rights reserved.
//

import Foundation

enum CellIdentifier : String {
    case groupCell = "groupCell"
    case groupHeaderCell = "GROUP_HEADER_CELL"
    case editHeaderCell = "EDIT_HEADER_CELL"
    case teamCell = "TEAM_CELL"
}

enum UserDefaultsKey : String {
    case activeGroup = "activeGroupID"
}

enum Update : String {
    case groupsUpdated = "groupsUpdated"
}

/// Determines what type of header cell will be dispplayed on the groups detail VC
///
/// - editing: used when editing the group
/// - displaying: user when displying the group
enum HeaderCellDisplayMode {
    case editing
    case displaying
}
