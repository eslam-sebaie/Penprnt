//
//  LoginPhoneView.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 4/29/21.
//

import UIKit

import SKCountryPicker
class LoginPhoneView: UIView {

  
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var countryCode: UILabel!
    @IBOutlet weak var countryImageView: UIImageView!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var nextDesign: UIButton!
    
    var phoneNumberWithCode = ""
    var verification_id: String? = nil
    func updateUI(){
        
        mainView.dropShadow(radius: 8, shadow: 4)
        phoneView.setBCdesign(borderWidth: 1, borderColor: ColorName.welcomeBorder.color, radius: 8)
        nextDesign.setCornerRadius(radius: 8)
        
    }
}
