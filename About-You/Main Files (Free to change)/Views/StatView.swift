//
//  EngineerStatView.swift
//  About-You
//
//  Created by Prateek on 2024/07/12.
//

import UIKit

class StatView: UIView {
    
    @IBOutlet private weak var statTitleLabel: UILabel!
    @IBOutlet private weak var statValueLabel: UILabel!
    
    func updateStat(for type: QuickStatType, with value: String) {
        statTitleLabel.text = type.displayValue
        statValueLabel.text = value
    }
}
