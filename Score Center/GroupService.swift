//
//  GroupService.swift
//  Score Center
//
//  Created by Shayne Torres on 3/6/17.
//  Copyright © 2017 sptorres. All rights reserved.
//

import Foundation
import RealmSwift

protocol GroupService {
}

extension GroupService {

    
    /**
     Updates a group to the realm database
     
     - return:
     
     - parameters:
     
     */
    func updateGroup(updatedGroup: Group){
        let realm = try! Realm()
        var groupToUpdate = realm.objects(Group.self).filter("id == \(updatedGroup.id)").first!
        try! realm.write {
            groupToUpdate = updatedGroup
            groupToUpdate.updatedAt = Date.timeStamp()
        }
    }
    
    /**
     Deletes a group from the realm database
     
     - return:
     
     - parameters:
     
     */
    func deleteGroup(groupToDelete: Group){
        let realm = try! Realm()
        
        try! realm.write {
            realm.delete(groupToDelete)
        }
        
    }
    
    /**
     Retrieves all the groups in the realm database and returns them stored in an array
     
     - Author:
     Shayne Torres
     
     - Returns:
     void
     
     - Parameters:
     none
     */
    func getAllGroups()->[Group]{
        let realm = try! Realm()
        let groups = realm.objects(Group.self)
        var groupsArr : [Group] = []
        for i in groups {
            groupsArr.append(i)
        }
        return groupsArr
    }
    
    /**
     Retieves a single group with the given ID
     
     - Author:
     Shayne Torres
     
     - Returns:
     void
     
     - Parameters:
     none
     */
    func getGroup(byId id: Int)-> Group{
        let realm = try! Realm()
        
        return realm.objects(Group.self).filter("id == \(id)").first!
    }
}
