//
//  ProductsView.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 5/2/21.
//

import UIKit

class ProductsView: UIView {

    @IBOutlet weak var productCollectionView: UICollectionView!
    
    @IBOutlet weak var newProductCollectionView: UICollectionView!
    
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var sortFilterView: UIView!
    @IBOutlet weak var sortView: UIView!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var sortLabel: UILabel!
    @IBOutlet weak var filterLabel: UILabel!
    
    var itemSize1 = CGSize(width: 0, height: 0)
    
    func updateUI(){
        sortView.layer.cornerRadius = 16
        sortView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        
        filterView.layer.cornerRadius = 16
        filterView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        sortFilterView.dropShadow(radius: 16, shadow: 2)
    }
}
