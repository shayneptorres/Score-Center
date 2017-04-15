//
//  Date.swift
//  Score Center
//
//  Created by Shayne Torres on 3/6/17.
//  Copyright © 2017 sptorres. All rights reserved.
//

import Foundation

class DateToolKit {
    
}

extension Date {
    static func timeStamp()->Date{
        let date = Date()
        let nowInterval = date.timeIntervalSinceNow
        let now = Date(timeIntervalSinceNow: nowInterval)
        print(now)
        return now
    }
}
