//
//  EngineersTableViewModel.swift
//  About-You
//
//  Created by Prateek on 2024/07/13.
//

import UIKit

protocol EngineersTableViewModelDelegate: AnyObject {
    
    func updateList()
}

class EngineersTableViewModel {
    
    private let engineers: [Engineer]
    private weak var delegate: EngineersTableViewModelDelegate?
    private lazy var sortedEngineers = engineers {
        didSet {
            delegate?.updateList()
        }
    }
    var currentOrderType: EngineerOrderType?
    
    init(engineers: [Engineer], delegate: EngineersTableViewModelDelegate? = nil) {
        self.engineers = engineers
        self.delegate = delegate
    }
    
    var numberOfEngineers: Int { return engineers.count }
    
    func engineer(at index: Int) -> Engineer?  {
       return sortedEngineers.value(at: index)
    }
    
    func displayInfo(forEngineerAt index: Int) -> GlucodianTableViewCell.DisplayInfo? {
        guard let engineer = engineer(at: index) else { return nil }
        return (name: engineer.name, role: engineer.role, image: engineer.image)
    }
    
    func orderEngineers(by orderType: EngineerOrderType) {
        currentOrderType = orderType
        sortedEngineers = switch orderType {
        case .years: sortedEngineers.ascendingSort(by: .years)
        case .coffees: sortedEngineers.ascendingSort(by: .coffees)
        case .bugs: sortedEngineers.ascendingSort(by: .bugs)
        }
    }
}
