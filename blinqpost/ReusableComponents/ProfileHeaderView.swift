//
//  ProfileHeaderView.swift
//  blinqpost
//
//  Created by Oko-osi Korede on 11/11/2022.
//

import Foundation
import UIKit
import Kingfisher

class ProfileCustomHeaderView: UIView {

    lazy var topBGView = UIView.bgView()
    lazy var profileImage = UIImageView.imageView()
    lazy var checkedImage = UIImageView.imageView()
    lazy var username = UILabel.normalLabel(text: "")
    lazy var userHandle = UILabel.normalLabel(text: "")
    lazy var descriptionLabel = UILabel.normalLabel(text: "")
    lazy var underlineView = UIView.bgView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupHeaderImageView()
        checkedImageSetup()
        usernameSetup()
        userHandleSetup()
        userDescription()
        underLineView()
    }
    
    fileprivate func setupUI() {
        addSubview(topBGView)
        topBGView.setViewConstraints(top: topAnchor, right: trailingAnchor, bottom: bottomAnchor, left: leadingAnchor)
        
        [profileImage, checkedImage, username, userHandle, descriptionLabel, underlineView].forEach { newView in
            topBGView.addSubview(newView)
        }
    }
    fileprivate func setupHeaderImageView() {
        profileImage.setViewConstraints(top: topBGView.topAnchor, right: nil, bottom: nil, left: nil, paddingTop: 10)
        profileImage.setCenterAnchor(vertical: nil, horizontal: topBGView.centerXAnchor, height: topBGView.widthAnchor, heightMultiplier: 0.2, width: topBGView.widthAnchor, widthMultiplier: 0.2)
        profileImage.cornerRadius = bounds.width * 0.2 * 0.5
        profileImage.backgroundColor = .brown
        profileImage.clipsToBounds = true
    }
    
    fileprivate func checkedImageSetup() {
        checkedImage.setViewConstraints(top: nil, right: profileImage.trailingAnchor, bottom: profileImage.bottomAnchor, left: nil, paddingBottom: 5, paddingRight: -5, width: 30, height: 30)
        checkedImage.cornerRadius = 15
        checkedImage.image = UIImage(systemName: "checkmark")
        checkedImage.tintColor = .white
        checkedImage.backgroundColor = .link
        
    }
    
    fileprivate func usernameSetup() {
        username.setViewConstraints(top: profileImage.bottomAnchor, right: nil, bottom: nil, left: nil, paddingTop: 25)
        username.setCenterAnchor(vertical: nil, horizontal: topBGView.centerXAnchor, height: nil, width: nil)
        username.text = "User name"
        username.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
    }
    
    fileprivate func userHandleSetup() {
        userHandle.setViewConstraints(top: username.bottomAnchor, right: nil, bottom: nil, left: nil, paddingTop: 5)
        userHandle.setCenterAnchor(vertical: nil, horizontal: topBGView.centerXAnchor, height: nil, width: nil)
        userHandle.text = "@Someone"
        userHandle.textColor = .secondaryLabel
    }
    fileprivate func userDescription() {
        descriptionLabel.setViewConstraints(top: userHandle.bottomAnchor, right: topBGView.trailingAnchor, bottom: nil, left: topBGView.leadingAnchor, paddingTop: 5, paddingLeft: 10, paddingRight: 10)
        descriptionLabel.text = "Description goes into here"
        descriptionLabel.textAlignment = .center
        descriptionLabel.textColor = .secondaryLabel
    }
    fileprivate func underLineView() {
        underlineView.setViewConstraints(top: descriptionLabel.bottomAnchor, right: topBGView.trailingAnchor, bottom: nil, left: topBGView.leadingAnchor, paddingTop: 30, paddingLeft: 20, paddingRight: 20, height: 2)
        underlineView.backgroundColor =  .black
    }
    
    public func configureHeader(with userData: UserProfile) {
        self.profileImage.kf.setImage(with: URL(string: userData.photo), placeholder: UIImage(named: "person.fill") ?? UIImage())
        self.username.text = userData.name
        self.userHandle.text = userData.username
        self.descriptionLabel.text = userData.bio
    }

}

import SwiftUI
struct ProfileHeaderPreviewProvider: PreviewProvider {
    static var previews: some View {
        ContainerView()
            .frame(width: UIScreen.main.bounds.width, height: 220)
    }
    
    struct ContainerView: UIViewRepresentable {
        func makeUIView(context: Context) -> some UIView {
            ProfileCustomHeaderView()
        }
        func updateUIView(_ uiView: UIViewType, context: Context) {
            
        }
    }
}
