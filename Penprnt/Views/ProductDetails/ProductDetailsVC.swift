//
//  ProductDetailsVC.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 6/30/21.
//

import UIKit

class ProductDetailsVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,UITextViewDelegate{
    
    
    @IBOutlet var productDetailsView: ProductDetailsView!
    var receiveInfo = productInfo(id: 0, image: "", name: "", datumDescription: "", itemNo: "", brandName: "", price: "", wholeSale: "", quantity: "", size: [], barCode: "", date: "", design: "", productColor: [], totalRate: "", totalCountUser: "", isActive: false, vendorID: "", categoryID: "", createdAt: "", updatedAt: "")
    
    var receiveInfo1 = MostProductInfo(productID: "", id: 0, products: Products(id: 0, image: "", name: "", productsDescription: "", itemNo: "", brandName: "", price: "", wholeSale: "", quantity: "", size: [], barCode: "", date: "", design: "", productColor: [], totalRate: "", totalCountUser: "", isActive: false, vendorID: "", categoryID: "", createdAt: "", updatedAt: ""))
    
    var checkNew = false
    var productID = 0
    var totalRate = ""
    var totalRateCount = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        print("!@$$$")
        print(checkNew)
        print(receiveInfo)
        print(receiveInfo1)
        
        colorCollectionViewSpacing()
        sizeCollectionViewSpacing()
        productDetailsView.updateUI()
        if checkNew {
            productDetailsView.setDetailsNew(info: receiveInfo)
            
        }
        else {
            productDetailsView.setDetailsMostSale(info: receiveInfo1)
        }
        productDetailsView.noteTextView.delegate = self
        
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
    
    
    @IBAction func cartPressed(_ sender: Any) {
        if productDetailsView.quantityLabel.text == "0.0" {
            self.show_Alert("Please!", "Enter Quantity.")
        }
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
        
//        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//            colorChoosen = colorArrayStr[indexPath.row]
//            filterView.savedView.isHidden = false
//            self.perform(#selector(self.popupHide), with: self, afterDelay: 1)
//        }
        
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
