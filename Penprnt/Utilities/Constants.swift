//
//  Constants.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 4/29/21.
//

import Foundation
// Storyboards
struct Storyboards {
    static let main = "Main"
    static let home = "Home"
    static let profile = "Profile"
    static let products = "Products"
    static let order = "Order"
}

// View Controllers
struct ViewControllers {
    static let welcomeVC = "WelcomeVC"
    static let signInVC =  "SignInVC"
    static let signUpVC =  "SignUpVC"
    static let loginPhoneVC = "LoginPhoneVC"
    static let phoneVerifyVC = "PhoneVerifyVC"
    static let productsVC = "ProductsVC"
    static let profileVC = "ProfileVC"
    static let editProfileVC = "EditProfileVC"
    static let searchVC = "SearchVC"
    static let storeVC = "StoreVC"
    static let rateVC = "RateVC"
    static let filterVC = "FilterVC"
    static let productDetailsVC = "ProductDetailsVC"
    static let subCategoryVC = "SubCategoryVC"
}
struct URLs {
    // MARK:- base
    static let base = "http://penprnt.com/penprnt/api/"
    static let userSignUp = "signup"
    static let login = "Login"
    static let createCategory = "createCategory"
    static let updateAddress = "editAddress"
    static let searchProduct = "searchProduct"
    static let updateImage = "updateImage"
    static let editProfile = "editProfile"
    static let productsNew = "productsNew"
    static let productSale = "productSale"
    static let searchUser = "searchUser"
    static let filterAlph = "filterAlph"
    static let filterByPriceColor = "filterByPriceColor"
    static let alltStoreWithCount = "alltStoreWithCount"
    static let subCategory = "SubCategory"
    static let rate = "rate"
}
struct ParameterKeys {
    static let name = "name"
    static let email = "emailNumber"
    static let phone = "phone"
    static let address = "address"
    static let dateOfBirth = "birthDate"
    static let gender = "gender"
    static let password = "password"
    
}
struct UserDefaultsKeys {
    static let token = "token"
    static let email = "email"
    static let phone = "phone"
    static let password = "password"
}
struct TableCells {
   
}

