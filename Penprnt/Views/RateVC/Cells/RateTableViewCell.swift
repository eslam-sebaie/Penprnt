//
//  RateTableViewCell.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 6/12/21.
//

import UIKit
import Cosmos
class RateTableViewCell: UITableViewCell {

    @IBOutlet weak var rateImage: UIImageView!
    @IBOutlet weak var rateName: UILabel!
    @IBOutlet weak var rateDate: UILabel!
    @IBOutlet weak var rateView: CosmosView!
    @IBOutlet weak var rateInfo: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        rateImage.setCornerRadius(radius: 24)
        rateView.settings.updateOnTouch = false
        rateView.settings.fillMode = .precise
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
