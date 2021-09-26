//
//  ProductsVC.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 5/2/21.
//

import UIKit

class ProductsVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet var productsView: ProductsView!
    var receiveCatName = ""
    var receiveID = 0
    var nameArray = [String]()
    var imageArray = [String]()
    var priceArray = [String]()
    
    var nameArray1 = [String]()
    var imageArray1 = [String]()
    var priceArray1 = [String]()
    
    var colorArray = [String]()
    var colorArray1 = [String]()
    
    var countArray = [String]()
    var countArray1 = [String]()
    var rateArray = [String]()
    var rateArray1 = [String]()
    var productInformation = [productInfo]()
    var productInformation1 = [MostProductInfo]()
    
    var receiveVendorID = 0
    var receiveCatID = 0
    var receiveSubCatID = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productsView.updateUI()
        productCollectionViewSpacing()
        NewCollectionViewSpacing()
        getNewProduct()
        getSaleProduct()
        productsView.productCollectionView.reloadData()
        productsView.newProductCollectionView.reloadData()
        productsView.categoryNameLabel.text = receiveCatName
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        productsView.sortView.backgroundColor = ColorName.mainColor.color
        productsView.filterView.backgroundColor = ColorName.mainColor.color
        productsView.filterLabel.textColor = .white
        productsView.sortLabel.textColor = .white
    }
    
    func getNewProduct() {
        self.productsView.showLoader()
        APIManager.productsNew(id: receiveCatID, idSub: receiveSubCatID, idVendor: receiveVendorID) { (response) in
            switch response {
            case .failure(let err):
                print(err)
                self.show_Alert("Sorry", "SomeThing Went Wrong")
                self.productsView.hideLoader()
            case .success(let result):
                if result.message != "faild" && result.data.count > 0 {
                    self.productInformation = result.data
                    for i in result.data {
                        self.nameArray.append(i.name ?? "")
                        self.imageArray.append(i.image ?? "")
                        self.priceArray.append(i.price ?? "")
                        self.countArray.append(i.totalCountUser ?? "")
                        self.rateArray.append(i.totalRate ?? "")
                    }
                    self.productsView.hideLoader()
                    self.productsView.newProductCollectionView.reloadData()
                }
                else {
                    
                    self.productsView.hideLoader()
                }
            }
        }
    }
    func getSaleProduct() {
        self.productsView.showLoader()
        APIManager.productsSale(idSub: receiveSubCatID) { (response) in
            switch response {
            case .failure(let err):
                print(err)
                self.show_Alert("Sorry", "SomeThing Went Wrong")
                self.productsView.hideLoader()
            case .success(let result):
                if result.message != "faild" && result.data.count > 0 {
                    
                    self.productInformation1 = result.data
                    
                    for i in result.data {
                        self.nameArray1.append(i.products.name ?? "")
                        self.imageArray1.append(i.products.image ?? "")
                        self.priceArray1.append(i.products.price ?? "")
                        self.countArray1.append(i.products.totalCountUser ?? "")
                        self.rateArray1.append(i.products.totalRate ?? "")
                    }
                    self.productsView.hideLoader()
                    self.productsView.productCollectionView.reloadData()
                }
                else {
                    self.productsView.hideLoader()
                }
                
            }
        }
    }
    
    class func create() -> ProductsVC {
        let productVC: ProductsVC = UIViewController.create(storyboardName: Storyboards.products, identifier: ViewControllers.productsVC)
        return productVC
    }
    
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sortPressed(_ sender: Any) {
        productsView.sortView.backgroundColor = ColorName.white.color
        productsView.filterView.backgroundColor = ColorName.mainColor.color
        productsView.sortLabel.textColor = .black
        productsView.filterLabel.textColor = .white
        productsView.sortView.layer.cornerRadius = 16
        productsView.sortView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner,.layerMinXMaxYCorner,.layerMinXMinYCorner]
        productsView.sortFilterView.dropShadow(radius: 16, shadow: 3)
        let storyboard = UIStoryboard(name: Storyboards.home, bundle: nil)
        let searchVC = storyboard.instantiateViewController(withIdentifier: "SearchVC") as! SearchVC
        searchVC.receiveSubCat = receiveSubCatID
        self.present(searchVC, animated: true, completion: nil)
        
    }
    
    @IBAction func filterPrssed(_ sender: Any) {
        productsView.filterView.backgroundColor = ColorName.white.color
        productsView.sortView.backgroundColor = ColorName.mainColor.color
        productsView.filterLabel.textColor = .black
        productsView.sortLabel.textColor = .white
        productsView.filterView.layer.cornerRadius = 16
        productsView.filterView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner,.layerMinXMaxYCorner,.layerMinXMinYCorner]
        productsView.sortFilterView.dropShadow(radius: 16, shadow: 2)
        let filter = FilterVC.create()
        filter.subCatID = receiveSubCatID
        filter.catName = receiveCatName
        self.present(filter, animated: true, completion: nil)
        
        
    }
    
    
    func productCollectionViewSpacing() {
        if let layout = productsView.productCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            
            let width = 0.35 * productsView.productCollectionView.frame.width
            let height = CGFloat(253)
            layout.minimumLineSpacing = 16
            layout.minimumInteritemSpacing = 16
            layout.estimatedItemSize = .zero
            productsView.itemSize1 = CGSize(width: width, height: height)
        }
    }
    func NewCollectionViewSpacing(){
        if let layout = productsView.newProductCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            
            let width = 0.35 * productsView.newProductCollectionView.frame.width
            let height = CGFloat(253)
            layout.minimumLineSpacing = 16
            layout.minimumInteritemSpacing = 16
            layout.estimatedItemSize = .zero
            productsView.itemSize1 = CGSize(width: width, height: height)
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == productsView.newProductCollectionView {
            return nameArray.count
        }
        else {
            return nameArray1.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == productsView.newProductCollectionView  {
            let cell = productsView.newProductCollectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! NewCollectionViewCell
            cell.newProductName.text = nameArray[indexPath.row]
            cell.newProductImage.sd_setImage(with: URL(string: imageArray[indexPath.row]), completed: nil)
            cell.newProductPrice.text = "\(priceArray[indexPath.row]) KD"
            cell.favImage.isHidden = true
            cell.newProductImage.layer.cornerRadius = 8
            cell.newProductImage.layer.masksToBounds = true
            cell.newProductImage.clipsToBounds = true
            cell.newProductRate.settings.updateOnTouch = false
            cell.newProductRate.settings.fillMode = .precise
            cell.newProductRate.rating = Double(rateArray[indexPath.row]) ?? 0.0
            cell.contentView.layer.cornerRadius = 8
            cell.contentView.layer.masksToBounds = true
            cell.newProductRateCount.text = "(\(countArray[indexPath.row]))"
            return cell
        }
        else {
            let cell = productsView.productCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SaleCollectionViewCell
            cell.productName.text = nameArray1[indexPath.row]
            cell.productImage.sd_setImage(with: URL(string: imageArray1[indexPath.row]), completed: nil)
            cell.productPrice.text = "\(priceArray1[indexPath.row]) KD"
            cell.favImage.isHidden = true
            cell.productImage.layer.cornerRadius = 8
            cell.productImage.layer.masksToBounds = true
            cell.productRate.settings.updateOnTouch = false
            cell.productRate.settings.fillMode = .precise
            cell.productRate.rating = Double(rateArray1[indexPath.row]) ?? 0.0
            cell.contentView.layer.cornerRadius = 8
            cell.contentView.layer.masksToBounds = true
            cell.productRateCount.text = "(\(countArray1[indexPath.row]))"
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if collectionView == productsView.newProductCollectionView  {
            let proDetails = ProductDetailsVC.create()
            proDetails.receiveInfo = productInformation[indexPath.row]
            proDetails.checkNew = true
            proDetails.receiveVendorID = receiveVendorID
            self.present(proDetails, animated: true, completion: nil)
        }
        else {
            let proDetails = ProductDetailsVC.create()
            proDetails.receiveInfo1 = productInformation1[indexPath.row]
            proDetails.checkNew = false
            proDetails.receiveVendorID = receiveVendorID
            self.present(proDetails, animated: true, completion: nil)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = 0.35 * self.view.bounds.size.width
        let yourHeight = CGFloat(253)

        return CGSize(width: yourWidth, height: yourHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    
    
    

}
