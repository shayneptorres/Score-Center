//
//  PresetPoint.swift
//  Score Center
//
//  Created by Shayne Torres on 4/27/17.
//  Copyright © 2017 sptorres. All rights reserved.
//

import Foundation
import RealmSwift

class PresetPoint : Object, RealmManagable {
    dynamic var id = Int()
    dynamic var points = Double()
    dynamic var createdAt = Date()
    dynamic var updatedAt = Date()
    typealias RealmObject = PresetPoint
    
    
    override static func primaryKey() -> String? {
        return "id"
    }

}
