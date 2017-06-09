//
//  BracketTests.swift
//  Score Center
//
//  Created by Shayne Torres on 6/8/17.
//  Copyright © 2017 sptorres. All rights reserved.
//

import XCTest
@testable import Score_Center

class BracketTests: XCTestCase {
    
    let b = Bracket()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testGetTierCount(){
        XCTAssert(b.getTierCount(teamCount: 2) == 2)
        XCTAssert(b.getTierCount(teamCount: 6) == 4)
        XCTAssert(b.getTierCount(teamCount: 13) == 5)
    }
    
    func testFindClosestPowerOfTwo(){
        XCTAssert(b.findClosestPowerOf2(val: 2) == 2)
        XCTAssert(b.findClosestPowerOf2(val: 3) == 2)
        XCTAssert(b.findClosestPowerOf2(val: 7) == 4)
        XCTAssert(b.findClosestPowerOf2(val: 13) == 8)
    }
    
    func testFindTier1MatchCount(){
        XCTAssert(b.findTier1MatchCount(teamCount: 4) == 2)
        XCTAssert(b.findTier1MatchCount(teamCount: 5) == 1)
        XCTAssert(b.findTier1MatchCount(teamCount: 6) == 2)
        XCTAssert(b.findTier1MatchCount(teamCount: 7) == 3)
    }
    
}
