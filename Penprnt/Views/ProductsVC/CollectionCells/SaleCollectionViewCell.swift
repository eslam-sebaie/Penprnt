//
//  SaleCollectionViewCell.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 5/2/21.
//

import UIKit
import Cosmos
class SaleCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productRate: CosmosView!
    @IBOutlet weak var productRateCount: UILabel!
    @IBOutlet weak var favImage: UIImageView!
    
    
    
}
