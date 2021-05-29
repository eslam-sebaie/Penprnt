//
//  SignInVC.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 4/29/21.
//

import UIKit

class SignInVC: UIViewController, SignUpProtocol {

    @IBOutlet var signInView: SignInView!
    var signInViewModal: SignInViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        signInView.updateUI()
    }
    
    class func create() -> SignInVC {
        let signInVC: SignInVC = UIViewController.create(storyboardName: Storyboards.main, identifier: ViewControllers.signInVC)
        signInVC.signInViewModal = SignInViewModel(view: signInVC)
        return signInVC
    }

    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func signUpVC(_ sender: Any) {
        let signUp = SignUpVC.create()
        self.present(signUp, animated: true, completion: nil)
    }
    @IBAction func SignInPressed(_ sender: Any) {
       
        self.signInViewModal.SignIn(email: signInView.emailOrPhoneTF.text, password: signInView.passwordTF.text)
    }
}
extension SignInVC {
    
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
        let catVC = storyboard.instantiateViewController(withIdentifier: "CategoryVC") as! CategoryVC
        self.present(catVC, animated: true, completion: nil)
    }
    
}
