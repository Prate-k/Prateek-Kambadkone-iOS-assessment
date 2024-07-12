//
//  ProfileView.swift
//  About-You
//
//  Created by Prateek on 2024/07/12.
//

import UIKit

class ProfileView: UIView {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var statContainerView: StatContainerView!
    private var model: Engineer!

    override func awakeFromNib() {
        setUpView()
    }
    
    func setUp(for engineer: Engineer) {
        setUpView()
        nameLabel.text = engineer.name
        roleLabel.text = engineer.role
        statContainerView.addStats(engineer.quickStats)
        profileImage.image = UIImage(resource: .reenen)
    }
    
    private func setUpView() {
        layer.cornerRadius = 10
        layer.cornerCurve = .continuous
        profileImage.layer.cornerRadius = 10
        profileImage.layer.cornerCurve = .continuous
    }
}
