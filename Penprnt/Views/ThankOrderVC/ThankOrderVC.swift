//
//  ThankOrderVC.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 8/8/21.
//

import UIKit

class ThankOrderVC: UIViewController {

    @IBOutlet var thankOrderView: ThankOrderView!
    override func viewDidLoad() {
        super.viewDidLoad()
        thankOrderView.orderDeisgn.setCornerRadius(radius: 10)
        // Do any additional setup after loading the view.
    }
    class func create() -> ThankOrderVC {
        let thankOrderVC: ThankOrderVC = UIViewController.create(storyboardName: Storyboards.order, identifier: ViewControllers.thankOrderVC)
        return thankOrderVC
    }
    @IBAction func orderPressed(_ sender: Any) {
        let orderHistory = OrderHistoryVC.create()
        self.present(orderHistory, animated: true, completion: nil)
    }
    
   
}
