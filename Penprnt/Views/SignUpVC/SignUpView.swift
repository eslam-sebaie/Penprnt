//
//  SignUpView.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 4/29/21.
//

import UIKit
import SGCodeTextField
class SignUpView: UIView {

    
    @IBOutlet weak var myScrollView: UIScrollView!
    @IBOutlet weak var signUpView: UIView!
    @IBOutlet weak var upperSignUpView: UIView!
    @IBOutlet weak var signUpImage: UIImageView!
    @IBOutlet weak var signUpLabel: UILabel!
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var dateOfBirthTF: UITextField!
    
    @IBOutlet weak var genderTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var deliveryAddress: UITextField!
    @IBOutlet weak var signUpDesign: UIButton!
    
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var countryImage: UIImageView!
    @IBOutlet weak var countryCode: UILabel!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var mainOTPView: UIView!
    
    @IBOutlet weak var otpView: UIView!
    @IBOutlet weak var otp_tf: SGCodeTextField!
    @IBOutlet weak var verifyDesign: UIButton!
    
    var genderPickerView = UIPickerView()
    var genderArray = ["Male", "Female"]
    var datePicker = UIDatePicker()
    var dateTimeStamp = ""
    var phoneNumberWithCode = ""
    var verification_id: String? = nil
    func updateUI(){
        mainOTPView.isHidden = true
//        otpView.dropShadow(radius: 16, shadow: 2)
        verifyDesign.setCornerRadius(radius: 8)
        signUpImage.image = Asset.signInBackGround.image
        signUpLabel.text = L10n.signUpLabel
        
        signUpView.dropShadow(radius: 8, shadow: 2)
        upperSignUpView.setCornerRadius(radius: 8)
        upperSignUpView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        signUpDesign.setCornerRadius(radius: 8)
        phoneView.setBCdesign(borderWidth: 1, borderColor: ColorName.welcomeBorder.color, radius: 8)
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        createDatePicker()
    }
    func createDatePicker(){
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([done], animated: false)
        dateOfBirthTF.inputAccessoryView = toolbar
        datePicker.maximumDate = Date()
        dateOfBirthTF.inputView = datePicker
        
    }
    @objc func donePressed(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let dateString = dateFormatter.string(from: datePicker.date)
        dateOfBirthTF.text = "\(dateString)"
        let date = dateFormatter.date(from: dateString)
        let dateStamp:TimeInterval = date!.timeIntervalSince1970
        let dateSt:Int = Int(dateStamp)
        dateTimeStamp = String(dateSt)
        self.endEditing(true)
    }
}
