//
//  StoreVC.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 8/6/21.
//

import UIKit

class StoreVC: UIViewController, sendingAddress {
    func send(address: String) {
        print(address)
    }

    @IBOutlet var storeView: StoreView!
    
    
    
    var allStors = [StoreInfo]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.storeView.sideView.isHidden = true
    }
    override func viewDidAppear(_ animated: Bool) {
        getAllStors()
    }
    func getAllStors(){
        self.storeView.showLoader()
        APIManager.getAllStors { (response) in
            switch response {
            case .failure(let err):
                print(err)
            case .success(let result):
                print(result)
                self.storeView.hideLoader()
                self.allStors = result.data ?? []
                self.storeView.storeTableView.reloadData()
            }
        }
    }
    
    class func create() -> StoreVC {
        let searchVC: StoreVC = UIViewController.create(storyboardName: Storyboards.home, identifier: ViewControllers.storeVC)
        return searchVC
    }
    @IBAction func profilePressed(_ sender: Any) {
        if UserDefaultsManager.shared().Email == nil || UserDefaultsManager.shared().Email == "" {
            showAlert(title: "Sorry No Account.", massage: "Do You Want To Register?", present: self, titleBtn: "OK") {
                let signUp = SignUpVC.create()
                self.present(signUp, animated: true, completion: nil)
            }
        }
        else {
            let profile = ProfileVC.create()
            self.present(profile, animated: true, completion: nil)
        }
    }
    
    @IBAction func menuPressed(_ sender: Any) {
        storeView.menu()
    }
    
    @IBAction func hideMenuPressed(_ sender: Any) {
        UIView.animate(withDuration: 0.6, animations: {
            self.storeView.sideView.alpha = 0.0
        }) {_ in
            self.storeView.sideView.isHidden = true
        }
        self.storeView.checkView = false
    }
    
    @IBAction func homePressed(_ sender: Any) {
        UIView.animate(withDuration: 0.6, animations: {
            self.storeView.sideView.alpha = 0.0
        }) {_ in
            self.storeView.sideView.isHidden = true
        }
        self.storeView.checkView = false
    }
    
    
    @IBAction func orderHistoryPressed(_ sender: Any) {
        
    }
    
    @IBAction func cardsPressed(_ sender: Any) {
        
    }
    
    @IBAction func changeLocationPressed(_ sender: Any) {
       
        if UserDefaultsManager.shared().Email == nil || UserDefaultsManager.shared().Email == "" {
            showAlert(title: "Sorry No Account.", massage: "Do You Want To Register?", present: self, titleBtn: "OK") {
                let signUp = SignUpVC.create()
                self.present(signUp, animated: true, completion: nil)
            }
        }
        else {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let mapVC = sb.instantiateViewController(withIdentifier: "MapVC") as! MapVC
            mapVC.delegate = (self as sendingAddress)
            mapVC.checkCat = true
            self.present(mapVC ,animated: true, completion: nil)
        }
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
extension StoreVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allStors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.storeView.storeTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! StoreTableViewCell
        cell.storeMainView.setCornerRadius(radius: 16)
        cell.storeNameView.setCornerRadius(radius: 12)
        cell.storeImage.sd_setImage(with: URL(string: allStors[indexPath.row].storeFile ?? ""), completed: nil)
        cell.storeName.text = allStors[indexPath.row].storeName
        cell.storeProductCount.text = "\(allStors[indexPath.row].totalProducts?[0].total ?? "0") Products"
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vendorID = allStors[indexPath.row].totalProducts?[0].vendorID
        let storyboard = UIStoryboard(name: Storyboards.home, bundle: nil)
        let catVC = storyboard.instantiateViewController(withIdentifier: "CategoryVC") as! CategoryVC
        catVC.receiveVendorID = vendorID ?? ""
        self.present(catVC, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 254
    }
    
}
