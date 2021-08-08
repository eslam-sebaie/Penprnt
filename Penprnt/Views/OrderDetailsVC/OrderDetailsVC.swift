//
//  OrderDetailsVC.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 8/8/21.
//

import UIKit

class OrderDetailsVC: UIViewController, sendingAddress, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet var orderDetailsView: OrderDetailsView!
    var orderDetails = [OrderDetailsInfo]()
    var receiveID = 0
    var receiveOrderNumber = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.orderDetailsView.orderNumber.text = receiveOrderNumber
        // Do any additional setup after loading the view.
    }
    
    class func create() -> OrderDetailsVC {
        let orderDetailsVC: OrderDetailsVC = UIViewController.create(storyboardName: Storyboards.order, identifier: ViewControllers.orderDetailsVC)
        return orderDetailsVC
    }
    override func viewWillAppear(_ animated: Bool) {
        getUser()
        getDetails()
    }
    
    func getUser() {
        self.orderDetailsView.showLoader()
        APIManager.searchUser(emailNumber: UserDefaultsManager.shared().Email ?? "") { (response) in
            switch response {
            case .failure( _):
                self.orderDetailsView.hideLoader()
            case .success(let result):
                self.orderDetailsView.hideLoader()
                self.orderDetailsView.addressLabel.text = result.data[0].address ?? ""
            }
        }
    }
    
    func getDetails() {
        self.orderDetailsView.showLoader()
        APIManager.getOrderDetails(id: receiveID) { (response) in
            switch response {
            case .failure(let err):
                print(err)
                self.orderDetailsView.hideLoader()
            case .success(let result):
                self.orderDetailsView.hideLoader()
                self.orderDetails = result.data ?? []
                self.orderDetailsView.priceLabel.text = "KD \(result.data?[0].order?.totalPrice ?? "")"
                self.orderDetailsView.orderDetailsTableView.reloadData()
            }
        }
    }
    
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func changeAddressPressed(_ sender: Any) {
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
    func send(address: String) {
        self.orderDetailsView.addressLabel.text = address
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = orderDetailsView.orderDetailsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OrderDetailsTableViewCell
        
        cell.prodImage.sd_setImage(with: URL(string: orderDetails[indexPath.row].image ?? ""), completed: nil)
        cell.prodName.text = orderDetails[indexPath.row].name ?? ""
        cell.prodPrice.text = "KD \(orderDetails[indexPath.row].price ?? "")"
        cell.prodQuantity.text = "x\(orderDetails[indexPath.row].quantity ?? "")"
        cell.prodColor.backgroundColor =  UIColor(hexString: orderDetails[indexPath.row].color ?? "")
        cell.prodSize.text = orderDetails[indexPath.row].size ?? ""
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
}
