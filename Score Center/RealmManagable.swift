//
//  RealmManagable.swift
//  Score Center
//
//  Created by Shayne Torres on 4/13/17.
//  Copyright © 2017 sptorres. All rights reserved.
//

import Foundation
import RealmSwift

protocol RealmManagable {
    var id : Int { get set }
    var createdAt : Date { get set }
    var updatedAt : Date { get set }
    associatedtype RealmObject
}

extension RealmManagable where Self : Object {
    
    static func primaryKey() -> String? {
        return "id"
    }

    mutating func autoincrementID(){
        let realm = try! Realm()
        self.id = (realm.objects(RealmObject.self as! Object.Type).max(ofProperty: "id") as Int? ?? 0) + 1
    }
    
    mutating func save(){
        let realm = try! Realm()
        try! realm.write {
            self.autoincrementID()
            self.createdAt = Date.timeStamp()
            self.updatedAt = Date.timeStamp()
            realm.add(self)
        }
    }
    
    mutating func update(){
        let realm = try! Realm()
        try! realm.write {
            self.updatedAt = Date.timeStamp()
            realm.add(self, update: true)
        }
    }
    
    func delete(){
        let realm = try! Realm()
        try! realm.write {
            realm.delete(self)
        }
    }
    
    static func getAll() -> [Object] {
        let realm = try! Realm()
        return realm.objects(RealmObject.self as! Object.Type).map({ obj in obj })
    }
    
    static func getOne(withId id: Int) -> Object {
        let realm = try! Realm()
        
        return realm.objects(RealmObject.self as! Object.Type).filter("id == \(id)").first!
    }

}
