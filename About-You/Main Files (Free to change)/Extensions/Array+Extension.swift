//
//  Array+Extension.swift
//  About-You
//
//  Created by Prateek on 2024/07/13.
//

import Foundation

extension Array {
    
    func value(at index: Int) -> Element? {
        guard (0..<count).contains(index) else { return nil }
        return self[index]
    }
}

extension Array where Element == Engineer {
    
    func ascendingSort(by orderType: EngineerOrderType) -> Self {
        return switch orderType {
        case .years: sorted { $0.quickStats.years < $1.quickStats.years }
        case .coffees: sorted { $0.quickStats.coffees < $1.quickStats.coffees }
        case .bugs: sorted { $0.quickStats.bugs < $1.quickStats.bugs }
        }
    }
}
