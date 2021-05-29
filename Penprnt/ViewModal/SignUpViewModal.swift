//
//  SignUpViewModal.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 5/3/21.
//

import Foundation
protocol SignUpViewModelProtocol {
    func SignUp(name: String?, emailNumber: String?, address: String?, dateOfBirth: String?, gender: String?, phoneNumber: String ,password: String?, lat: String, lng: String, points: String?)
    
}
class SignUpViewModel{
    
    // MARK:- Properties
    weak var view: SignUpProtocol!
    var imag: String = ""
    // MARK:- Initialization Methods
    init(view: SignUpProtocol) {
        self.view = view
    }
    
}
extension SignUpViewModel: SignUpViewModelProtocol {
    func SignUp(name: String?, emailNumber: String?, address: String?, dateOfBirth: String?, gender: String?, phoneNumber: String ,password: String?, lat: String, lng: String, points: String?) {
        
        self.view.showLoader()
        APIManager.userRegister(name: name ?? "", emailNumber: emailNumber!, address: address ?? "", dateOfBirth: dateOfBirth ?? "", gender: gender ?? "", phoneNumber: phoneNumber ,password: password!, lat: lat, lng: lng, points: points ?? "") { (response) in
                switch response {
                case .failure(let err):
                    print(err)
                    self.view.showAlert(title: "Sorry!", msg: "Email Is Aleardy Token.")
                    self.view.hideLoader()
                case .success(let result):
                    print(result)
                    self.view.hideLoader()
                    self.view.presentSignIn()
                }
            }
        }
    
}
