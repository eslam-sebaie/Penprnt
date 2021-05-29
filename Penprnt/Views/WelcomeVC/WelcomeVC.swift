//
//  WelcomeVC.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 4/29/21.
//

import UIKit

class WelcomeVC: UIViewController {

    @IBOutlet var welcomeView: WelcomeView!
    override func viewDidLoad() {
        super.viewDidLoad()
        welcomeView.updateUI()
    }
    
    class func create() -> WelcomeVC {
        
        let welcomeVC: WelcomeVC = UIViewController.create(storyboardName: Storyboards.main, identifier: ViewControllers.welcomeVC)
        return welcomeVC
        
    }
    
    @IBAction func phonePressed(_ sender: Any) {
        let phoneVC = LoginPhoneVC.create()
        self.present(phoneVC, animated: true, completion: nil)
    }
    
    @IBAction func skipPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: Storyboards.home, bundle: nil)
        let catVC = storyboard.instantiateViewController(withIdentifier: "CategoryVC") as! CategoryVC
        self.present(catVC, animated: true, completion: nil)
    }
    
    @IBAction func signInPressed(_ sender: Any) {
//        let storyboard = UIStoryboard(name: Storyboards.home, bundle: nil)
//        let graveViewController = storyboard.instantiateViewController(withIdentifier: "tabViewController") as! tabViewController
//        self.present(graveViewController, animated: true, completion: nil)
        
        
        let signIn = SignInVC.create()
        self.present(signIn, animated: true, completion: nil)
    }
    
}
