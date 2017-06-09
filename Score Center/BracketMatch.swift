//
//  BracketMatch.swift
//  Score Center
//
//  Created by Shayne Torres on 6/5/17.
//  Copyright © 2017 sptorres. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class BracketMatch : Object, RealmManagable {
    dynamic var id = Int()
    dynamic var createdAt = Date()
    dynamic var updatedAt = Date()
    typealias RealmObject = BracketMatch
    
    var teamA : Team?
    var teamB : Team?
    var winner : Team?
    var loser : Team?
    
    init(teamA: Team, teamB: Team) {
        super.init()
        self.teamA = teamA
        self.teamB = teamB
    }
    
    init(teamA: Team) {
        super.init()
        self.teamA = teamA
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        fatalError("init(realm:schema:) has not been implemented")
    }
    
    required init() {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        fatalError("init(value:schema:) has not been implemented")
    }

    
    func endMatch(won: Team?, lost: Team?) {
        guard let winner = won, let loser = lost else { return }
        self.winner = winner
        self.loser = loser
    }
    
    func resetMatch(){
        self.winner = nil
        self.loser = nil
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
