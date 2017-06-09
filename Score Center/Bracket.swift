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
        var teirCount = 1
        var temp : Double = Double(teams.count)
        
        // First teir match count is half the number of teams playing
        temp /= 2
        teirCount += 1
        while temp > 1 {
            // Each teir following should also have half the number of matches
            // as the tier before
            temp /= 2
            teirCount += 1
        }
        
        var teamPosition = 0
        
        // If the number of teams needed in the first round is not zero
        // we need to create matches to even out the bracket
        if findTier1MatchCount(teamCount: teams.count) != 0 {
            teirCount += 1
            
            // Create the tier structures
            for _ in 0..<teirCount {
                let tier = BracketTier()
                addTier(tier: tier)
            }
            
            // Places the number of matches needed in the first round, in the 
            // first tier object
            for _ in 1...findTier1MatchCount(teamCount: teams.count) {
                let match = BracketMatch(teamA: teams[teamPosition], teamB: teams[teamPosition + 1])
                tiers[0].matches.append(match)
                teamPosition += 2
            }
            
            
            // Here we fill all of the teirs with matches
            for (i, tier) in tiers.enumerated() {
                // Create the second level teir with all the remaining matches
                if i == 1 {
                    
                    // Fill all the half matches the are depending on the 
                    // first teir matches to finish
                    for _ in 1...findTier1MatchCount(teamCount: teams.count) {
                        let match = BracketMatch(teamA: teams[teamPosition])
                        tier.matches.append(match)
                        teamPosition += 1
                    }
                    
                    // Fill in all the remaining match pairs
                    var remainingTeamCount = teams.count - teamPosition
                    
                    for _ in 1...remainingTeamCount/2 {
                        // Create a match with two teams and append the match
                        // to the tier
                        var match = BracketMatch(teamA: teams[teamPosition], teamB: teams[teamPosition + 1])
                        // move the current team position by two
                        teamPosition += 2
                        tier.matches.append(match)
                    }
                } else {
                    // Fill in the rest of the tiers with empty matches
                    
                }
            }
            
            
        } else {
            // Create the tier structures
            for i in 0..<teirCount {
                let tier = BracketTier()
                addTier(tier: tier)
            }
            
            // Add matches to teirs
            
            for (i, tier) in tiers.enumerated() {
                // Create the first level tier with all the team matches
                if i == 0 {
                    for j in 0..<teams.count/2 {
                        var match = BracketMatch()
                        if teamPosition + 1 == teams.count - 1 {
                            match = BracketMatch(teamA: teams[teamPosition])
                        } else {
                            match = BracketMatch(teamA: teams[teamPosition], teamB: teams[teamPosition + 1])
                            teamPosition += 2
                        }
                        tier.matches.append(match)
                    }
                } else {
                    // Fill in the rest of the tiers with empty matches
                    
                }
            }
        }
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
        return teamCount % findClosestPowerOf2(val: teamCount)
    }
    
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
