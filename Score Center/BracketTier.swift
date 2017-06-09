//
//  BracketTier.swift
//  Score Center
//
//  Created by Shayne Torres on 6/4/17.
//  Copyright © 2017 sptorres. All rights reserved.
//

import Foundation
import RealmSwift

class BracketTier : Object, RealmManagable {
    dynamic var id = Int()
    dynamic var createdAt = Date()
    dynamic var updatedAt = Date()
    typealias RealmObject = Bracket
    
    var matches = List<BracketMatch>()
    
    dynamic var level = Int()
    
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
