//
//  FilterView.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 6/15/21.
//

import UIKit
import fluid_slider
class FilterView: UIView {

    @IBOutlet weak var catName: UILabel!
    @IBOutlet weak var colorCollectionView: UICollectionView!
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var sliderDesign: UISlider!
    @IBOutlet weak var sliderValue: UILabel!
    @IBOutlet weak var filterDesign: UIButton!
    
    @IBOutlet weak var savedView: UIView!
    @IBOutlet weak var slide: Slider!
    
    var itemSize1 = CGSize(width: 0, height: 0)
    var sliderTxt = ""
    func updateUI(){
        savedView.isHidden = true
        savedView.dropShadow(radius: 16, shadow: 2)
        mainView.dropShadow(radius: 20, shadow: 2)
        filterDesign.setCornerRadius(radius: 8)
        mainView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        slide.attributedTextForFraction = { fraction in
            let formatter = NumberFormatter()
            formatter.maximumIntegerDigits = 4
            formatter.maximumFractionDigits = 0
            let string = formatter.string(from: (fraction * 1000) as NSNumber) ?? ""
            self.sliderTxt = string
            return NSAttributedString(string: string)
        }
        slide.setMinimumLabelAttributedText(NSAttributedString(string: "0 KD"))
        
        slide.setMaximumLabelAttributedText(NSAttributedString(string: "1000 KD"))
        slide.fraction = 0.5
        slide.shadowOffset = CGSize(width: 0, height: 10)
        slide.shadowBlur = 5
        slide.shadowColor = UIColor(white: 0, alpha: 0.1)
        slide.contentViewColor = ColorName.mainColor.color
        slide.valueViewColor = .white
        
    }
    

}
