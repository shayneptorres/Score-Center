//
//  Extensions.swift
//  Score Center
//
//  Created by Shayne Torres on 4/22/17.
//  Copyright © 2017 sptorres. All rights reserved.
//

import Foundation
import UIKit

extension Double {
    
    /**
     Returns a given Double value as a String with decimal formatting. This will add commas breaks to integers greater than 999
     eg: 1234 = "1,234.00"
     eg: 1957393.54 = "1,957,393.54"
     
     - Author:
     Shayne Torres
     
     - Returns:
     - String, a string containing the decimal formatted value of the given Double
     */
    public func toDecimalFormat()->String{
        let decimalFormatter = NumberFormatter()
        decimalFormatter.numberStyle = .decimal
        let decimalStr = decimalFormatter.string(from: NSNumber(value: self))
        return decimalStr!
    }
}


extension Int {
    func ordinalString() -> String {
        switch self % 10 {
        case 1...3 where 11...13 ~= self % 100: return "\(self)" + "th"
        case 1:    return "\(self)" + "st"
        case 2:    return "\(self)" + "nd"
        case 3:    return "\(self)" + "rd"
        default:   return "\(self)" + "th"
        }
    }
}

extension UIView {
    /**
     Applies a small shadow to the bottom side of a UIview
     
     - Author:
     Shayne Torres
     
     - Returns:
     void
     
     - Parameters:
     none
     */
    func applyShadow(){
        self.layer.shadowColor = UIColor(netHex: 0x000000).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowRadius = 1
        self.layer.shadowOpacity = 0.1
        self.layer.masksToBounds = false
    }
}
