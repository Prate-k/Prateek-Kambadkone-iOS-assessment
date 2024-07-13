//
//  EngineerStatContainer.swift
//  About-You
//
//  Created by Prateek on 2024/07/12.
//

import UIKit

class StatContainerView: UIView {
    
    @IBOutlet private weak var statContainerStack: UIStackView!
    
    override func awakeFromNib() {
        setUpView()
    }
    
    func setUpView() {
        layer.cornerRadius = 10
        layer.cornerCurve = .continuous
    }
    
    func addStats(_ stat: QuickStats) {
        if let yearsView = StatView.loadView() {
            yearsView.updateStat(for: .years, with: "\(stat.years)")
            statContainerStack.addArrangedSubview(yearsView)
        }
        if let coffeesView = StatView.loadView() {
            coffeesView.updateStat(for: .coffees, with: "\(stat.coffees)")
            statContainerStack.addArrangedSubview(coffeesView)
        }
        if let bugsView = StatView.loadView() {
            bugsView.updateStat(for: .bugs, with: "\(stat.bugs)")
            statContainerStack.addArrangedSubview(bugsView)
        }
    }
}
