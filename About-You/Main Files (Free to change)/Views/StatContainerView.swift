//
//  EngineerStatContainer.swift
//  About-You
//
//  Created by Prateek on 2024/07/12.
//

import UIKit

class StatContainerView: UIView {
    
    @IBOutlet var statContainerStack: UIStackView!
    
    override func awakeFromNib() {
        setUpView()
    }
    
    func setUpView() {
        layer.cornerRadius = 10
        layer.cornerCurve = .continuous
    }
    
    func addStats(_ stat: QuickStats) {
        let yearsView = StatView.loadView()
        let coffeesView = StatView.loadView()
        let bugsView = StatView.loadView()
        
        if let yearsView {
            yearsView.updateStat(for: .years, with: "\(stat.years)")
            statContainerStack.addArrangedSubview(yearsView)
        }
        
        if let coffeesView {
            coffeesView.updateStat(for: .coffees, with: "\(stat.coffees)")
            statContainerStack.addArrangedSubview(coffeesView)
        }
        
        if let bugsView {
            bugsView.updateStat(for: .bugs, with: "\(stat.bugs)")
            statContainerStack.addArrangedSubview(bugsView)
        }
    }
}
