//
//  LoginPhoneVC.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 4/29/21.
//

import UIKit
import SKCountryPicker
import FirebaseAuth
class LoginPhoneVC: UIViewController {

    @IBOutlet var loginPhoneView: LoginPhoneView!
    override func viewDidLoad() {
        super.viewDidLoad()

        loginPhoneView.updateUI()
        updateCountryCode()
    }
    
    class func create() -> LoginPhoneVC {
        let phoneVC: LoginPhoneVC = UIViewController.create(storyboardName: Storyboards.main, identifier: ViewControllers.loginPhoneVC)
        return phoneVC
    }
    
    @IBAction func nextPressed(_ sender: Any) {
        guard let phone = self.loginPhoneView.phoneTF.text, phone != "" else {
            show_Alert("Sorry!", "You Must Enter Phone Number.")
            return
        }
        checkotp()
    }
    
    
    @IBAction func chooseCountryPressed(_ sender: Any) {
        let countryController = CountryPickerWithSectionViewController.presentController(on: self) { [weak self] (country: Country) in
            
            guard let self = self else { return }
            self.loginPhoneView.countryImageView.image = country.flag
            self.loginPhoneView.countryCode.text = country.dialingCode
        }
        countryController.flagStyle = .corner
        countryController.detailColor = UIColor.red
    }
    
    func updateCountryCode(){
        let countryController = CountryPickerWithSectionViewController.presentController(on: self) { [weak self] (country: Country) in
            
            guard let self = self else { return }
            self.loginPhoneView.countryImageView.image = country.flag
            self.loginPhoneView.countryCode.text = country.dialingCode
            
        }
        
        guard let country = CountryManager.shared.currentCountry else {
            self.loginPhoneView.countryCode.text = "+1"
            loginPhoneView.countryImageView.isHidden = false
            loginPhoneView.countryImageView.image = UIImage(named: "US.png")
            return
        }
        loginPhoneView.countryCode.text = country.dialingCode
        loginPhoneView.countryImageView.image = country.flag
        loginPhoneView.countryCode.clipsToBounds = true
    }
    func checkotp() {
        // +201142373945
        loginPhoneView.phoneNumberWithCode = loginPhoneView.countryCode.text! + loginPhoneView.phoneTF.text!
        print(loginPhoneView.phoneNumberWithCode)
        PhoneAuthProvider.provider().verifyPhoneNumber(loginPhoneView.phoneNumberWithCode, uiDelegate: nil) { (verificationID, error) in
            if error == nil{
                self.loginPhoneView.verification_id = verificationID
                if self.loginPhoneView.verification_id != nil {
                    let phoneVerify = PhoneVerifyVC.create()
                    phoneVerify.verificationID = verificationID!
                    self.present(phoneVerify, animated: true, completion: nil)
                    
                }
            }
            else {
                self.show_Alert("Sorry!", "You Are Blocked Try Later")
            }
        }
    }


}
