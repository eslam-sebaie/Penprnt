//
//  ProfileVC.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 5/23/21.
//

import UIKit

class ProfileVC: UIViewController, sendingAddress {
    func send(address: String) {
        print(address)
    }
    

    
    @IBOutlet var profileView: ProfileView!
    var imagePicker = UIImagePickerController()
    var storeImg = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        profileView.updateUI()
        // Do any additional setup after loading the view.
    }
    
    class func create() -> ProfileVC {
        let profileVC: ProfileVC = UIViewController.create(storyboardName: Storyboards.profile, identifier: ViewControllers.profileVC)
        return profileVC
    }
    override func viewWillAppear(_ animated: Bool) {
        APIManager.searchUser(emailNumber: UserDefaultsManager.shared().Email ?? "") { (response) in
            switch response {
            case .failure(let err):
                print(err)
            case .success(let result):
                print(result)
                self.profileView.pointsLabel.text = result.data[0].points ?? ""
                self.profileView.userImage.sd_setImage(with: URL(string: result.data[0].image ?? ""), completed: nil)
                self.profileView.userName.text = result.data[0].name
            }
        }
    }
    
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func userImagePressed(_ sender: Any) {
        setImagePicker()
    }
    
    @IBAction func profileSettingPressed(_ sender: Any) {
        let edit = EditProfileVC.create()
        self.present(edit, animated: true, completion: nil)
    }
    
    @IBAction func orderHistoryPressed(_ sender: Any) {
        if UserDefaultsManager.shared().Email == nil || UserDefaultsManager.shared().Email == "" {
            showAlert(title: "Sorry No Account.", massage: "Do You Want To Register?", present: self, titleBtn: "OK") {
                let signUp = SignUpVC.create()
                self.present(signUp, animated: true, completion: nil)
            }
        }
        else {
            let orderHistory = OrderHistoryVC.create()
            self.present(orderHistory, animated: true, completion: nil)
        }
    }
    
    @IBAction func locationPressed(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let mapVC = sb.instantiateViewController(withIdentifier: "MapVC") as! MapVC
        mapVC.delegate = (self as sendingAddress)
        mapVC.checkCat = true
        self.present(mapVC ,animated: true, completion: nil)
        
    }
    @IBAction func sharePressed(_ sender: Any) {
        let activityVC = UIActivityViewController(activityItems: ["www.google.com"], applicationActivities: nil)
            self.present(activityVC, animated: true, completion: nil)
    }
    
    @IBAction func privacyPressed(_ sender: Any) {
        if let url = URL(string: "https://phistory.life/Phistory/public/privacy/policy") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func signOutPressed(_ sender: Any) {
        UserDefaultsManager.shared().Token = ""
        UserDefaultsManager.shared().Email = ""
        UserDefaultsManager.shared().phone = ""
        let signOut = WelcomeVC.create()
        self.present(signOut, animated: true, completion: nil)
    }
    
    
    
}
extension ProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func setImagePicker(){
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        profileView.userImage.image = image
        self.profileView.showLoader()
        APIManager.uploadPhoto(image: image!) { (err, img) in
            APIManager.updateImage(emailNumber: UserDefaultsManager.shared().Email ?? "", image: img?.data ?? "") {
                self.profileView.hideLoader()
            }
        }
        
        picker.dismiss(animated: false, completion: nil)
    }
}
