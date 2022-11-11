//
//  CollectionCell.swift
//  blinqpost
//
//  Created by Oko-osi Korede on 11/11/2022.
//

import Foundation
import Kingfisher
import AVFoundation

class CollectionCell: UICollectionViewCell {
    
    var playerLayer = AVPlayerLayer()
    var mediaLink: String = ""
    var player: AVPlayer?
    
    static let identifier = "CollectionCell"
    lazy var profileImageView = UIImageView.imageView()
    private lazy var userNameLabel = UILabel.normalLabel(text: "")
    private lazy var lastUpdateLabel = UILabel.normalLabel(text: "")
    private lazy var menuButton = UIButton.buttonWithImage(with: UIImage(named: "menu") ?? UIImage())
    private lazy var descriptionLabel = UILabel.normalLabel(text: "")
    private lazy var mediaView = UIView.bgView()
    private lazy var postImageView = UIImageView.imageView()
    private lazy var muteButton = UIButton.buttonWithImage(with: UIImage())
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }
    
    private func setupUI() {
        contentView.backgroundColor = .systemBackground
        [
            profileImageView, userNameLabel, lastUpdateLabel, menuButton,
            descriptionLabel, mediaView, muteButton
        ].forEach { viewComponent in
            contentView.addSubview(viewComponent)
        }
        
        setupProfileImage()
        setupMenuButton()
        setupUsername()
        setupLastUpdate()
        setupDescription()
        setupMediaView()
        setupMuteButton()
        setupPostImageview()
    }
    
    private func setupProfileImage() {
        profileImageView.setViewConstraints(top: topAnchor, right: nil, bottom: nil, left: leadingAnchor, paddingTop: 5, paddingLeft: 20, width: contentView.bounds.width * 0.1, height: contentView.bounds.width * 0.1)
        profileImageView.cornerRadius = contentView.bounds.width * 0.1 * 0.5
        profileImageView.clipsToBounds = true
    }
    
    fileprivate func setupMenuButton() {
        menuButton.setViewConstraints(top: profileImageView.topAnchor, right: contentView.trailingAnchor, bottom: nil, left: nil, paddingRight: 20, width: contentView.bounds.width * 0.05, height: contentView.bounds.width * 0.1)
        menuButton.tintColor = .black
    }
    
    fileprivate func setupUsername() {
        userNameLabel.setViewConstraints(top: profileImageView.topAnchor, right: menuButton.trailingAnchor, bottom: nil, left: profileImageView.trailingAnchor, paddingLeft: 20, paddingRight: 10)
    }
    
    fileprivate func setupLastUpdate() {
        lastUpdateLabel.setViewConstraints(top: userNameLabel.bottomAnchor, right: userNameLabel.trailingAnchor, bottom: nil, left: userNameLabel.leadingAnchor, paddingTop: 5)
        lastUpdateLabel.font = .systemFont(ofSize: 12, weight: .regular)
    }
    
    fileprivate func setupDescription() {
        descriptionLabel.setViewConstraints(top: profileImageView.bottomAnchor, right: menuButton.trailingAnchor, bottom: nil, left: profileImageView.leadingAnchor, paddingTop: 20, height: 40)
        descriptionLabel.numberOfLines = 2
    }
    
    fileprivate func setupMediaView() {
        mediaView.setViewConstraints(top: descriptionLabel.bottomAnchor, right: descriptionLabel.trailingAnchor, bottom: nil, left: profileImageView.leadingAnchor, paddingTop: 20, width: contentView.bounds.width - 40, height: contentView.bounds.width * 0.5)
        playerLayer.frame = mediaView.bounds
        mediaView.cornerRadius = 15
    }
    
    fileprivate func setupMuteButton() {
        muteButton.setViewConstraints(top: nil, right: mediaView.trailingAnchor, bottom: mediaView.bottomAnchor, left: nil,paddingBottom: 20, paddingRight: 20, width: contentView.bounds.width * 0.07, height: contentView.bounds.width * 0.07)
        muteButton.cornerRadius = contentView.bounds.width * 0.07 * 0.5
        muteButton.clipsToBounds = true
        muteButton.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
        muteButton.addTarget(self, action: #selector(playVideoTapped(_:)), for: .touchUpInside)
    }
    fileprivate func setupPostImageview() {
        mediaView.addSubview(postImageView)
        postImageView.pin(to: mediaView)
        postImageView.cornerRadius = 15
        postImageView.clipsToBounds = true
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        configureCell(with: MediaDataModel())
    }
    
    
    func configureCell(with model: MediaDataProtocol) {
        let date = NSDate(timeIntervalSince1970: model.timestamp)
        DispatchQueue.main.async { [weak self] in
            self?.userNameLabel.text = model.username
            self?.descriptionLabel.text = model.description
            self?.lastUpdateLabel.text = "\(date)"
            self?.postImageView.isHidden = model.video
            self?.profileImageView.kf.setImage(with: URL(string: model.thumbnail), placeholder: UIImage(named: "Startup"))
            if model.video {
                // Show the video
            } else {
                self?.postImageView.kf.setImage(with: URL(string: model.link), placeholder: UIImage(named: "Startup"))
                self?.muteButton.isEnabled = false
            }
            
        }
        CacheManager.shared.getFileWith(stringUrl: model.link) { result in

                        switch result {
                        case .success(let url):
                            self.player = AVPlayer(url: url)
                            self.playerLayer = AVPlayerLayer(player: self.player)
                            
                            self.playerLayer.videoGravity = .resizeAspect
                            self.mediaView.layer.addSublayer(self.playerLayer)
                            self.player?.play()
                            break
                        case .failure:
                            break
                        }
                    }
        
    }
    
    @objc func playVideoTapped(_ sender: UIButton) {
        print("Play tapped")
        playVideo(url: mediaLink)
    }
    func playVideo(url: String) {
        let videoURL = URL(string: url) ?? URL(fileURLWithPath: "")
        let player = AVPlayer(url: videoURL)
        playerLayer = AVPlayerLayer(player: player)
        
        playerLayer.videoGravity = .resizeAspect
        mediaView.layer.addSublayer(playerLayer)
        player.play()
    }
    
}



import SwiftUI
struct CollectionCellViewProvider: PreviewProvider {
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
