//
//  SearchVC.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 5/24/21.
//

import UIKit
import SDWebImage
class SearchVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var searchView: SearchView!
    var nameArray = [String]()
    var imageArray = [String]()
    var priceArray = [String]()
    var sec = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchView.updateUI()
        
        
    }
    class func create() -> SearchVC {
        let searchVC: SearchVC = UIViewController.create(storyboardName: Storyboards.profile, identifier: ViewControllers.searchVC)
        return searchVC
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchView.productTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchTableViewCell
        cell.productName.text = nameArray[indexPath.row]
        cell.productImage.sd_setImage(with: URL(string: imageArray[indexPath.row]), completed: nil)
        cell.productImage.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cell.productImage.layer.cornerRadius = 16
        cell.productImage.layer.masksToBounds = true
        cell.mainView.setCornerRadius(radius: 16)
//        cell.mainView.dropShadow(radius: 16, shadow: 2)
        return cell
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
    
    
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func searchPressed(_ sender: Any) {
        guard let name = self.searchView.searchTF.text , name != "" else {
            self.show_Alert("Please!", "Enter Search Name")
            return
        }
        self.searchView.searchLabel.text = "Search Results for \(name)"
        APIManager.searchName(name: name) { (response) in
            switch response{
            case .failure(let err):
                print(err)
            case .success(let result):
                if result.message != "faild"{
                    for i in result.data! {
                        self.nameArray.append(i.name ?? "")
                        self.imageArray.append(i.image ?? "")
                        self.priceArray.append(i.price ?? "")
                        
                    }
                    
                    self.searchView.productTableView.reloadData()
                }
                else {
                    self.show_Alert("Sorry", "No Result For Your Search.")
                }
            }
        }
    }
}
