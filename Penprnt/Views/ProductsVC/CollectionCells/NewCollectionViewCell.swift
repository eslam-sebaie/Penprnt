//
//  NewCollectionViewCell.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 5/2/21.
//

import UIKit
import Cosmos
class NewCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var newProductImage: UIImageView!
    @IBOutlet weak var newProductName: UILabel!
    @IBOutlet weak var newProductPrice: UILabel!
    @IBOutlet weak var newProductRate: CosmosView!
    @IBOutlet weak var newProductRateCount: UILabel!
    @IBOutlet weak var favImage: UIImageView!
    override func prepareForReuse() {
        newProductImage.image = nil
        self.setCornerRadius(radius: 8)
    }
}
