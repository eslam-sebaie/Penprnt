//
//  ProductDetailsView.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 6/30/21.
//

import UIKit
import Cosmos
import SDWebImage
class ProductDetailsView: UIView {
    
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var saveView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productRate: CosmosView!
    @IBOutlet weak var productRateCount: UILabel!
    
    @IBOutlet weak var productDescription: UILabel!
    
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var colorViewHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var colorCollectionView: UICollectionView!
    
    @IBOutlet weak var sizeView: UIView!
    @IBOutlet weak var sizeViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var sizeCollectionView: UICollectionView!
    
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var addToCartDesign: UIButton!
    
    @IBOutlet weak var quantityStepper: UIStepper!
    
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var optionalLabel: UILabel!
    
    @IBOutlet weak var halfCornerView: UIView!
    @IBOutlet weak var upperColorHeight: NSLayoutConstraint!
    
    @IBOutlet weak var upperSizeHeight: NSLayoutConstraint!
    
    @IBOutlet weak var favoriteDesign: UIButton!
    
    var itemSize = CGSize(width: 0, height: 0)
    var itemSize1 = CGSize(width: 0, height: 0)
    
    
    func updateUI(){
        saveView.isHidden = true
        saveView.dropShadow(radius: 10, shadow: 2)
        halfCornerView.setCornerRadius(radius: 25)
        halfCornerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
      
        addToCartDesign.setCornerRadius(radius: 8)
        noteTextView.setBCdesign(borderWidth: 1, borderColor: ColorName.welcomeBorder.color, radius: 8)
    }
    
    func setDetailsNew(info: productInfo) {
        
        productImage.sd_setImage(with: URL(string: info.image ?? ""), completed: nil)
        productName.text = info.name
        productPrice.text = "KD \(info.price ?? "")"
        productRate.rating = Double(info.totalRate ?? "") ?? 0.0
        productRateCount.text = "(\(info.totalCountUser ?? "0"))"
        productDescription.text = info.datumDescription
        quantityStepper.maximumValue = Double(info.quantity ?? "") ?? 0.0
        if info.productColor?.count == 0 {
            colorView.isHidden = true
            colorViewHeight.constant = 0
            upperColorHeight.constant = 0
        }
        else {
            colorCollectionView.reloadData()
        }
        if info.size?.count == 0 {
            sizeView.isHidden = true
            sizeViewHeight.constant = 0
            upperSizeHeight.constant = 0
        }
        else {
            sizeCollectionView.reloadData()
        }
        
    }
    func setDetailsMostSale(info: MostProductInfo){
        productImage.sd_setImage(with: URL(string: info.products.image ?? ""), completed: nil)
        productName.text = info.products.name
        productPrice.text = "KD \(info.products.price ?? "")"
        productRate.rating = Double(info.products.totalRate ?? "") ?? 0.0
        productRateCount.text = "(\(info.products.totalCountUser ?? "0"))"
        productDescription.text = info.products.productsDescription
        quantityStepper.maximumValue = Double(info.products.quantity ?? "") ?? 0.0
        if info.products.productColor?.count == 0 {
            colorView.isHidden = true
            colorViewHeight.constant = 0
            upperColorHeight.constant = 0
        }
        else {
            colorCollectionView.reloadData()
        }
        if info.products.size?.count == 0 {
            sizeView.isHidden = true
            sizeViewHeight.constant = 0
            upperSizeHeight.constant = 0
        }
        else {
            sizeCollectionView.reloadData()
        }
    }
    
    func setPlaceHolder(){
        if noteTextView.text.count == 0 {
            optionalLabel.isHidden = false
        }
        else {
            optionalLabel.isHidden = true
        }
    }
    
}
