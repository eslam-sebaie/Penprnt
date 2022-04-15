//
//  SignInView.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 4/29/21.
//

import UIKit

class SignInView: UIView {
    
    @IBOutlet weak var signInBG: UIImageView!
    @IBOutlet weak var signInLabel: UILabel!
    @IBOutlet weak var signInView: UIView!
    @IBOutlet weak var upperSignInView: UIView!
    @IBOutlet weak var signInDesign: UIButton!
    @IBOutlet weak var emailOrPhoneTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var backDesign: UIButton!
    
    func updateUI(){

        if L10n.lang.localized == Language.arabic {
            signInLabel.text = L10n.signInLabel.localized
            signInLabel.textAlignment = .right
            backDesign.transform = CGAffineTransform(scaleX: -1, y: 1)
        }
        
        signInBG.image = Asset.signInBackGround.image
        

        signInView.dropShadow(scale: true, radius: 8, shadow: 4)

        upperSignInView.setCornerRadius(radius: 8)
        upperSignInView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        signInDesign.setBCdesign(borderWidth: 0, borderColor: .white, radius: 8)


    }
   

}
