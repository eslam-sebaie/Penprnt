//
//  RateVC.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 6/12/21.
//

import UIKit

class RateVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var rateView: RateView!
    var receiveProductID = 0
    var receiveTotalRate = ""
    var receiveTotalRateCount = ""
    var rateData = [RateInfo]()
    override func viewDidLoad() {
        super.viewDidLoad()
        rateView.updateUI()
//        rateView.totalRateLabel.text = receiveTotalRate
//        rateView.rateView.rating = Double(receiveTotalRate) ?? 0.0
//        rateView.rateCount.text = "Reviews (\(receiveTotalRateCount))"
        rateView.rateTableView.estimatedRowHeight = 44
        rateView.rateTableView.rowHeight = UITableView.automaticDimension
        getRate()
    }

    
    class func create() -> RateVC {
        let rateVC: RateVC = UIViewController.create(storyboardName: Storyboards.products, identifier: ViewControllers.rateVC)
        return rateVC
    }
    
    func getRate(){
        APIManager.getRate(productId: receiveProductID) { (response) in
            switch response {
            case .failure(let err):
                print(err)
            case .success(let result):
                self.rateData = result.data ?? []
                let x = Double(self.rateData.last?.product?.totalRate ?? "") ?? 0.0
                let y = Double(round(10 * x)/10)
                
                self.rateView.totalRateLabel.text = String(y)
                self.rateView.rateView.rating = Double(self.rateData.last?.product?.totalRate ?? "") ?? 0.0
                
                self.rateView.rateCount.text = "Reviews (\(self.rateData.last?.product?.totalCountUser ?? ""))"
                self.rateView.rateTableView.reloadData()
            }
        }
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
      
        if UserDefaultsManager.shared().Email == nil || UserDefaultsManager.shared().Email == "" {
            showAlert(title: "Sorry No Account.", massage: "Do You Want To Register?", present: self, titleBtn: "OK") {
                let signUp = SignUpVC.create()
                self.present(signUp, animated: true, completion: nil)
            }
        }
        else {
            self.rateView.showLoader()
            let currentDateTime = Date()
            let dateStamp:TimeInterval = currentDateTime.timeIntervalSince1970
            let dateSt:Int = Int(dateStamp)
            let dateTimeStamp = String(dateSt)
            
            APIManager.postRate(emailNumber: UserDefaultsManager.shared().Email!, star: String(rateView.rateStars.rating), comment: rateView.commentTF.text!, productId: receiveProductID, date: dateTimeStamp) {
                self.rateData = []
                self.getRate()
                self.rateView.hideLoader()
                self.rateView.rateBtn.isHidden = true
                self.rateView.mainRateView.isHidden = true
            }
          
           
            
        }
        
    }
    
    @IBAction func outRatePressed(_ sender: Any) {
        self.rateView.rateBtn.isHidden = true
        self.rateView.mainRateView.isHidden = true
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rateData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = rateView.rateTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RateTableViewCell
        
        cell.rateImage.sd_setImage(with: URL(string: rateData[indexPath.row].user?.image ?? ""), completed: nil)
        cell.rateImage.setCornerRadius(radius: 24)
        cell.rateName.text = rateData[indexPath.row].user?.name ?? ""
        cell.rateInfo.text = rateData[indexPath.row].comment ?? ""
        let date = Int(rateData[indexPath.row].date ?? "")
        cell.rateDate.text = convertTimeStamp(date: date ?? 0)
        cell.rateView.rating = Double(rateData[indexPath.row].star ?? "") ?? 0.0
        return cell
        
    }
    
}
