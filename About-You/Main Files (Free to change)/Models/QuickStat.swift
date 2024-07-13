//
//  QuickStat.swift
//  About-You
//
//  Created by Prateek on 2024/07/12.
//

import Foundation

struct QuickStats {
    
    var years, coffees, bugs: Int
}

enum QuickStatType: String {
    
    case years
    case coffees
    case bugs
    
    var displayValue: String {
        return self.rawValue.capitalized
    }
}
