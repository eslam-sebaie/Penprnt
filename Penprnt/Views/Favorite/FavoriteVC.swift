//
//  FavoriteVC.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 8/7/21.
//

import UIKit

class FavoriteVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var favoriteView: FavoriteView!
    var favInfo = [FavoriteInfo]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        getFavorite()
    }
    func getFavorite() {
        if UserDefaultsManager.shared().Email == nil || UserDefaultsManager.shared().Email == "" {
            showAlert(title: "Sorry No Account.", massage: "Do You Want To Register?", present: self, titleBtn: "OK") {
                let signUp = SignUpVC.create()
                self.present(signUp, animated: true, completion: nil)
            }
        }
        else {
            APIManager.getFavorite(emailNumber: UserDefaultsManager.shared().Email ?? "") { (response) in
                switch response {
                case .failure(let err):
                    print(err)
                    self.show_Alert("Sorry!", "SomeThing Went Wrong.")
                case .success(let result):
                    if result.message == "faild"{
                        self.show_Alert("Sorry", "No Items in Favorite.")
                    }
                    else {
                        self.favInfo = result.data ?? []
                        self.favoriteView.favoriteTableView.reloadData()
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.favoriteView.favoriteTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavoriteTableViewCell
        
        cell.prodImage.sd_setImage(with: URL(string: favInfo[indexPath.row].product.image ?? ""), completed: nil)
        cell.prodImage.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cell.prodImage.layer.cornerRadius = 16
        cell.prodImage.layer.masksToBounds = true
        cell.mainView.setCornerRadius(radius: 16)
        cell.mainView.dropShadow(radius: 16, shadow: 2)
        cell.prodName.text = favInfo[indexPath.row].product.name ?? ""
        cell.prodPrice.text = "\(favInfo[indexPath.row].product.price ?? "") KD"
        cell.rateCount.text = "(\(favInfo[indexPath.row].product.totalCountUser ?? ""))"
        cell.rateView.rating = Double(favInfo[indexPath.row].product.totalRate ?? "0.0") ?? 0.0
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let proDetails = ProductDetailsVC.create()
        proDetails.receiveInfo = favInfo[indexPath.row].product
        proDetails.checkNew = true
        self.present(proDetails, animated: true, completion: nil)
    }
   

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.favoriteView.showLoader()
            let pID = favInfo[indexPath.row].id
            APIManager.deleteFavorite(id: pID) {
                self.favoriteView.hideLoader()
                self.favInfo.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let rotateTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 10, 0)
        cell.layer.transform = rotateTransform
        UIView.animate(withDuration: 1.0) {
            cell.layer.transform = CATransform3DIdentity
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 205
    }
}
