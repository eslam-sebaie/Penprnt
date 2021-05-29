//
//  PhoneVerifyView.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 4/29/21.
//

import UIKit
import SGCodeTextField
class PhoneVerifyView: UIView {
   
    @IBOutlet weak var tf_otp: SGCodeTextField!
    @IBOutlet weak var verifyDesign: UIButton!
    
    func updateUI() {
        self.tf_otp.addDoneOnKeyboardWithTarget(self, action: #selector(PhoneVerifyVC.hide(sender:)))
        verifyDesign.setCornerRadius(radius: 8)
    }

}
