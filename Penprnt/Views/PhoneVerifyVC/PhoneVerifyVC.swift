//
//  PhoneVerifyVC.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 4/29/21.
//

import UIKit
import SGCodeTextField
import FirebaseAuth
class PhoneVerifyVC: UIViewController {

    @IBOutlet var phoneVerifyView: PhoneVerifyView!
    private var phoneViewModal: WelcomeViewModelProtocol!
    var verificationID = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        phoneVerifyView.updateUI()
        // Do any additional setup after loading the view.
    }
    

    
    class func create() -> PhoneVerifyVC {
        let phoneVerifyVC: PhoneVerifyVC = UIViewController.create(storyboardName: Storyboards.main, identifier: ViewControllers.phoneVerifyVC)
        phoneVerifyVC.phoneViewModal = WelcomeViewModel(view: phoneVerifyVC)
        return phoneVerifyVC
    }
    
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func verifyPressed(_ sender: Any) {
        
        if self.phoneVerifyView.tf_otp.text?.count == 6 {
            let credienial = PhoneAuthProvider.provider().credential(withVerificationID: self.verificationID, verificationCode: self.phoneVerifyView.tf_otp.text!)
            Auth.auth().signIn(with: credienial) { (authData, error) in
                if error != nil {
                    print(error)
                    self.show_Alert("Sorry!", "Invalid Code")
                }
                else {
                    print("Auth success" + (authData?.user.phoneNumber)!)
                    self.phoneViewModal.SignUp(email: (authData?.user.phoneNumber)!)
                }
            }
        }
        else {
            show_Alert("Sorry!", "Please Complete Verification Number.")
        }
        
    }
    
    
    @objc func hide(sender: SGCodeTextField){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        hideKeyboardWhenTappedAround()
    }
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension PhoneVerifyVC: SignUpProtocol{
    
    func presentSignIn() {
        let signInVC = SignInVC.create()
        self.present(signInVC ,animated: true, completion: nil)
    }
    func hideLoader() {
        self.view.hideLoader()
    }
    
    func showLoader() {
        self.view.showLoader()
    }
    func showAlert(title: String, msg: String) {
        self.show_Alert(title, msg)
    }
    func presentCategory() {
        let storyboard = UIStoryboard(name: Storyboards.home, bundle: nil)
        let catVC = storyboard.instantiateViewController(withIdentifier: "tabViewController") as! tabViewController
        self.present(catVC, animated: true, completion: nil)
    }
    
}
