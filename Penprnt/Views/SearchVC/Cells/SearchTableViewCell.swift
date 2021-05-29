//
//  SearchTableViewCell.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 5/28/21.
//

import UIKit
import Cosmos
class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productRate: CosmosView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var rateCount: UILabel!
    @IBOutlet weak var visual: UIVisualEffectView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        visual.setCornerRadius(radius: 16)
        visual.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
