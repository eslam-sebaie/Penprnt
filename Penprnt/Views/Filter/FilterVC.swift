//
//  FilterVC.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 6/15/21.
//

import UIKit

class FilterVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet var filterView: FilterView!
    var subCatID = 0
    var catName = ""
    var colorArray = [0xFFFFFF, 0xC0C0C0,0x808080,0x000000,0xFF0000,0x800000, 0xFFFF00,0x808000, 0x00FF00,0x008000, 0x00FFFF,0x0000FF, 0x000080, 0xFF00FF, 0x800080, 0xA52A2A,0xADD8E6,0xFFC0CB, 0xFFD700]
    
    var colorArrayStr = ["#FFFFFF", "#C0C0C0","#808080","#000000","#FF0000","#800000", "#FFFF00","#808000", "#00FF00","#008000", "#00FFFF","#0000FF", "#000080", "#FF00FF", "#800080", "#A52A2A","#ADD8E6","#FFC0CB", "#FFD700"]
    var colorChoosen = ""
    var price = ""
   
   
    override func viewDidLoad() {
        super.viewDidLoad()
        filterCollectionViewSpacing()
        filterView.catName.text = catName
        filterView.colorCollectionView.reloadData()
        filterView.updateUI()
        // Do any additional setup after loading the view.
    }
    
    
    
    
    func filterCollectionViewSpacing() {
        if let layout = filterView.colorCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            
            let width = 40
            let height = 40
            layout.minimumLineSpacing = 16
            layout.minimumInteritemSpacing = 16
            layout.estimatedItemSize = .zero
            filterView.itemSize1 = CGSize(width: width, height: height)
        }
    }
    
    class func create() -> FilterVC {
        let filterVC: FilterVC = UIViewController.create(storyboardName: Storyboards.products, identifier: ViewControllers.filterVC)
        return filterVC
    }
    
    
    
    
    
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sliderPressed(_ sender: UISlider) {
        price = "\(Int(sender.value))"
        filterView.sliderValue.text = "\(Int(sender.value)) KD"
    }
    
    @IBAction func filterPressed(_ sender: Any) {
        let search = SearchVC.create()
        search.checkFilter = true
        search.receiveSubCat = subCatID
        search.receiveColor = colorChoosen
        search.receivePrice = filterView.sliderTxt
        self.present(search, animated: true, completion: nil)
    }
    
    
    @objc func popupHide() {
        self.filterView.savedView.isHidden = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = filterView.colorCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FilterCollectionViewCell
        cell.colorView.backgroundColor = UIColor(rgb: colorArray[indexPath.row])
        cell.colorView.setCornerRadius(radius: 8)
        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        colorChoosen = colorArrayStr[indexPath.row]
        filterView.savedView.isHidden = false
        self.perform(#selector(self.popupHide), with: self, afterDelay: 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = 40
        let yourHeight = 40
        
        return CGSize(width: yourWidth, height: yourHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
}
