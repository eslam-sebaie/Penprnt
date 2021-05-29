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
    var itemSize1 = CGSize(width: 0, height: 0)
    
    func updateUI() {
        searchTF.setCornerRadius(radius: 12)
        searchTF.setLeftPaddingPoints(10)
        searchTF.setRightPaddingPoints(10)
    }
}
