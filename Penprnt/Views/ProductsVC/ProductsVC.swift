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
    override func viewDidLoad() {
        super.viewDidLoad()
        productsView.updateUI()
        productCollectionViewSpacing()
        NewCollectionViewSpacing()
        getNewProduct()
        getSaleProduct()
        productsView.productCollectionView.reloadData()
        productsView.newProductCollectionView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    func getNewProduct() {
        APIManager.productsNew(id: receiveID) { (response) in
            switch response {
            case .failure(let err):
                print(err)
            case .success(let result):
                if result.message != "faild"{
                    for i in result.data {
                        self.nameArray.append(i.name ?? "")
                        self.imageArray.append(i.image ?? "")
                        self.priceArray.append(i.price ?? "")
                    }
                    self.productsView.newProductCollectionView.reloadData()
                }
            }
        }
    }
    func getSaleProduct() {
        APIManager.productsSale(id: receiveID) { (response) in
            switch response {
            case .failure(let err):
                print(err)
            case .success(let result):
                if result.message != "faild"{
                    for i in result.data {
                        self.nameArray1.append(i.products.name ?? "")
                        self.imageArray1.append(i.products.image ?? "")
                        self.priceArray1.append(i.products.price ?? "")
                    }
                    self.productsView.productCollectionView.reloadData()
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
    }
    
    @IBAction func filterPrssed(_ sender: Any) {
        productsView.filterView.backgroundColor = ColorName.white.color
        productsView.sortView.backgroundColor = ColorName.mainColor.color
        productsView.filterLabel.textColor = .black
        productsView.sortLabel.textColor = .white
        productsView.filterView.layer.cornerRadius = 16
        productsView.filterView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner,.layerMinXMaxYCorner,.layerMinXMinYCorner]
        productsView.sortFilterView.dropShadow(radius: 16, shadow: 2)
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
    //        cell.catImage.sd_setImage(with: URL(string: catImage[indexPath.row]), completed: nil)
    //        //        cell.contentView.layer.borderWidth = 1
    //        //        cell.contentView.layer.bor
    //        cell.catImage.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            cell.newProductImage.sd_setImage(with: URL(string: imageArray[indexPath.row]), completed: nil)
            cell.newProductPrice.text = priceArray[indexPath.row]
            cell.favImage.isHidden = true
            cell.newProductImage.layer.cornerRadius = 8
            cell.newProductImage.layer.masksToBounds = true
            cell.newProductImage.clipsToBounds = true
            
            cell.contentView.layer.cornerRadius = 8
            cell.contentView.layer.masksToBounds = true
            return cell
        }
        else {
            let cell = productsView.productCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SaleCollectionViewCell
            cell.productName.text = nameArray1[indexPath.row]
            cell.productImage.sd_setImage(with: URL(string: imageArray1[indexPath.row]), completed: nil)
            cell.productPrice.text = priceArray1[indexPath.row]
            cell.favImage.isHidden = true
            cell.productImage.layer.cornerRadius = 8
            cell.productImage.layer.masksToBounds = true
            cell.contentView.layer.cornerRadius = 8
            cell.contentView.layer.masksToBounds = true
            
            return cell
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
