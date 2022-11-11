//
//  CustomTextField.swift
//  blinqpost
//
//  Created by Oko-osi Korede on 11/11/2022.
//

import Foundation
import UIKit

class CustomTextField: UIControl {

    
    public var buttonImage: UIImage = UIImage(named: "x") ?? UIImage() {
        didSet {
            trailingButtton.setImage(buttonImage, for: .normal)
        }
    }
    public var tfErrorText: String = "" {
        didSet {
            bgView.borderColor = tfErrorText.isEmpty ? defaultBorderColor : .red
            textFieldErrorLabel.text = tfErrorText
            textFieldErrorLabel.isHidden = tfErrorText.isEmpty
        }
    }
    
    public var textFieldLabelText: String = "" {
        didSet {
            textFieldLabel.text = " \(textFieldLabelText) "
        }
    }
    public var defaultBorderColor: UIColor = .black {
        didSet {
            bgView.borderColor  = defaultBorderColor
        }
    }
    public var textFieldPlaceholder: String = "" {
        didSet {
            textField.placeholder = textFieldPlaceholder
            textField.placeholderColor(color: .gray)
            
        }
    }
    public var showTrailingButton: Bool = false {
        didSet {
            trailingButtton.isHidden = !showTrailingButton
        }
    }
    public var tfCornerRadius: CGFloat = 5 {
        didSet {
            bgView.cornerRadius = tfCornerRadius
        }
    }
    
    public var text: String = "" {
        didSet {
            sendActions(for: .valueChanged)
            textField.text = text
            bgView.borderColor = defaultBorderColor
        }
    }
    
    private lazy var bgView = UIView.bgView()
    private lazy var textField = UITextField.textField()
    private lazy var trailingButtton = UIButton()
    private lazy var textFieldLabel = UILabel.normalLabel(text: textFieldLabelText)
    private lazy var textFieldErrorLabel = UILabel.normalLabel(text: tfErrorText)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView() {
        setup()
    }
    
    private func setup() {
//        borderWidth = 2
        [bgView, textFieldLabel, textField, trailingButtton, textFieldErrorLabel].forEach { newView in
            addSubview(newView)
        }
        trailingButtton.setImage(UIImage(named: "x"), for: .normal)
        textFieldLabel.isHidden = true
        textFieldErrorLabel.isHidden = true
        textField.delegate = self
        textField.backgroundColor = .clear
        
        bgView.setViewConstraints(top: topAnchor, right: trailingAnchor, bottom: bottomAnchor, left: leadingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 10, paddingRight: 0)
        bgView.borderWidth = 2
        textField.setViewConstraints(top: bgView.topAnchor, right: trailingAnchor, bottom: bgView.bottomAnchor, left: leadingAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 5, paddingRight: 10)
        textFieldLabel.setViewConstraints(top: topAnchor, right: nil, bottom: nil, left: leadingAnchor, paddingTop: -3, paddingLeft: 20, paddingBottom: 0, paddingRight: 0)
        trailingButtton.setViewConstraints(top: nil, right: trailingAnchor, bottom: nil, left: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 10)
        trailingButtton.setCenterAnchor(vertical: centerYAnchor, horizontal: nil, height: heightAnchor, heightMultiplier: 0.2, width: heightAnchor, widthMultiplier: 0.2)
        textFieldErrorLabel.setViewConstraints(top: bgView.bottomAnchor, right: nil, bottom: nil, left: bgView.leadingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: -4, paddingRight: 0)
        
        textFieldLabel.font = UIFont.systemFont(ofSize: 8, weight: .bold)
        textFieldLabel.textColor = .systemGray
        
        textFieldErrorLabel.font = UIFont.systemFont(ofSize: 8, weight: .semibold)
        textFieldErrorLabel.textColor = .red
        
        
        textFieldLabel.backgroundColor = .white
        trailingButtton.backgroundColor = .clear
        trailingButtton.tintColor = .black
        
        
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        trailingButtton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    @objc func buttonTapped(_ sender: UIButton) {
        print("This button will cancel the text")
        textField.text = ""
        textFieldLabel.isHidden = true
        sendActions(for: .touchUpInside)
    }
    
}

extension CustomTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        defaultBorderColor = .purple
        if let text = textField.text {
            self.text = text
            textFieldLabel.isHidden = false
        } else {
            
        }
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        defaultBorderColor = tfErrorText.isEmpty ? .black : .red
        if let text = textField.text {
            self.text = text
            if text.count < 1 {
                textFieldLabel.isHidden = true
            } else {
                
            }
            bgView.borderColor = defaultBorderColor
        } else {
            textFieldLabel.isHidden = true
            bgView.borderColor = defaultBorderColor
        }
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField){
        if let text = textField.text {
            self.text = text
            if text.count < 1 {
                textFieldLabel.isHidden = true
            } else {
                
            }
        } else {
            textFieldLabel.isHidden = true
        }
    }
    
}

