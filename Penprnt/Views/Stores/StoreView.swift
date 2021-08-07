//
//  StoreView.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 8/6/21.
//

import UIKit

class StoreView: UIView {

    @IBOutlet weak var storeTableView: UITableView!
    
    @IBOutlet weak var sideView: UIView!
    @IBOutlet weak var hideMenuDesign: UIButton!
    
    var checkView = false
    
    func menu(){
        if checkView == false {
            
            sideView.isHidden = false
            hideMenuDesign.isHidden = false
            self.checkView = true
            sideView.alpha = 1.0
            sideView.layoutSubviews()
        } else {
            UIView.animate(withDuration: 0.6, animations: {
                self.sideView.alpha = 0.0
            }) {_ in
                self.sideView.isHidden = true
            }
            self.checkView = false
            hideMenuDesign.isHidden = true
        }
    }
}
