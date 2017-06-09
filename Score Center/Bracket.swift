//
//  Bracket.swift
//  Score Center
//
//  Created by Shayne Torres on 6/4/17.
//  Copyright © 2017 sptorres. All rights reserved.
//

import Foundation
import RealmSwift

enum EliminationStyle {
    case single
    case double
}

class Bracket : Object, RealmManagable {
    dynamic var id = Int()
    dynamic var createdAt = Date()
    dynamic var updatedAt = Date()
    typealias RealmObject = Bracket
    var elimination : EliminationStyle = .single
    
    private var tiers = List<BracketTier>()
    
    func addTier(tier: BracketTier){
        var newTier = tier
        newTier.level = tiers.count + 1
        newTier.autoincrementID()
        tiers.append(newTier)
        
    }
    
    func getTiers() -> [BracketTier] {
        return self.tiers.sorted(by: { $0.level > $1.level })
    }
    
    func create(teams: [Team]){
        // First get the number of tiers needed for the team count
        
        var temp : Double = Double(teams.count)
        var tempTeams = teams
        
        let tierCount = getTierCount(teamCount: Double(teams.count))
        let tier1MatchCount = findTier1MatchCount(teamCount: teams.count)
        
        // Create the teir structure
        // Adds the necessary amount of tiers to the bracket
        for i in 1...tierCount {
            let tier = BracketTier()
            tier.level = i
            tiers.append(tier)
        }
        
        // Populate the first tier with the necessary amount of teams
        for i in 1...tier1MatchCount {
            let match = BracketMatch(teamA: tempTeams.removeLast(), teamB: tempTeams.removeLast())
            tiers[0].matches.append(match)
        }
        
        // Fill the second tier with the necessary amount of half brackets
        // These will be matched up with the winners of the first tier
        if tempTeams.count == 0 { return }
        for i in 1...tier1MatchCount {
            let match = BracketMatch(teamA: tempTeams.removeLast())
            tiers[1].matches.append(match)
        }
        
        // Fill the second tier with the remaining amount of full matches
        if tempTeams.count == 0 { return }
        for i in 1...(tempTeams.count/2) {
            let match = BracketMatch(teamA: tempTeams.removeLast(), teamB: tempTeams.removeLast())
            tiers[1].matches.append(match)
        }
        
    }
    
    func getTierCount(teamCount: Double) -> Int {
        // First teir match count is half the number of teams playing
        var teirCount = 1
        var tempTeamCount = teamCount/2
        teirCount += 1
        while tempTeamCount > 1 {
            // Each teir following should also have half the number of matches
            // as the tier before
            tempTeamCount /= 2
            teirCount += 1
        }
        return teirCount
    }
    
    /// Finds the closetst power of two value to the number passed in.
    /// This value is used to determine the number of matches is needed in the
    /// first round to even out the rest of the bracket
    ///
    /// - Parameter val: The number to find the closetst power of two
    /// - Returns: the closet power of two to the passed in value
    func findClosestPowerOf2(val: Int) -> Int{
        var powerOf2 = 2
        while powerOf2 * 2 <= val {
            powerOf2 *= 2
        }
        return powerOf2
    }
    
    /// Determines how many matches need to be in the first round to even out
    /// the rest of the bracket. Based on the number of teams, there needs to be
    /// a certain amount of matches the first round so that there will only be
    /// one winner.
    ///
    /// - Parameter teamCount: The number of teams participating
    /// - Returns: the number of matches needed in the first round
    func findTier1MatchCount(teamCount: Int) -> Int {
        if teamCount % findClosestPowerOf2(val: teamCount) != 0 {
            return teamCount % findClosestPowerOf2(val: teamCount)
        } else {
            return teamCount/2
        }
        
    }
    
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
