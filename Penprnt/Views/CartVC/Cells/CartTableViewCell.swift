//
//  CartTableViewCell.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 8/7/21.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var orderImage: UIImageView!
    @IBOutlet weak var orderName: UILabel!
    @IBOutlet weak var orderPrice: UILabel!
    @IBOutlet weak var orderQuantity: UILabel!
    @IBOutlet weak var orderolor: UILabel!
    @IBOutlet weak var orderSize: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        orderolor.setBCdesign(borderWidth: 0, borderColor: .white, radius: 4)
        orderSize.setBCdesign(borderWidth: 1, borderColor: ColorName.borderColor.color, radius: 4)
        mainView.dropShadow(radius: 10, shadow: 2)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
