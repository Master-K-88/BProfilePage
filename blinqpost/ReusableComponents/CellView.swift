//
//  CellView.swift
//  blinqpost
//
//  Created by Oko-osi Korede on 11/11/2022.
//

import UIKit
class ProfileCollectionViewCell: UIView {
    
    static let identifier = "ProfileCollectionViewCell"
    lazy var profileImageView = UIImageView.imageView()
    private lazy var userNameLabel = UILabel.normalLabel(text: "")
    private lazy var lastUpdateLabel = UILabel.normalLabel(text: "")
    private lazy var menuButton = UIButton.buttonWithImage(with: UIImage(systemName: "") ?? UIImage())
    private lazy var descriptionLabel = UILabel.normalLabel(text: "")
    private lazy var mediaView = UIView.bgView()
    private lazy var postImageView = UIImageView.imageView()
    private lazy var muteButton = UIButton.buttonWithImage(with: UIImage())
   
    required override init(frame: CGRect) {
        super.init(frame: frame)
//        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = .systemBackground
        [
            profileImageView, userNameLabel, lastUpdateLabel, menuButton,
            descriptionLabel, mediaView, muteButton
        ].forEach { viewComponent in
            addSubview(viewComponent)
        }
        
        setupProfileImage()
        setupMenuButton()
        setupUsername()
        setupLastUpdate()
        setupDescription()
        setupMediaView()
        setupMuteButton()
        setupPostImageview()
//        contentView.addSubview(podcastCoverPage)
//        contentView.cornerRadius = 10
//        contentView.clipsToBounds = true
//
//        contentView.layer.shadowColor = UIColor.gray.cgColor
//        contentView.layer.shadowOpacity = 0.8
//        contentView.layer.shadowOffset = .zero
//        contentView.layer.shadowRadius = 5
//        contentView.layer.masksToBounds = false
    }
    
    private func setupProfileImage() {
        profileImageView.setViewConstraints(top: topAnchor, right: nil, bottom: nil, left: leadingAnchor, paddingTop: 5, paddingLeft: 20, width: bounds.width * 0.1, height: bounds.width * 0.1)
        profileImageView.cornerRadius = bounds.width * 0.1 * 0.5
        profileImageView.backgroundColor = .green
    }
    
    fileprivate func setupMenuButton() {
        menuButton.setViewConstraints(top: profileImageView.topAnchor, right: trailingAnchor, bottom: nil, left: nil, paddingRight: 20, width: bounds.width * 0.05, height: bounds.width * 0.1)
        menuButton.backgroundColor = .darkGray
    }
    
    fileprivate func setupUsername() {
        userNameLabel.setViewConstraints(top: profileImageView.topAnchor, right: menuButton.trailingAnchor, bottom: nil, left: profileImageView.trailingAnchor, paddingLeft: 20, paddingRight: 10)
        userNameLabel.text = "Brooklyn Simmons"
    }
    
    fileprivate func setupLastUpdate() {
        lastUpdateLabel.setViewConstraints(top: userNameLabel.bottomAnchor, right: userNameLabel.trailingAnchor, bottom: nil, left: userNameLabel.leadingAnchor, paddingTop: 5)
        lastUpdateLabel.text = "30mins ago. 17 Oct 22."
        lastUpdateLabel.font = .systemFont(ofSize: 12, weight: .regular)
        lastUpdateLabel.textColor = .systemGray
    }
    
    fileprivate func setupDescription() {
        descriptionLabel.setViewConstraints(top: profileImageView.bottomAnchor, right: menuButton.trailingAnchor, bottom: nil, left: profileImageView.leadingAnchor, paddingTop: 20)
        descriptionLabel.text = "Amet minim molit non deserunt ullamco est sit aliqua dolor do amet sint."
        descriptionLabel.numberOfLines = 2
    }
    
    fileprivate func setupMediaView() {
        mediaView.setViewConstraints(top: descriptionLabel.bottomAnchor, right: descriptionLabel.trailingAnchor, bottom: nil, left: profileImageView.leadingAnchor, paddingTop: 20, height: bounds.width * 0.5)
        mediaView.backgroundColor = .systemBrown
        mediaView.cornerRadius = 15
    }
    
    fileprivate func setupMuteButton() {
        muteButton.setViewConstraints(top: nil, right: mediaView.trailingAnchor, bottom: mediaView.bottomAnchor, left: nil,paddingBottom: 20, paddingRight: 20, width: bounds.width * 0.07, height: bounds.width * 0.07)
        muteButton.cornerRadius = bounds.width * 0.07 * 0.5
        muteButton.clipsToBounds = true
        muteButton.backgroundColor = .systemPurple
    }
    fileprivate func setupPostImageview() {
        mediaView.addSubview(postImageView)
        postImageView.pin(to: mediaView)
        postImageView.backgroundColor = .purple
        postImageView.cornerRadius = 15
        postImageView.clipsToBounds = true
        
    }
//    override func prepareForReuse() {
//        super.prepareForReuse()
//    }
    
    
    func configureCell(with model: MediaDataProtocol) {
//            self.profileImageView.kf.setImage(with: URL(string: model.thumbnail), placeholder: UIImage(named: "Startup"))
        userNameLabel.text = model.username
        descriptionLabel.text = model.description
        lastUpdateLabel.text = "\(model.timestamp)"
        postImageView.isHidden = model.video
        if model.video {
            // Show the video
        } else {
//            self.postImageView.kf.setImage(with: URL(string: model.thumbnail), placeholder: UIImage(named: "Startup"))
            muteButton.isEnabled = false
        }
    }
}



import SwiftUI
struct ProfileViewProvider: PreviewProvider {
    static var previews: some View {
        ContainerView()
    }
    
    struct ContainerView: UIViewRepresentable {
        func makeUIView(context: Context) -> some UIView {
            ProfileCollectionViewCell()
        }
        
        func updateUIView(_ uiView: UIViewType, context: Context) {
            
        }
    }
}
