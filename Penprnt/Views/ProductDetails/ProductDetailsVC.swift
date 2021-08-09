//
//  ProductDetailsVC.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 6/30/21.
//

import UIKit

class ProductDetailsVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,UITextViewDelegate{
    
    
    @IBOutlet var productDetailsView: ProductDetailsView!
    var receiveInfo = productInfo(id: 0, image: "", name: "", datumDescription: "", itemNo: "", brandName: "", price: "", wholeSale: "", quantity: "", size: [], barCode: "", date: "", design: "", productColor: [], totalRate: "", totalCountUser: "", isActive: false, vendorID: "", categoryID: "", subcategoryId: "", createdAt: "", updatedAt: "")
    
    var receiveInfo1 = MostProductInfo(productID: "", id: 0, products: Products(id: 0, image: "", name: "", productsDescription: "", itemNo: "", brandName: "", price: "", wholeSale: "", quantity: "", size: [], barCode: "", date: "", design: "", productColor: [], totalRate: "", totalCountUser: "", isActive: false, vendorID: "", categoryID: "", subcategoryId: "", createdAt: "", updatedAt: ""))
    var cartInfo = [CartInfo]()
    var checkNew = false
    var productID = 0
    var totalRate = ""
    var totalRateCount = ""
    var colorChoosen = ""
    var sizeChoosen = ""
    var colorCheck = false
    var sizeCheck = false
    var productIDFavCheck = false
    
    
    var name = ""
    var price = ""
    var quantity = ""
    var size = ""
    var image = ""
    var receiveVendorID = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorCollectionViewSpacing()
        sizeCollectionViewSpacing()
        productDetailsView.updateUI()
        
        if checkNew {
            productDetailsView.setDetailsNew(info: receiveInfo)
            name = receiveInfo.name ?? ""
            price = receiveInfo.price ?? ""
            quantity = receiveInfo.quantity ?? ""
            size = (receiveInfo.size.first ?? "") ?? ""
            image = receiveInfo.image ?? ""
            
            if receiveInfo.productColor?.count == 0 {
                colorCheck = false
            }
            else {
                colorCheck = true
            }
            if receiveInfo.size.count == 0 {
                sizeCheck = false
            }
            else {
                sizeCheck = true
            }
        }
        else {
            productDetailsView.setDetailsMostSale(info: receiveInfo1)
            name = receiveInfo1.products.name ?? ""
            price = receiveInfo1.products.price ?? ""
            quantity = receiveInfo1.products.quantity ?? ""
            size = (receiveInfo1.products.size.first ?? "") ?? ""
            image = receiveInfo1.products.image ?? ""
            
            if receiveInfo1.products.productColor?.count == 0 {
                colorCheck = false
            }
            else {
                colorCheck = true
            }
            if receiveInfo1.products.size.count == 0 {
                sizeCheck = false
            }
            else {
                sizeCheck = true
            }
        }
        getFavorite()
        getCart()
        productDetailsView.noteTextView.delegate = self
        
    }
    func getFavorite() {
        if UserDefaultsManager.shared().Email == nil || UserDefaultsManager.shared().Email == "" {
            print("OK")
        }
        else {
            if checkNew {
                productID = receiveInfo.id
            }
            else {
                productID = receiveInfo1.products.id
            }
            self.productDetailsView.showLoader()
            APIManager.getFavorite(emailNumber: UserDefaultsManager.shared().Email ?? "") { (response) in
                switch response {
                case .failure(let err):
                    print(err)
                    self.productDetailsView.hideLoader()
                    self.show_Alert("Sorry!", "SomeThing Went Wrong.")
                case .success(let result):
                    for i in result.data ?? [] {
                        print("!@#$$")
                        print(self.productID)
                        print(Int(i.productID))
                        if self.productID == Int(i.productID) {
                            self.productDetailsView.favoriteDesign.setImage(#imageLiteral(resourceName: "love"), for: .normal)
                            self.productIDFavCheck = true
                        }
                    }
                    self.productDetailsView.hideLoader()
                }
            }
            
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        productDetailsView.setPlaceHolder()
    }
    
    func colorCollectionViewSpacing() {
        if let layout = productDetailsView.colorCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            
            let width = 40
            let height = 40
            layout.minimumLineSpacing = 16
            layout.minimumInteritemSpacing = 16
            layout.estimatedItemSize = .zero
            productDetailsView.itemSize = CGSize(width: width, height: height)
        }
    }
    func sizeCollectionViewSpacing() {
        if let layout = productDetailsView.sizeCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            
            let width = 40
            let height = 40
            layout.minimumLineSpacing = 16
            layout.minimumInteritemSpacing = 16
            layout.estimatedItemSize = .zero
            productDetailsView.itemSize1 = CGSize(width: width, height: height)
        }
    }
    
    class func create() -> ProductDetailsVC {
        let productDetailsVC: ProductDetailsVC = UIViewController.create(storyboardName: Storyboards.products, identifier: ViewControllers.productDetailsVC)
        return productDetailsVC
    }
    
    
    
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func reviewsPressed(_ sender: Any) {
        if checkNew {
            productID = receiveInfo.id
            totalRate = receiveInfo.totalRate ?? "0"
            let x = Double(totalRate) ?? 0.0
            let y = Double(round(10 * x)/10)
            totalRate = String(y)
            
            totalRateCount = receiveInfo.totalCountUser ?? "0"
        }
        else {
            productID = receiveInfo1.products.id
            totalRate = receiveInfo1.products.totalRate ?? "0"
            totalRateCount = receiveInfo1.products.totalCountUser ?? "0"
        }
        let rate = RateVC.create()
        rate.receiveProductID = productID
        rate.receiveTotalRate = totalRate
        rate.receiveTotalRateCount = totalRateCount
        self.present(rate, animated: true, completion: nil)
    }
    
    
    @IBAction func stepperChanges(_ sender: UIStepper) {
        productDetailsView.quantityLabel.text = "\(sender.value)"
    }
    func getCart(){
        self.productDetailsView.showLoader()
        APIManager.getCart(emailNumber: UserDefaultsManager.shared().Email ?? "") { (response) in
            switch response {
            case .failure(let err):
                print(err)
                self.productDetailsView.hideLoader()
            case .success(let result):
                self.productDetailsView.hideLoader()
                print(result)
                self.cartInfo = result.data ?? []
                
            }
        }
    }
    func deleteCarts(cartInfo: [CartInfo]) {
        self.productDetailsView.showLoader()
        UserDefaultsManager.shared().vendorID = 0
        for i in cartInfo {
            APIManager.deleteCart(id: i.id ?? 0) {
                self.productDetailsView.hideLoader()
            }
        }
        self.cartInfo = []
    }
    
    @IBAction func cartPressed(_ sender: Any) {
        if UserDefaultsManager.shared().Email == nil || UserDefaultsManager.shared().Email == "" {
            showAlert(title: "Sorry No Account.", massage: "Do You Want To Register?", present: self, titleBtn: "OK") {
                let signUp = SignUpVC.create()
                self.present(signUp, animated: true, completion: nil)
            }
        }
        else {
            if checkNew {
                productID = receiveInfo.id
            }
            else {
                productID = receiveInfo1.products.id
            }
            if colorCheck {
                if colorChoosen == "" {
                    self.show_Alert("Please!", "Choose Color.")
                }
                else {
                    if productDetailsView.quantityLabel.text == "0.0" {
                        self.show_Alert("Please!", "Enter Quantity.")
                    }
                    else {
                        if self.cartInfo.count == 0 {
                            self.productDetailsView.showLoader()
                            APIManager.setCart(emailNumber: UserDefaultsManager.shared().Email ?? "", product_id: productID, name: name, price: price, quantity: self.productDetailsView.quantityLabel.text ?? "", Color: colorChoosen, size: size, image: image, note: self.productDetailsView.noteTextView.text ?? "") {
                              
                                UserDefaultsManager.shared().vendorID = self.receiveVendorID
                                    self.productDetailsView.hideLoader()
                                    self.dismiss(animated: true, completion: nil)
                                
                            }
                        }
                        else if self.cartInfo.count != 0 && receiveVendorID == UserDefaultsManager.shared().vendorID {
                            self.productDetailsView.showLoader()
                            APIManager.setCart(emailNumber: UserDefaultsManager.shared().Email ?? "", product_id: productID, name: name, price: price, quantity: self.productDetailsView.quantityLabel.text ?? "", Color: colorChoosen, size: size, image: image, note: self.productDetailsView.noteTextView.text ?? "") {
                                UserDefaultsManager.shared().vendorID = self.receiveVendorID
                                    self.productDetailsView.hideLoader()
                                    self.dismiss(animated: true, completion: nil)
                            }
                        }
                        else if self.cartInfo.count != 0 && receiveVendorID != UserDefaultsManager.shared().vendorID {
                            showAlert(title: "Sorry.", massage: "Do You Want To Delete your Cart First?", present: self, titleBtn: "OK") {
                                self.deleteCarts(cartInfo: self.cartInfo)
                            }
                        }
                    }
                }
            }
            else {
                if productDetailsView.quantityLabel.text == "0.0" {
                    self.show_Alert("Please!", "Enter Quantity.")
                }
                else {
                    self.productDetailsView.showLoader()
                    APIManager.setCart(emailNumber: UserDefaultsManager.shared().Email ?? "", product_id: productID, name: name, price: price, quantity: self.productDetailsView.quantityLabel.text ?? "", Color: colorChoosen, size: size, image: image, note: self.productDetailsView.noteTextView.text ?? "") {
                      
                        
                            self.productDetailsView.hideLoader()
                            self.dismiss(animated: true, completion: nil)
                        
                    }
                }
            }
        }
        
    }
    
    @IBAction func favoritePressed(_ sender: Any) {
        
        if UserDefaultsManager.shared().Email == nil || UserDefaultsManager.shared().Email == "" {
            showAlert(title: "Sorry No Account.", massage: "Do You Want To Register?", present: self, titleBtn: "OK") {
                let signUp = SignUpVC.create()
                self.present(signUp, animated: true, completion: nil)
            }
        }
        else {
            if checkNew {
                productID = receiveInfo.id
            }
            else {
                productID = receiveInfo1.products.id
            }
            if productIDFavCheck {
                print("Will Delete IT")
            }
            else {
                self.productDetailsView.showLoader()
                APIManager.makeFavorite(emailNumber: UserDefaultsManager.shared().Email ?? "", id: productID) {
                    self.productDetailsView.hideLoader()
                    self.productDetailsView.favoriteDesign.setImage(#imageLiteral(resourceName: "love"), for: .normal)
                    
                }
            }
        }
    }
    
    
    
    @objc func popupHide() {
        self.productDetailsView.saveView.isHidden = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if checkNew {
            if collectionView == productDetailsView.colorCollectionView {
                return receiveInfo.productColor?.count ?? 0
            }
            else {
                return receiveInfo.size.count
            }
        }
        else {
            if collectionView == productDetailsView.colorCollectionView {
                return receiveInfo1.products.productColor?.count ?? 0
            }
            else {
                return receiveInfo1.products.size.count
            }
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if checkNew {
            if collectionView == productDetailsView.colorCollectionView {
                let cell = productDetailsView.colorCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ColorCollectionViewCell
                cell.contentView.backgroundColor = UIColor(hexString: receiveInfo.productColor?[indexPath.row] ?? "")
                cell.contentView.setCornerRadius(radius: 8)
                return cell
            }
            else {
                let cell = productDetailsView.sizeCollectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! SizeCollectionViewCell
                cell.sizeLabel.text = receiveInfo.size[indexPath.row]
                cell.contentView.dropShadow(radius: 6, shadow: 2)
                cell.contentView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                cell.contentView.layer.borderWidth = 1
                return cell
            }
        }
        else {
            if collectionView == productDetailsView.colorCollectionView {
                let cell = productDetailsView.colorCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ColorCollectionViewCell
                cell.contentView.backgroundColor = UIColor(hexString: receiveInfo1.products.productColor?[indexPath.row] ?? "")
                cell.contentView.setCornerRadius(radius: 8)
                return cell
            }
            else {
                let cell = productDetailsView.sizeCollectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! SizeCollectionViewCell
                cell.sizeLabel.text = receiveInfo1.products.size[indexPath.row]
                cell.contentView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                cell.contentView.layer.borderWidth = 1
                cell.contentView.dropShadow(radius: 6, shadow: 2)
                return cell
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if checkNew {
            if collectionView == productDetailsView.colorCollectionView {
                colorChoosen =  receiveInfo.productColor?[indexPath.row] ?? ""
                productDetailsView.saveView.isHidden = false
                self.perform(#selector(self.popupHide), with: self, afterDelay: 1)
            }
        }
        else {
            if collectionView == productDetailsView.colorCollectionView {
                colorChoosen =  receiveInfo1.products.productColor?[indexPath.row] ?? ""
                productDetailsView.saveView.isHidden = false
                self.perform(#selector(self.popupHide), with: self, afterDelay: 1)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = 40
        let yourHeight = 40
        
        return CGSize(width: yourWidth, height: yourHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
}
