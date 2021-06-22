//
//  RateVC.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 6/12/21.
//

import UIKit

class RateVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var rateView: RateView!
    override func viewDidLoad() {
        super.viewDidLoad()
        rateView.updateUI()
        rateView.rateTableView.estimatedRowHeight = 44
        rateView.rateTableView.rowHeight = UITableView.automaticDimension
    }

    
    class func create() -> RateVC {
        let rateVC: RateVC = UIViewController.create(storyboardName: Storyboards.products, identifier: ViewControllers.rateVC)
        return rateVC
    }
    
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendCommentPressed(_ sender: Any) {
        print("SABAIE")
        guard let info = rateView.commentTF.text, info != "" else {
            show_Alert("Please", "Enter Your Comment.")
            return
        }
        rateView.rateBtn.isHidden = false
        rateView.mainRateView.isHidden = false
    }
    
    @IBAction func okPressed(_ sender: Any) {
        
    }
    @IBAction func outRatePressed(_ sender: Any) {
        self.rateView.rateBtn.isHidden = true
        self.rateView.mainRateView.isHidden = true
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = rateView.rateTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RateTableViewCell
        return cell
        
    }
    
}
