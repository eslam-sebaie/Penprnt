//
//  RateView.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 6/12/21.
//

import UIKit
import Cosmos
class RateView: UIView {

    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var totalRateLabel: UILabel!
    @IBOutlet weak var rateView: CosmosView!
    @IBOutlet weak var rateCount: UILabel!
    @IBOutlet weak var rateTableView: UITableView!
    
    @IBOutlet weak var commentTF: UITextField!
    @IBOutlet weak var mainRateView: UIView!
    @IBOutlet weak var rateStars: CosmosView!
    @IBOutlet weak var okDesign: UIButton!
    @IBOutlet weak var rateBtn: UIButton!
    
    func updateUI() {
        rateStars.rating = 0
        rateView.settings.updateOnTouch = false
        rateStars.settings.updateOnTouch = true
        rateStars.settings.fillMode = .precise
        rateView.settings.fillMode = .precise
        mainRateView.isHidden = true
        okDesign.setCornerRadius(radius: 8)
        mainRateView.dropShadow(radius: 16, shadow: 2)
        rateBtn.isHidden = true
        
    }
}
