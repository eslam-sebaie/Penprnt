//
//  SignInViewModal.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 5/3/21.
//

import Foundation
protocol SignInViewModelProtocol {
    func SignIn(email: String?, password: String?)
    
}
class SignInViewModel{
    
    // MARK:- Properties
    weak var view: SignUpProtocol!
    
    // MARK:- Initialization Methods
    init(view: SignUpProtocol) {
        self.view = view
    }
}
extension SignInViewModel: SignInViewModelProtocol {
    func SignIn(email: String?, password: String?) {
       
        guard let email = email, email != "" else {
            self.view.showAlert(title: "Please", msg: "Enter Your Email Or Number")
            
            return
        }
        guard let password = password, password != "" else {
            self.view.showAlert(title: "Please", msg: "Enter Your Password")
            return
        }
        
        let response = Validation.shared.validate(values: (type: Validation.ValidationType.email, email))
        
        switch response {
        case .failure(_, let message):
            self.view.showAlert(title: "Invalid", msg: message.localized())
        case .success:
            self.view.showLoader()
            APIManager.userLogin(email: email, password: password) { (response) in
                switch response {
                case .failure(let err):
                    print(err)
                    self.view.showAlert(title: "Sorry!", msg: "Email Or Password Is Wrong.")
                    self.view.hideLoader()
                case .success(let result):
                    print(result)
                    UserDefaultsManager.shared().Token = result.message
                    UserDefaultsManager.shared().Email = result.data?.emailNumber
                    UserDefaultsManager.shared().phone = result.data?.phone
                    UserDefaultsManager.shared().Password = password
                    self.view.hideLoader()
                    self.view.presentCategory()
                }
            }
            
        }
    }
    
    
}
