//
//  ProfileView.swift
//  About-You
//
//  Created by Prateek on 2024/07/12.
//

import UIKit

protocol ProfileViewDelegate: UIImagePickerControllerDelegate {
    
    func selectImage()
}

class ProfileView: UIView {
    
    @IBOutlet private weak var profileImage: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var roleLabel: UILabel!
    @IBOutlet private weak var statContainerView: StatContainerView!
    
    private var model: Engineer!
    private weak var delegate: ProfileViewDelegate?
    private lazy var profileImageTapGesture = UITapGestureRecognizer(target: self, action: #selector(selectProfilePicture))

    override func awakeFromNib() {
        setUpView()
    }
    
    func setUp(for engineer: Engineer, delegate: ProfileViewDelegate) {
        setUpView()
        model = engineer
        nameLabel.text = engineer.name
        roleLabel.text = engineer.role
        statContainerView.addStats(engineer.quickStats)
        profileImage.image = engineer.image != nil ? engineer.image! : UIImage(resource: .reenen)
        self.delegate = delegate
    }
    
    func updateImage(with image: UIImage) {
        profileImage.image = image
        model.image = image
    }
    
    private func setUpView() {
        layer.cornerRadius = 10
        layer.cornerCurve = .continuous
        profileImage.layer.cornerRadius = 10
        profileImage.layer.cornerCurve = .continuous
        profileImage.isUserInteractionEnabled = true
        profileImage.addGestureRecognizer(profileImageTapGesture)
    }
    
    @objc
    private func selectProfilePicture() {
        delegate?.selectImage()
    }
}
