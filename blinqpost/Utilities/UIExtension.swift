//
//  UIExtension.swift
//  blinqpost
//
//  Created by Oko-osi Korede on 11/11/2022.
//

import Foundation
import UIKit

extension UIView {
    class func bgView() -> UIView {
        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false/
         return view
    }
    
    class func customShadowView() -> UIView {
        let view = UIView()
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.45
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 5
        view.layer.masksToBounds = false
        
        return view
    }
    
    class func headerView(headerText: String) -> UIView {
        let view = UIView.bgView()
        let label = UILabel.headerLabel(text: headerText)
        view.addSubview(label)
        label.pin(to: view, top: 0, left: 0, bottom: 0, right: nil)
        return view
    }
    
    class func imageView() -> UIImageView {
        let imageView = UIImageView()
//        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
    class func imageViewWithImage(image: String) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: image)
        imageView.clipsToBounds = true
//        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
    class func imageViewWithDataImage(image: Data) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(data: image)
        imageView.clipsToBounds = true
        return imageView
    }
}

extension UITextField {
    
    class func textField() -> UITextField {
        let textfield = UITextField()
        textfield.cornerRadius = 10
        textfield.textAlignment = .left
        textfield.backgroundColor = UIColor(named: "textColor")
        return textfield
    }
    
    func setIcon(_ image: UIImage) {
        let height  = self.frame.height
        
        let iconView = UIImageView(frame: CGRect(x: 6, y: 4, width: 24, height: 24))
        iconView.image = image
//        iconView.tintColor = UIColor(named: ColorRes.label_color)
        
        let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: (height-36)/2, width: 36, height: 36))
        iconContainerView.addSubview(iconView)
        
        leftView = iconContainerView
        leftViewMode = .always
    }
   
    
    func placeholderColor(color: UIColor) {
        let attributeString = [
            NSAttributedString.Key.foregroundColor: color.withAlphaComponent(0.6),
            NSAttributedString.Key.font: self.font!
            ] as [NSAttributedString.Key : Any]
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: attributeString)
    }
    
    func setBottomBorder(withColor color: UIColor){
        self.borderStyle = UITextField.BorderStyle.none
        self.backgroundColor = UIColor.clear
        let height: CGFloat = 1.0
        let borderLine = UIView(frame: CGRect(x: 0, y: self.frame.height - height, width: self.frame.width, height: height))
        borderLine.backgroundColor = color
        self.addSubview(borderLine)
    }
}

extension UILabel {
    
    class func titleLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .label
        label.font = UIFont(name: "Poppins-Bold", size: 18)
        label.numberOfLines = 0
//        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    class func normalLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = UIColor(named: "textColor")
        label.font = UIFont(name: "Poppins-Bold", size: 12)
        label.numberOfLines = 0
//        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    class func mediaLabel(text: String) -> UILabel {
        let label = UILabel()
//        label.text =
        let attributedString = NSAttributedString(string: NSLocalizedString(text, comment: ""), attributes:[
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16.0),
            NSAttributedString.Key.foregroundColor : UIColor.gray,
            NSAttributedString.Key.underlineStyle:1.0
        ])
        label.attributedText = attributedString
        label.textColor = UIColor(named: "textColor")
        label.font = UIFont(name: "Poppins-Bold", size: 12)
        label.numberOfLines = 0
//        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    class func headerLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .white
        label.font = UIFont(name: "Poppins-Bold", size: 18)
//        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
        
    
    class func subHeaderLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.font = UIFont(name: "Poppins-Medium", size: 10)
//        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
}

extension UICollectionView {
    class func genericCollectionView(direction: UICollectionView.ScrollDirection) -> UICollectionView {
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        collectionLayout.minimumInteritemSpacing = 10.0
        collectionLayout.minimumLineSpacing = 10.0
        collectionLayout.scrollDirection = direction
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false

        return collectionView
    }
}

extension UIImage {
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else {
            return nil
        }
        self.init(cgImage: cgImage)
    }
    
    func resized(withPercentage percentage: CGFloat) -> UIImage? {
        let canvas = CGSize(width: size.width * percentage, height: size.height * percentage)
        return UIGraphicsImageRenderer(size: canvas, format: imageRendererFormat).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
    func resized(toWidth width: CGFloat) -> UIImage? {
        let canvas = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        return UIGraphicsImageRenderer(size: canvas, format: imageRendererFormat).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
    
    
    
}

extension UIImage {
    func getPixelColor(pos: CGPoint) -> UIColor {

        let pixelData = self.cgImage!.dataProvider!.data
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)

        let pixelInfo: Int = ((Int(self.size.width) * Int(pos.y)) + Int(pos.x)) * 4

        let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
        let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
        let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
        let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)

        return UIColor(red: r, green: g, blue: b, alpha: a * 0.5)
    }

}
extension UIView{
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func addShadow(offset: CGSize, color: UIColor = .black, opacity: Float = 0.75, radius: CGFloat = 5.0) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
    }
    
    func pin(to superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
    }
    
    func pin(to superView: UIView, top: CGFloat?, left: CGFloat?, bottom: CGFloat?, right: CGFloat?) {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            topAnchor.constraint(equalTo: superView.topAnchor, constant: top).isActive = true
        }
        if let left = left {
            leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: left).isActive = true
        }
        
        if let right = right {
            trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: right).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: bottom).isActive = true
        }
        
    }
    
    func createDashedLine(from pointA: CGPoint, to pointB: CGPoint, view: UIView) {
        let shapeLayer = CAShapeLayer()
        
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = [7, 3]
        
        let path = CGMutablePath()
        path.addLines(between: [pointA, pointB])
        shapeLayer.path = path
        view.layer.addSublayer(shapeLayer)
    }
    func addProfileBlurEffect()
    {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height * 0.48)
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView)
    }
    
    func removeBlurEffect() {
        let blurredEffectViews = self.subviews.filter{$0 is UIVisualEffectView}
        blurredEffectViews.forEach{ blurView in
          blurView.removeFromSuperview()
        }
    }
    
    func setViewConstraints(top: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, paddingTop: CGFloat = 0, paddingLeft: CGFloat = 0, paddingBottom: CGFloat = 0, paddingRight: CGFloat = 0, width: CGFloat = 0, height: CGFloat = 0) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let right = right {
            self.trailingAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let left = left {
            self.leadingAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if width != 0 {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func setCenterAnchor(vertical: NSLayoutYAxisAnchor?,
                         horizontal: NSLayoutXAxisAnchor?,
                         height: NSLayoutDimension?,
                         heightMultiplier: CGFloat = 1,
                         width: NSLayoutDimension?,
                         widthMultiplier: CGFloat = 1) {
        self.translatesAutoresizingMaskIntoConstraints = false
        if let vertical = vertical {
            self.centerYAnchor.constraint(equalTo: vertical).isActive = true
        }
        if let horizontal = horizontal {
            self.centerXAnchor.constraint(equalTo: horizontal).isActive = true
        }
        if let height = height {
            self.heightAnchor.constraint(equalTo: height, multiplier: heightMultiplier).isActive = true
        }
        if let width = width {
            self.widthAnchor.constraint(equalTo: width, multiplier: widthMultiplier).isActive = true
        }
    }
    
    var safeTopAnchor: NSLayoutYAxisAnchor {
        safeAreaLayoutGuide.topAnchor
    }
    
    var safeRightAnchor: NSLayoutXAxisAnchor {
        safeAreaLayoutGuide.trailingAnchor
    }
    
    var safeBottomAnchor: NSLayoutYAxisAnchor {
        safeAreaLayoutGuide.bottomAnchor
    }
    
    var safeLeftAnchor: NSLayoutXAxisAnchor {
        safeAreaLayoutGuide.leadingAnchor
    }
    
}

extension UIStackView {
    class func equalStack(space: CGFloat, axis: NSLayoutConstraint.Axis) -> UIStackView {
        let stack = UIStackView()
        stack.axis = axis
        stack.backgroundColor = .clear
        stack.spacing = space
        stack.distribution = .fillEqually
        stack.alignment = .fill
//        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }
    class func proportionalStack(space: CGFloat, axis: NSLayoutConstraint.Axis) -> UIStackView {
        let stack = UIStackView()
        stack.axis = axis
//        stack.backgroundColor = .clear
        stack.spacing = space
        stack.distribution = .fillProportionally
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }
}

extension UIPageControl {
    class func pageControl(numPages: Int) -> UIPageControl{
        let pageControl = UIPageControl()
        pageControl.numberOfPages = numPages
        return pageControl
    }
}

extension UIButton {
    class func buttonWithImage(with image: UIImage) -> UIButton {
        let button = UIButton()
        button.setImage(image, for: .normal)
        button.tintColor = UIColor(named: "textColor")
//        button.cornerRadius = 5
//        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    class func playButton(with image: UIImage) -> UIButton {
        let button = UIButton()
        button.setImage(image, for: .normal)
//        button.tintColor = getColor(hex: "#dddddd")
        button.backgroundColor = .white
//        button.cornerRadius = 10
//        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    class func buttonWithTitle(with title: String, bgcolor: UIColor?) -> UIButton {
        let button = UIButton()
        button.cornerRadius = 10
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor(named: "textColor"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        button.backgroundColor = bgcolor ?? UIColor(named: "bgColor")
//        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    class func mediaButton(with title: String) -> UIButton {
        let button = UIButton()
        button.configuration = .plain()
        var config = UIButton.Configuration.plain()
        
        config.titlePadding = 10
        config.baseForegroundColor = .label
        config.titleAlignment = .leading
        button.configuration = config
//        let attributedString = NSAttributedString(string: NSLocalizedString(title, comment: ""), attributes:[
//            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16.0),
//            NSAttributedString.Key.foregroundColor : UIColor.gray,
//            NSAttributedString.Key.underlineStyle:1.0
//        ])
//        button.setAttributedTitle(attributedString, for: .normal)
        return button
    }
    
    class func buttonWithTitleAndImage(with image: UIImage, title: String) -> UIButton {
        let button = UIButton()
        button.setImage(image, for: .normal)
        button.setTitle(title, for: .normal)
//        button.tintColor = getColor(hex: "#dddddd")
        button.cornerRadius = 10
//        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}

