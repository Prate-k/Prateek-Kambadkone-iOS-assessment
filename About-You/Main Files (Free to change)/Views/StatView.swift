//
//  EngineerStatView.swift
//  About-You
//
//  Created by Prateek on 2024/07/12.
//

import UIKit

class StatView: UIView {
    
    @IBOutlet var statTitleLabel: UILabel!
    @IBOutlet var statValueLabel: UILabel!
    
    func updateStat(for type: QuickStatType, with value: String) {
        statTitleLabel.text = type.displayValue
        statValueLabel.text = value
    }
}
