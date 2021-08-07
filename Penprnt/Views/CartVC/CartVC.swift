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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        getCart()
    }
    
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func getCart() {
        if UserDefaultsManager.shared().Email == nil || UserDefaultsManager.shared().Email == "" {
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
                    self.cartView.cartTableView.reloadData()
                }
            }
        }
        
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }

}
