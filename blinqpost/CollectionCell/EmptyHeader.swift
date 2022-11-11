//
//  EmptyHeader.swift
//  blinqpost
//
//  Created by Oko-osi Korede on 11/11/2022.
//

import UIKit

class EmptyHeader: UICollectionReusableView {
        
    static let identifier = "EmptyHeader"
    
    lazy var bgView = UIView.bgView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .clear
        setupView()
    }
    
    func setupView() {
        addSubview(bgView)
        bgView.frame = bounds
        bgView.backgroundColor = .clear
        
    }
}
