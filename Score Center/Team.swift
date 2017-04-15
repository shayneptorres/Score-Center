//
//  Team.swift
//  Score Center
//
//  Created by Shayne Torres on 3/6/17.
//  Copyright © 2017 sptorres. All rights reserved.
//

import Foundation
import RealmSwift

class Team: Object {
    dynamic var id = Int()
    dynamic var name = String()
    dynamic var creatdAt = Date()
    dynamic var updatedAt = Date()
    dynamic var score = Double()
    dynamic var ranking = Int()
    dynamic var parentGroup : Group? = nil
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func autoincrementID(){
        let realm = try! Realm()
        self.id = (realm.objects(Team.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }
}
