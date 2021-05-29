//
//  UserDefaultManager.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 4/29/21.
//

import Foundation
import Foundation
class UserDefaultsManager {
    
    // MARK:- Singleton
    private static let sharedInstance = UserDefaultsManager()
    
    class func shared() -> UserDefaultsManager {
        return UserDefaultsManager.sharedInstance
    }
    
    // MARK:- Properties

    
    var Token: String? {
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.token)
        }
        get {
            guard UserDefaults.standard.object(forKey: UserDefaultsKeys.token) != nil else {
                return nil
            }
            return UserDefaults.standard.string(forKey: UserDefaultsKeys.token)
        }
    }
    var Email: String? {
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.email)
        }
        get {
            guard UserDefaults.standard.object(forKey: UserDefaultsKeys.email) != nil else {
                return nil
            }
            return UserDefaults.standard.string(forKey: UserDefaultsKeys.email)
        }
    }
    var Password: String? {
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.password)
        }
        get {
            guard UserDefaults.standard.object(forKey: UserDefaultsKeys.password) != nil else {
                return nil
            }
            return UserDefaults.standard.string(forKey: UserDefaultsKeys.password)
        }
    }
    var phone: String? {
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.phone)
        }
        get {
            guard UserDefaults.standard.object(forKey: UserDefaultsKeys.phone) != nil else {
                return nil
            }
            return UserDefaults.standard.string(forKey: UserDefaultsKeys.phone)
        }
    }
    
}
