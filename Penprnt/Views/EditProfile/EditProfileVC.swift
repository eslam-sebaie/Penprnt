//
//  EditProfileVC.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 5/24/21.
//

import UIKit

class EditProfileVC: UIViewController {

    @IBOutlet var editProfileView: EditProfileView!
    var userData = UserInfo(id: 0, emailNumber: "", password: "", name: "", birthDate: "", phone: "", gender: "", address: "", lat: "", lng: "", points: "", image: "")
    override func viewDidLoad() {
        super.viewDidLoad()
        editProfileView.updateUI()
        
    }
    class func create() -> EditProfileVC {
        let editProfileVC: EditProfileVC = UIViewController.create(storyboardName: Storyboards.profile, identifier: ViewControllers.editProfileVC)
        return editProfileVC
    }
    override func viewWillAppear(_ animated: Bool) {
        APIManager.searchUser(emailNumber: UserDefaultsManager.shared().Email ?? "") { (response) in
            switch response {
            case .failure(let err):
                print(err)
            case .success(let result):
                print(result)
                self.userData = result.data[0]
                self.editProfileView.nameTF.text = result.data[0].name ?? ""
                self.editProfileView.phoneTF.text = result.data[0].phone ?? ""
                self.editProfileView.birthTF.text = UserDefaultsManager.shared().Password ?? ""
                self.editProfileView.emailTF.text = UserDefaultsManager.shared().Email ?? ""
            }
        }
    }

    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func savePressed(_ sender: Any) {
        guard let email = editProfileView.emailTF.text, email != "" else {
            self.show_Alert("Please", "Enter Your Email")
            return
        }
//        guard let name = editProfileView.nameTF.text, name != "" else {
//            self.show_Alert("Please", "Enter Your Name")
//            return
//        }
//        guard let phone = editProfileView.phoneTF.text, phone != "" else {
//            self.show_Alert("Please", "Enter Your Phone Number")
//            return
//        }
        if let pass = self.editProfileView.birthTF.text, pass != "" {
            UserDefaultsManager.shared().Password = pass
        }
        self.editProfileView.showLoader()
        APIManager.updateProfile(emailNumber: email, name: editProfileView.nameTF.text ?? "", phone: editProfileView.phoneTF.text ?? "", dateOfBirth: editProfileView.birthTF.text ?? "", address: userData.address ?? "",gender: userData.gender ?? "",password: self.editProfileView.birthTF.text ?? "", points: self.userData.points ?? "") {
            UserDefaultsManager.shared().Email = email
            self.editProfileView.hideLoader()
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
}
