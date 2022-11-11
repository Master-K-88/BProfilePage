//
//  CustomSegmentedControl.swift
//  blinqpost
//
//  Created by Oko-osi Korede on 11/11/2022.
//

import Foundation
import UIKit
import SwiftUI

class CustomSegmentedHeader: UIView {
    
    public var postButton = UIButton.mediaButton(with: "")
    public var videoButton = UIButton.mediaButton(with: "")
    public var showPostUnderLine: Bool = true {
        didSet {
            postUndeling.isHidden = !showPostUnderLine
            changeSelectedState()
        }
    }
    
    public var showVideoUnderline: Bool = false {
        didSet {
            videoUnderline.isHidden = !showVideoUnderline
            changeSelectedState()
        }
    }
    
    
    private lazy var postTitle = UILabel.normalLabel(text: "Post")
    private lazy var videoTitle = UILabel.normalLabel(text: "Video")
    private lazy var postUndeling = UIView.bgView()
    private lazy var videoUnderline = UIView.bgView()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        showVideoUnderline = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupViews() {
        [postTitle, postButton, postUndeling, videoTitle, videoButton, videoUnderline].forEach { btn in
            addSubview(btn)
        }
        postButtonSetup()
        videoButtonSetup()
    }
    
    fileprivate func postButtonSetup() {
        postTitle.setViewConstraints(top: topAnchor, right: nil, bottom: bottomAnchor, left: leadingAnchor, paddingLeft: 20)
        postTitle.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        postButton.setViewConstraints(top: topAnchor, right: nil, bottom: bottomAnchor, left: leadingAnchor)
        postButton.setCenterAnchor(vertical: nil, horizontal: nil, height: heightAnchor, heightMultiplier: 1.0, width: widthAnchor, widthMultiplier: 0.5)
        postUndeling.setViewConstraints(top: postTitle.bottomAnchor, right: postTitle.trailingAnchor, bottom: nil, left: postTitle.leadingAnchor, height: 2)
        postUndeling.backgroundColor = .black
        postButton.backgroundColor = .systemBackground.withAlphaComponent(0.3)
    }
    
    fileprivate func videoButtonSetup() {
        videoTitle.setViewConstraints(top: topAnchor, right: nil, bottom: bottomAnchor, left: postButton.trailingAnchor)
        videoTitle.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        videoButton.setViewConstraints(top: topAnchor, right: trailingAnchor, bottom: bottomAnchor, left: nil)
        videoButton.setCenterAnchor(vertical: nil, horizontal: nil, height: heightAnchor, heightMultiplier: 1, width: widthAnchor, widthMultiplier: 0.5)
        videoUnderline.setViewConstraints(top: videoTitle.bottomAnchor, right: videoTitle.trailingAnchor, bottom: nil, left: videoTitle.leadingAnchor, height: 2)
        videoUnderline.backgroundColor = .black
        videoButton.backgroundColor = .clear
    }
    
    func changeSelectedState() {
        if showVideoUnderline {
            videoTitle.textColor = .black
            postTitle.textColor = .gray
        } else {
            postTitle.textColor = .black
            videoTitle.textColor = .gray
        }
    }
}

struct CustomHeaderPreview: PreviewProvider {
    static var previews: some View {
        ContainerView()
            .previewLayout(.fixed(width:  UIScreen.main.bounds.width, height: 70))
            .frame(width: UIScreen.main.bounds.width, height: 70)
    }
    
    struct ContainerView: UIViewRepresentable {
        func makeUIView(context: Context) -> some UIView {
            CustomSegmentedHeader()
        }
        
        func updateUIView(_ uiView: UIViewType, context: Context) {
            
        }
    }
}
