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
    
    var receiveID = 0
    var receiveColor = ""
    var receivePrice = ""
    var checkFilter = false
    var colorArray = [String]()
    var receiveSubCat = 0
    var filterData = [productInfo]()
    var searchData = [productInfo]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchView.updateUI()
        if checkFilter {
            searchView.searchImage.isHidden = true
            searchView.searchDesign.isHidden = true
            searchView.searchDesignHeaight.constant = 0
            searchView.searchHeight.constant = 0
            searchView.labelHeight.constant = 0
            colorArray.append(receiveColor)
            getFilterProduct()
        }
    }
    func getFilterProduct() {
        self.searchView.showLoader()
        APIManager.filterColorPrice(idSub: receiveSubCat, color: receiveColor, price: receivePrice) { (response) in
            switch response {
            case .failure(let err):
                print(err)
            case .success(let result):
                self.filterData = result.data
                for i in result.data ?? [] {
                    self.imageArray.append(i.image ?? "")
                    self.nameArray.append(i.name ?? "")
                    self.priceArray.append(i.price ?? "")
                }
                self.searchView.hideLoader()
                self.searchView.productTableView.reloadData()
            }
        }
    }
    
    class func create() -> SearchVC {
        let searchVC: SearchVC = UIViewController.create(storyboardName: Storyboards.home, identifier: ViewControllers.searchVC)
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
        cell.mainView.dropShadow(radius: 16, shadow: 2)
        if checkFilter {
            cell.productRate.rating = Double(filterData[indexPath.row].totalRate ?? "") ?? 0.0
            cell.rateCount.text = "(\(filterData[indexPath.row].totalCountUser ?? "0"))"
            cell.productPrice.text = "\(filterData[indexPath.row].price ?? "") KD"
        }
        else {
            cell.productRate.rating = Double(searchData[indexPath.row].totalRate ?? "") ?? 0.0
            cell.rateCount.text = "(\(searchData[indexPath.row].totalCountUser ?? "0"))"
            cell.productPrice.text = "\(searchData[indexPath.row].price ?? "") KD"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if checkFilter {
            let proDetails = ProductDetailsVC.create()
            proDetails.receiveInfo = filterData[indexPath.row]
            proDetails.checkNew = true
            self.present(proDetails, animated: true, completion: nil)
        }
        else {
            let proDetails = ProductDetailsVC.create()
            proDetails.receiveInfo = searchData[indexPath.row]
            proDetails.checkNew = true
            self.present(proDetails, animated: true, completion: nil)
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
    
    
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func searchPressed(_ sender: Any) {
        guard let name = self.searchView.searchTF.text , name != "" else {
            self.show_Alert("Please!", "Enter Search Name")
            return
        }
        self.searchView.showLoader()
        self.searchView.searchLabel.text = "Search Results for \(name)"
        APIManager.searchName(name: name, idSub: receiveSubCat) { (response) in
            switch response{
            case .failure(let err):
                print(err)
            case .success(let result):
                self.searchData = result.data ?? []
                self.searchView.hideLoader()
                if result.message != "faild"{
                    for i in result.data {
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
