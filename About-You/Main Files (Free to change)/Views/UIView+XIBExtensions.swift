//
//  UIView+Extension.swift
//  About-You
//
//  Created by Prateek on 2024/07/12.
//

import UIKit

extension UIView {
    
    static func loadView() -> Self? {
        let bundle = Bundle(for: self)
        let views = bundle.loadNibNamed(String(describing: self), owner: nil, options: nil)
        guard let view = views?.first as? Self else {
            return nil
        }
        return view
    }
}
