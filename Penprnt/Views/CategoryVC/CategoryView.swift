//
//  CategoryView.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 4/29/21.
//

import UIKit
import ImageSlideshow
class CategoryView: UIView {
    
    
    
    @IBOutlet weak var catCollectionView: UICollectionView!
    @IBOutlet weak var sideView: UIView!
    @IBOutlet weak var hideMenuDesign: UIButton!
    @IBOutlet weak var bannerView: ImageSlideshow!
    
    
    var checkView = false
    var itemSize1 = CGSize(width: 0, height: 0)
    var nameChoosen = ""
    
    func updateUI(){
        bannerView.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
        bannerView.slideshowInterval = 3.0
        bannerView.zoomEnabled = true
        bannerView.circular = true
        //        bannerView.pageIndicator = nil
        bannerView.contentScaleMode = .scaleToFill
        bannerView.layer.cornerRadius = 16
        bannerView.layer.masksToBounds = true
        let pageIndicator = UIPageControl()
        pageIndicator.currentPageIndicatorTintColor = #colorLiteral(red: 0.1803921569, green: 0.8705882353, blue: 0.8196078431, alpha: 1)
        pageIndicator.pageIndicatorTintColor = .white
        bannerView.pageIndicator = pageIndicator
    }
    
    func determineCollectionViewSpacing(){
        if let layout = catCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let itemPerRow: CGFloat = 2
            
            let width = catCollectionView.frame.width / itemPerRow
            let height = CGFloat(223)
            layout.minimumLineSpacing = 5
            layout.minimumInteritemSpacing = 10
            layout.estimatedItemSize = itemSize1
            itemSize1 = CGSize(width: width, height: height)
        }
    }
    
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
class AnimationView: UIView {
    enum Direction: Int {
        case FromLeft = 0
        case FromRight = 1
    }
    
    @IBInspectable var direction : Int = 0
    @IBInspectable var delay :Double = 0.0
    @IBInspectable var duration :Double = 0.0
    override func layoutSubviews() {
        
        initialSetup()
        UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.2, options: .curveEaseIn, animations: {
            if let superview = self.superview {
                if self.direction == Direction.FromLeft.rawValue {
                    self.center.x += superview.bounds.width
                } else {
                    self.center.x -= superview.bounds.width
                }
            }
        })
    }
    func initialSetup() {
        if let superview = self.superview {
            if direction == Direction.FromLeft.rawValue {
                self.center.x -= superview.bounds.width
            } else {
                self.center.x += superview.bounds.width
            }
            
        }
    }
}
