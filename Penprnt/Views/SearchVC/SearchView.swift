//
//  SearchView.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 5/24/21.
//

import UIKit

class SearchView: UIView {

  
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var productTableView: UITableView!
    @IBOutlet weak var searchLabel: UILabel!
    @IBOutlet weak var searchHeight: NSLayoutConstraint!
    @IBOutlet weak var labelHeight: NSLayoutConstraint!
    @IBOutlet weak var searchImage: UIImageView!
    @IBOutlet weak var searchDesign: UIButton!
    
    @IBOutlet weak var searchDesignHeaight: NSLayoutConstraint!
    
    
    var itemSize1 = CGSize(width: 0, height: 0)
    
    func updateUI() {
        searchTF.setCornerRadius(radius: 12)
        searchTF.setLeftPaddingPoints(10)
        searchTF.setRightPaddingPoints(10)
    }
}
