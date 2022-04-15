//
//  StoreView.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 8/6/21.
//

import UIKit

class StoreView: UIView {

    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var storeTableView: UITableView!
    
    @IBOutlet weak var sideView: UIView!
    @IBOutlet weak var hideMenuDesign: UIButton!
    
    @IBOutlet weak var storeCollectionView: UICollectionView!
    
    @IBOutlet weak var homeBack: UIImageView!
    @IBOutlet weak var orderBack: UIImageView!
    @IBOutlet weak var cardBack: UIImageView!
    
    @IBOutlet weak var locationBack: UIImageView!
    @IBOutlet weak var shareBack: UIImageView!
    
    @IBOutlet weak var privacyBack: UIImageView!
    
    @IBOutlet weak var signOutBack: UIImageView!
    
    var checkView = false
    var itemSize1 = CGSize(width: 0, height: 0)

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
    func determineCollectionViewSpacing(){
        if L10n.lang.localized == Language.arabic {
            header.text = "الرئيسيه"
            homeBack.transform = CGAffineTransform(scaleX: -1, y: 1)
            orderBack.transform = CGAffineTransform(scaleX: -1, y: 1)
            cardBack.transform = CGAffineTransform(scaleX: -1, y: 1)
            locationBack.transform = CGAffineTransform(scaleX: -1, y: 1)
            shareBack.transform = CGAffineTransform(scaleX: -1, y: 1)
            privacyBack.transform = CGAffineTransform(scaleX: -1, y: 1)
            signOutBack.transform = CGAffineTransform(scaleX: -1, y: 1)

        }
        if let layout = storeCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let itemPerRow: CGFloat = 2
            
            let width = storeCollectionView.frame.width / itemPerRow
            let height = CGFloat(223)
            layout.minimumLineSpacing = 5
            layout.minimumInteritemSpacing = 10
            layout.estimatedItemSize = itemSize1
            itemSize1 = CGSize(width: width, height: height)
        }
    }
}
