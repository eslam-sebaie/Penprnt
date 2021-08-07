//
//  FavoriteTableViewCell.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 8/7/21.
//

import UIKit
import Cosmos
class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var prodImage: UIImageView!
    @IBOutlet weak var prodName: UILabel!
    @IBOutlet weak var rateView: CosmosView!
    @IBOutlet weak var rateCount: UILabel!
    @IBOutlet weak var prodPrice: UILabel!
    @IBOutlet weak var visual: UIVisualEffectView!
    override func awakeFromNib() {
        super.awakeFromNib()
        visual.setCornerRadius(radius: 16)
//        mainView.dropShadow(radius: 16, shadow: 2)
//        prodImage.dropShadow(radius: 16, shadow: 2)
        visual.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
