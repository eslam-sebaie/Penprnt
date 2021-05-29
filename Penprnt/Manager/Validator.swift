//
//  Validator.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 4/29/21.
//

import Foundation

class Validation: NSObject {
    enum Alert {        //for failure and success results
        case success
        case failure
        case error
    }
    
    enum Valid {
        case success
        case failure(Alert, AlertMessages)
    
    }
    enum ValidationType {
        
        case email
        case stringWithFirstLetterCaps
        case phoneNo
        case age
        case alphabeticString
        case password
    }
    enum RegEx: String {
        case email = "[A-Z0-9a-z.]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}" // Email
        case password = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}$" // Password length 6-15
        case alphabeticStringWithSpace = "(?<! )[-a-zA-Z' ]{2,200}" // e.g. hello sandeep
        case alphabeticStringFirstLetterCaps = "^[A-Z]+[a-zA-Z]*$" // SandsHell
        case phoneNo = "[0-9]{10,14}" // PhoneNo 10-14 Digits        //Change RegEx according to
        case age = "[0-9]{1,3}"
        
//        "^[a-zA-Z ]*$"
    }
    enum AlertMessages: String {
         case inValidEmail = "Ex:- user@example.com"
         case invalidFirstLetterCaps = "First Letter should be capital"
         case inValidPhone = "phone Must Be More Than 9 Numbers"
         case inValidAge = "Invalid Age"
         case invalidAlphabeticString = "Can‘t Contain Numbers."
         case inValidPSW = "Must Contain 1 Capital, 1 Small Letter, number, 8 Characters"
            
         case emptyPhone = "Phone Can‘t be Empty."
         case emptyAge = "Age Can‘t be Empty."
         case emptyEmail = "Email Can‘t be Empty."
         case emptyFirstLetterCaps = "Name Can‘t be Empty."
         case emptyAlphabeticString = "Empty Is not Valid"
         case emptyPSW = "Password Can‘t be Empty."
        
         func localized() -> String {
            return NSLocalizedString(self.rawValue, comment: "")
         }
    }
    public static let shared = Validation()
        
        func validate(values: (type: ValidationType, inputValue: String)...) -> Valid {
            for valueToBeChecked in values {
                switch valueToBeChecked.type {
                case .email:
                    if let tempValue = isValidString((valueToBeChecked.inputValue, .email, .emptyEmail, .inValidEmail)) {
                        return tempValue
                    }
                case .stringWithFirstLetterCaps:
                    if let tempValue = isValidString((valueToBeChecked.inputValue, .alphabeticStringFirstLetterCaps, .emptyFirstLetterCaps, .invalidFirstLetterCaps)) {
                        return tempValue
                    }
                case .phoneNo:
                    if let tempValue = isValidString((valueToBeChecked.inputValue, .phoneNo, .emptyPhone, .inValidPhone)) {
                        return tempValue
                    }
                case .age:
                    if let tempValue = isValidString((valueToBeChecked.inputValue, .age, .emptyAge, .inValidAge)) {
                        return tempValue
                    }
                case .alphabeticString:
                    if let tempValue = isValidString((valueToBeChecked.inputValue, .alphabeticStringWithSpace, .emptyAlphabeticString, .invalidAlphabeticString)) {
                        return tempValue
                    }
                case .password:
                    if let tempValue = isValidString((valueToBeChecked.inputValue, .password, .emptyPSW, .inValidPSW)) {
                        return tempValue
                    }
                }
            }
            return .success
        }
        
        func isValidString(_ input: (text: String, regex: RegEx, emptyAlert: AlertMessages, invalidAlert: AlertMessages)) -> Valid? {
            if input.text.isEmpty {
                return .failure(.error, input.emptyAlert)
            } else if isValidRegEx(input.text, input.regex) != true {
                return .failure(.error, input.invalidAlert)
            }
            return nil
        }
        
        func isValidRegEx(_ testStr: String, _ regex: RegEx) -> Bool {
            let stringTest = NSPredicate(format:"SELF MATCHES %@", regex.rawValue)
            let result = stringTest.evaluate(with: testStr)
            return result
        }
}
