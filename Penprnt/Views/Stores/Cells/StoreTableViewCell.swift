//
//  StoreTableViewCell.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 8/6/21.
//

import UIKit

class StoreTableViewCell: UITableViewCell {

    
    @IBOutlet weak var storeMainView: UIView!
    @IBOutlet weak var storeImage: UIImageView!
    @IBOutlet weak var storeNameView: UIView!
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var storeProductCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
