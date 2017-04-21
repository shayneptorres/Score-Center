//
//  Group.swift
//  Score Center
//
//  Created by Shayne Torres on 3/6/17.
//  Copyright © 2017 sptorres. All rights reserved.
//

import Foundation
import RealmSwift

class Group : Object, RealmManagable {
    dynamic var id = Int()
    dynamic var name = String()
    dynamic var desc = String()
    dynamic var createdAt = Date()
    dynamic var updatedAt = Date()
    var teams = List<Team>()
    var isActive = Bool()
    typealias RealmObject = Group
    
    func add(team: Team){
        let realm = try! Realm()
        try! realm.write {
            self.teams.append(team)
            self.updatedAt = Date.timeStamp()
        }
    }
}
