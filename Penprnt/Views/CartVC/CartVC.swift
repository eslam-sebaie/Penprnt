//
//  CartVC.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 8/7/21.
//

import UIKit

class CartVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet var cartView: CartView!
    var cartInfo = [CartInfo]()
    var dateTimeStamp = ""
    var totalPriceArray = [String]()
    var productIDArray = [Int]()
    var quantityArray = [String]()
    var colorArray = [String]()
    var sizeArray = [String]()
    var nameArray = [String]()
    var imageArray = [String]()
    var totalPrice = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        cartView.confirmDesign.setCornerRadius(radius: 10)
        let currentDateTime = Date()
        let dateStamp:TimeInterval = currentDateTime.timeIntervalSince1970
        let dateSt:Int = Int(dateStamp)
        dateTimeStamp = String(dateSt)
    }
    override func viewWillAppear(_ animated: Bool) {
        getCart()
    }
    
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func getCart() {
        if UserDefaultsManager.shared().Email == nil || UserDefaultsManager.shared().Email == "" {
            self.cartView.confirmDesign.isHidden = true
            showAlert(title: "Sorry No Account.", massage: "Do You Want To Register?", present: self, titleBtn: "OK") {
                let signUp = SignUpVC.create()
                self.present(signUp, animated: true, completion: nil)
            }
        }
        else {
            self.cartView.showLoader()
            APIManager.getCart(emailNumber: UserDefaultsManager.shared().Email ?? "") { (response) in
                switch response {
                case .failure(let err):
                    print(err)
                    self.cartView.hideLoader()
                case .success(let result):
                    self.cartView.hideLoader()
                    print(result)
                    self.cartInfo = result.data ?? []
                    self.readData(cartInfo: self.cartInfo)
                    self.cartView.cartTableView.reloadData()
                }
            }
        }
    }
    
    func readData(cartInfo: [CartInfo]) {
        for i in cartInfo {
            totalPriceArray.append(i.price ?? "")
            let pid = Int(i.product_id ?? "0") ?? 0
            productIDArray.append(pid)
            quantityArray.append(i.quantity ?? "")
            colorArray.append(i.Color ?? "")
            sizeArray.append(i.size ?? "")
            nameArray.append(i.name ?? "")
            imageArray.append(i.image ?? "")
            let price = Int(i.price ?? "0") ?? 0
            totalPrice += price
        }
    }
    
    @IBAction func confirmOrderPressed(_ sender: Any) {
       
        self.cartView.showLoader()
        APIManager.setOrder(emailNumber: UserDefaultsManager.shared().Email ?? "", orderDate: dateTimeStamp, totalPrice: String(totalPrice), productId: productIDArray, price: totalPriceArray, quantity: quantityArray, Color: colorArray, size: sizeArray, name: nameArray, image: imageArray) {
            self.deleteCarts(cartInfo: self.cartInfo)
            self.cartView.hideLoader()
        }
    }
    
    func deleteCarts(cartInfo: [CartInfo]) {
        self.cartView.showLoader()
        for i in cartInfo {
            APIManager.deleteCart(id: i.id ?? 0) {
                self.cartView.hideLoader()
            }
        }
        let storyboard = UIStoryboard(name: Storyboards.order, bundle: nil)
        let catVC = storyboard.instantiateViewController(withIdentifier: "ThankOrderVC") as! ThankOrderVC
        self.present(catVC, animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.cartView.cartTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CartTableViewCell
        
        cell.orderImage.sd_setImage(with: URL(string: cartInfo[indexPath.row].image ?? ""), completed: nil)
        cell.orderName.text = cartInfo[indexPath.row].name ?? ""
        cell.orderPrice.text = "KD \(cartInfo[indexPath.row].price ?? "")"
        cell.orderQuantity.text = "x\(cartInfo[indexPath.row].quantity ?? "")"
        cell.orderolor.backgroundColor =  UIColor(hexString: cartInfo[indexPath.row].Color ?? "")
        cell.orderSize.text = cartInfo[indexPath.row].size ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.cartView.showLoader()
            let pID = cartInfo[indexPath.row].id ?? 0
            APIManager.deleteCart(id: pID) {
                self.cartView.hideLoader()
                self.cartInfo.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }

}
