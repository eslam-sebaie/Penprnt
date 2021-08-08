//
//  OrderDetailsTableViewCell.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 8/8/21.
//

import UIKit

class OrderDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var prodImage: UIImageView!
    @IBOutlet weak var prodName: UILabel!
    @IBOutlet weak var prodPrice: UILabel!
    @IBOutlet weak var prodQuantity: UILabel!
    @IBOutlet weak var prodColor: UILabel!
    @IBOutlet weak var prodSize: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        prodColor.setBCdesign(borderWidth: 0, borderColor: .white, radius: 4)
        prodSize.setBCdesign(borderWidth: 1, borderColor: ColorName.borderColor.color, radius: 4)
        mainView.dropShadow(radius: 10, shadow: 2)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
