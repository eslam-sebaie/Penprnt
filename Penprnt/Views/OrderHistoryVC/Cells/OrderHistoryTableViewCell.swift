//
//  OrderHistoryTableViewCell.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 8/8/21.
//

import UIKit

class OrderHistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var orderView: UIView!
    @IBOutlet weak var orderNumber: UILabel!
    @IBOutlet weak var orderStatus: UILabel!
    @IBOutlet weak var orderDate: UILabel!
    @IBOutlet weak var orderPrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
