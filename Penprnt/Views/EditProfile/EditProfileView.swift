//
//  EditProfileView.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 5/24/21.
//

import UIKit

class EditProfileView: UIView {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var birthTF: UITextField!
    @IBOutlet weak var saveDesign: UIButton!
    var datePicker = UIDatePicker()
    var dateTimeStamp = ""
    func updateUI(){
        saveDesign.setCornerRadius(radius: 8)
//        datePicker.datePickerMode = .date
//        if #available(iOS 13.4, *) {
//            datePicker.preferredDatePickerStyle = .wheels
//        } else {
//            // Fallback on earlier versions
//        }
//        createDatePicker()
    }
//    func createDatePicker(){
//
//        let toolbar = UIToolbar()
//        toolbar.sizeToFit()
//        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
//        toolbar.setItems([done], animated: false)
//        birthTF.inputAccessoryView = toolbar
//        datePicker.maximumDate = Date()
//        birthTF.inputView = datePicker
//
//    }
//    @objc func donePressed(){
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MM/dd/yyyy"
//        let dateString = dateFormatter.string(from: datePicker.date)
//        birthTF.text = "\(dateString)"
//        let date = dateFormatter.date(from: dateString)
//        let dateStamp:TimeInterval = date!.timeIntervalSince1970
//        let dateSt:Int = Int(dateStamp)
//        dateTimeStamp = String(dateSt)
//        self.endEditing(true)
//    }
}
