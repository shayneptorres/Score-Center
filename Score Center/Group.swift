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
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func autoincrementID(){
        let realm = try! Realm()
        self.id = (realm.objects(Group.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }
    
    func add(team: Team){
        let realm = try! Realm()
        try! realm.write {
            self.teams.append(team)
            self.updatedAt = Date.timeStamp()
        }
    }
    
    func delete(){
        let realm = try! Realm()
        
        try! realm.write {
            realm.delete(self)
        }
    }
    
    static func getAll() -> [Group] {
        let realm = try! Realm()
        return realm.objects(Group.self).map({ $0 })
    }
    
    static func getOne(withId id: Int) -> Group {
        let realm = try! Realm()
        
        return realm.objects(Group.self).filter("id == \(id)").first!
    }
}
