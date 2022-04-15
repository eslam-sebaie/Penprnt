//
//  UIView.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 4/29/21.
//

import UIKit
extension UIView {
    func setBCdesign(borderWidth: CGFloat, borderColor: UIColor, radius: CGFloat) {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func dropShadow(scale: Bool = true, radius: CGFloat, shadow: CGFloat) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.layer.shadowRadius = shadow
        self.layer.shouldRasterize = true
        self.layer.cornerRadius = radius
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    func dropShadowProd(scale: Bool = true, radius: CGFloat, shadow: CGFloat) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = ColorName.shadow.color.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.shadowRadius = shadow
        self.layer.shouldRasterize = true
        self.layer.cornerRadius = radius
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func showLoader() {
        let activityIndicator = setupActivityIndicator()
        activityIndicator.startAnimating()
        self.addSubview(activityIndicator)
    }
    
    func hideLoader() {
        if let activityIndicator = viewWithTag(333) {
            activityIndicator.removeFromSuperview()
        }
    }
    
    private func setupActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.frame = self.bounds
        activityIndicator.color = ColorName.mainColor.color
        activityIndicator.tintColor = .blue
        activityIndicator.center = self.center
        activityIndicator.style = .gray
        activityIndicator.transform = CGAffineTransform(scaleX: 2, y: 2)
        activityIndicator.tag = 333
        return activityIndicator
    }
    
    func setCornerRadius(radius: CGFloat) {
        
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}
extension UIImageView {
    func applyshadowWithCorner(containerView : UIView, cornerRadious : CGFloat){
        containerView.clipsToBounds = false
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 1
        containerView.layer.shadowOffset = CGSize.zero
        containerView.layer.shadowRadius = 3
        containerView.layer.cornerRadius = cornerRadious
        containerView.layer.shadowPath = UIBezierPath(roundedRect: containerView.bounds, cornerRadius: cornerRadious).cgPath
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadious
    }
}
extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 20, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 20, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
