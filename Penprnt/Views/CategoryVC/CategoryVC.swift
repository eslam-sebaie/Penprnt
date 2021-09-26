//
//  CategoryVC.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 4/29/21.
//

import UIKit
import SDWebImage
import Alamofire
import SwiftyJSON
import Kingfisher
import ImageSlideshow
class CategoryVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, sendingAddress {
    func send(address: String) {
        print(address)
    }
    

    @IBOutlet var categoryView: CategoryView!
    var nameArray = [String]()
    var catImage = [String]()
    var detailsArray = [String]()
    var newArr = [[String:Any]]()
    var imageSource: [KingfisherSource] = []
    var imageArray = [String]()
    var idArray = [Int]()
    var selectedIndexPath:IndexPath!
    var receiveVendorID = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryView.determineCollectionViewSpacing()
        self.categoryView.sideView.isHidden = true
        categoryView.updateUI()
        getCats()
        AF.request("https://phistory.life/location/api/banner", method: .get).response { response in
            switch response.result{
            case .success(let value):
                let json = JSON(value!)
                if let arr = json["data"].arrayObject{
                    self.newArr = arr as? [[String:Any]] ?? []
                    for i in self.newArr {
                        for (key, value) in i {
                            if key == "banner" {
                                self.imageArray.append(value as! String)
                            }
                        }
                    }
                    self.showImages()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    func showImages() {
        for image in self.imageArray {
            imageSource.append(KingfisherSource(url: URL(string: image)!))
        }
        self.categoryView.bannerView.setImageInputs(imageSource)
    }
    
    
    func getCats() {
        self.categoryView.showLoader()
        APIManager.getCategories(vendorId: receiveVendorID) { (response) in
            switch response {
            case .failure(let err):
                print(err)
                self.show_Alert("Sorry", "SomeThing Went Wrong")
            case .success(let result):
                if result.message == "faild" {
                    self.show_Alert("Sorry", "No Category Found.")
                }
                else {
                    for i in result.data ?? [] {
                        self.idArray.append(i.id ?? 0)
                        self.nameArray.append(i.name ?? "")
                        self.catImage.append(i.image ?? "")
                        self.detailsArray.append(i.details ?? "")
                    }
                    self.categoryView.hideLoader()
                    self.categoryView.catCollectionView.reloadData()
                }
                self.categoryView.hideLoader()
              
            }
        }
    }
    
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
        categoryView.menu()
    }
    
    @IBAction func categoryPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: Storyboards.home, bundle: nil)
        let catVC = storyboard.instantiateViewController(withIdentifier: "tabViewController") as! tabViewController
        catVC.selectedIndex = 3
        self.present(catVC, animated: true, completion: nil)
        
        
    }
    
    
    @IBAction func hideMenuPressed(_ sender: Any) {
        UIView.animate(withDuration: 0.6, animations: {
            self.categoryView.sideView.alpha = 0.0
        }) {_ in
            self.categoryView.sideView.isHidden = true
        }
        self.categoryView.checkView = false
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoryView.catCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CatCollectionViewCell
        cell.catName.text = nameArray[indexPath.row]
        cell.catDescription.text = detailsArray[indexPath.row]
        cell.catImage.sd_setImage(with: URL(string: catImage[indexPath.row]), completed: nil)

        cell.catImage.layer.cornerRadius = 8
        cell.catImage.layer.masksToBounds = true
        cell.contentView.layer.cornerRadius = 8
        cell.contentView.layer.masksToBounds = true
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let subcat = SubCategoryVC.create()
        subcat.receiveVendorID = receiveVendorID
        subcat.receiveCatID = "\(idArray[indexPath.row])"
        self.present(subcat, animated: true, completion: nil)
        
        
//        categoryView.nameChoosen = nameArray[indexPath.row]
//        let products = ProductsVC.create()
//        products.receiveCatName = categoryView.nameChoosen
//        products.receiveID = idArray[indexPath.row]
//        self.present(products, animated: true, completion: nil)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = 0.4 * self.view.frame.size.width
        let yourHeight = CGFloat(223)

        return CGSize(width: yourWidth, height: yourHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    @IBAction func homePressed(_ sender: Any) {
        UIView.animate(withDuration: 0.6, animations: {
            self.categoryView.sideView.alpha = 0.0
        }) {_ in
            self.categoryView.sideView.isHidden = true
        }
        self.categoryView.checkView = false
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


//       let mytapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
//            self.view.addGestureRecognizer(mytapGestureRecognizer)
//            self.view.isUserInteractionEnabled = true

//    @objc func handleTap(_ sender:UITapGestureRecognizer){
//
//           if !self.categoryView.sideView.isHidden {
//             self.categoryView.sideView.isHidden = true
//           }
//    }
