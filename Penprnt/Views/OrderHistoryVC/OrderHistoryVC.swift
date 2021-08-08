//
//  OrderHistoryVC.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 8/8/21.
//

import UIKit

class OrderHistoryVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    @IBOutlet var orderHistoryView: OrderHistoryView!
    var orderInfo = [OrderInfo]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        getOrder()
    }
    
    func getOrder(){
        if UserDefaultsManager.shared().Email == nil || UserDefaultsManager.shared().Email == "" {
            showAlert(title: "Sorry No Account.", massage: "Do You Want To Register?", present: self, titleBtn: "OK") {
                let signUp = SignUpVC.create()
                self.present(signUp, animated: true, completion: nil)
            }
        }
        else {
            self.orderHistoryView.showLoader()
            APIManager.getOrder(emailNumber: UserDefaultsManager.shared().Email ?? "") { (response) in
                switch response {
                case .failure(let err):
                    print(err)
                    self.orderHistoryView.hideLoader()
                case .success(let result):
                    self.orderInfo = result.data ?? []
                    self.orderHistoryView.hideLoader()
                    self.orderHistoryView.orderTableView.reloadData()
                }
            }
        }
    }
    
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    class func create() -> OrderHistoryVC {
        let orderHistoryVC: OrderHistoryVC = UIViewController.create(storyboardName: Storyboards.order, identifier: ViewControllers.orderHistoryVC)
        return orderHistoryVC
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.orderHistoryView.orderTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OrderHistoryTableViewCell
        
        cell.orderView.dropShadow(radius: 10, shadow: 2)
        cell.orderNumber.text = "Order \(orderInfo[indexPath.row].orderNumber ?? "")"
        let date = Int(orderInfo[indexPath.row].orderDate ?? "") ?? 0
        cell.orderDate.text = convertTimeStamp(date: date)
        cell.orderPrice.text = "KD \(orderInfo[indexPath.row].totalPrice ?? "")"
        if orderInfo[indexPath.row].orderStatus == "0" {
            cell.orderStatus.text = L10n.newOrder
            cell.orderStatus.textColor = ColorName.skyColor.color
            
        }
        else if orderInfo[indexPath.row].orderStatus == "1" {
            cell.orderStatus.text = L10n.inProgress
            cell.orderStatus.textColor = ColorName.progressColor.color
        }
        else if orderInfo[indexPath.row].orderStatus == "2" {
            cell.orderStatus.text = L10n.completed
            cell.orderStatus.textColor = ColorName.completeColor.color
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let details = OrderDetailsVC.create()
        details.receiveID = orderInfo[indexPath.row].id ?? 0
        details.receiveOrderNumber = orderInfo[indexPath.row].orderNumber ?? ""
        self.present(details, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    
}
