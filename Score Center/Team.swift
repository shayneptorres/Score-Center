//
//  Team.swift
//  Score Center
//
//  Created by Shayne Torres on 3/6/17.
//  Copyright © 2017 sptorres. All rights reserved.
//

import Foundation
import RealmSwift

class Team: Object, RealmManagable {
    dynamic var id = Int()
    dynamic var name = String()
    dynamic var createdAt = Date()
    dynamic var updatedAt = Date()
    dynamic var score = Double()
    dynamic var ranking = Int()
    dynamic var parentGroup : Group? = nil
    
    typealias RealmObject = Team
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
