//
//  SignUpVC.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 4/29/21.
//

import UIKit
import SKCountryPicker
import FirebaseAuth
import CoreLocation
import MapKit
protocol SignUpProtocol: class {
    func hideLoader()
    func showLoader()
    func showAlert(title: String , msg: String)
    func presentCategory()
    func presentSignIn()
}
class SignUpVC: UIViewController, sendingAddress, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    @IBOutlet var signUpView: SignUpView!
    private var signUpViewModel: SignUpViewModelProtocol!
    var lat = 0.0
    var lng = 0.0
    var userImage = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpView.genderPickerView.delegate = self
        signUpView.genderTF.inputView = signUpView.genderPickerView
        signUpView.genderPickerView.dataSource = self
        updateCountryCode()
        signUpView.updateUI()
        APIManager.uploadPhoto(image: UIImage(named: "editProfile")!) { (err, img) in
            self.userImage = img?.data ?? ""
        }
    }
    
    class func create() -> SignUpVC {
        let signUpVC: SignUpVC = UIViewController.create(storyboardName: Storyboards.main, identifier: ViewControllers.signUpVC)
        signUpVC.signUpViewModel = SignUpViewModel(view: signUpVC) 
        return signUpVC
    }
    
    
    @IBAction func mapPressed(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let mapVC = sb.instantiateViewController(withIdentifier: "MapVC") as! MapVC
        mapVC.delegate = (self as sendingAddress)
        self.present(mapVC ,animated: true, completion: nil)
    }
    
    @IBAction func countryPressed(_ sender: Any) {
        let countryController = CountryPickerWithSectionViewController.presentController(on: self) { [weak self] (country: Country) in
            
            guard let self = self else { return }
            self.signUpView.countryImage.image = country.flag
            self.signUpView.countryCode.text = country.dialingCode
        }
        countryController.flagStyle = .corner
        countryController.detailColor = UIColor.red
    }
    
    
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUpPressed(_ sender: Any) {
        guard let email = signUpView.emailTF.text, email != "" else {
            self.show_Alert("Please", "Enter Your Email")
            return
        }
        guard let phone = signUpView.phoneTF.text, phone != "" else {
            self.show_Alert("Please", "Enter Your Phone Number")
            return
        }
        guard let address = signUpView.deliveryAddress.text, address != "" else {
            self.show_Alert("Please", "Enter Your Address")
            return
        }
        guard let password = signUpView.passwordTF.text, password != "" else {
            self.show_Alert("Please", "Enter Your password")
            return
        }
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = self.signUpView.deliveryAddress.text ?? ""
        let activeSearch = MKLocalSearch(request: searchRequest)
        activeSearch.start { (response, err) in
            if response == nil {
                self.show_Alert("Sorry!","No Result Found")
                
            }
            else {
                
                let latitude = response?.boundingRegion.center.latitude
                let longitude = response?.boundingRegion.center.longitude
                
                self.lat = Double(latitude!)
                self.lng = Double(longitude!)
                let response = Validation.shared.validate(values: (type: Validation.ValidationType.email, email),(Validation.ValidationType.phoneNo,phone))
                
                switch response {
                case .failure(_, let message):
                    self.show_Alert("Sorry!", message.localized())
                case .success:
                    self.showLoader()
                    self.checkotp()
                }
            }
        }
    
        
        
    }
    
    @IBAction func verifyDesign(_ sender: Any) {
        if self.signUpView.otp_tf.text?.count == 6 {
            let credienial = PhoneAuthProvider.provider().credential(withVerificationID: self.signUpView.verification_id ?? "", verificationCode: self.signUpView.otp_tf.text!)
            Auth.auth().signIn(with: credienial) { (authData, error) in
                if error != nil {
                    self.show_Alert("Sorry!", "Invalid Code")
                }
                else {
                    print("Auth success" + (authData?.user.phoneNumber)!)
                    self.signUpViewModel.SignUp(name: self.signUpView.nameTF.text, emailNumber: self.signUpView.emailTF.text, address: self.signUpView.deliveryAddress.text, dateOfBirth: self.signUpView.dateTimeStamp, gender: self.signUpView.genderTF.text, phoneNumber: (authData?.user.phoneNumber)!,password: self.signUpView.passwordTF.text, lat: String(self.lat), lng: String(self.lng), points: "10", image: self.userImage)
                }
            }
        }
        else {
            show_Alert("Sorry!", "Please Complete Verification Number.")
        }
        
    }
    
    func send(address: String) {
        signUpView.deliveryAddress.text = address
    }
    
    func checkotp() {
        // +201142373945
        signUpView.phoneNumberWithCode = signUpView.countryCode.text! + signUpView.phoneTF.text!
        print(signUpView.phoneNumberWithCode)
        PhoneAuthProvider.provider().verifyPhoneNumber(signUpView.phoneNumberWithCode, uiDelegate: nil) { (verificationID, error) in
            if error == nil{
                self.signUpView.verification_id = verificationID
                if self.signUpView.verification_id != nil {
                    self.signUpView.myScrollView.scrollToTop()
                    self.signUpView.signUpView.dropShadow(radius: 1, shadow: 0)
                    self.hideLoader()
                    self.signUpView.mainOTPView.isHidden = false
                }
            }
            else {
                self.show_Alert("Sorry!", "You Are Blocked Try Later")
            }
        }
    }
    
    func updateCountryCode() {
        let countryController = CountryPickerWithSectionViewController.presentController(on: self) { [weak self] (country: Country) in
            
            guard let self = self else { return }
            self.signUpView.countryImage.image = country.flag
            self.signUpView.countryCode.text = country.dialingCode
            
        }
        
        guard let country = CountryManager.shared.currentCountry else {
            self.signUpView.countryCode.text = "+1"
            signUpView.countryImage.isHidden = false
            signUpView.countryImage.image = UIImage(named: "US.png")
            return
        }
        signUpView.countryCode.text = country.dialingCode
        signUpView.countryImage.image = country.flag
        signUpView.countryCode.clipsToBounds = true
    }
    
    @IBAction func signInPressed(_ sender: Any) {
        let signIn = SignInVC.create()
        self.present(signIn, animated: true, completion: nil)
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return signUpView.genderArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        signUpView.genderTF.text = signUpView.genderArray[row]
        
    }
}
extension SignUpVC: SignUpProtocol{
    
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
        let tabVC = storyboard.instantiateViewController(withIdentifier: "tabViewController")
        self.present(tabVC, animated: true, completion: nil)
    }
    
}
extension UIScrollView {
    func scrollToTop() {
        let desiredOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(desiredOffset, animated: true)
   }
}
