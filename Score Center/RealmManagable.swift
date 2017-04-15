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
    var createdAt : Date { get set }
    var updatedAt : Date { get set }
    
    func autoincrementID()
    
}

extension RealmManagable where Self : Object {
    
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

}
