//
//  SubCategoryView.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 8/6/21.
//

import UIKit

class SubCategoryView: UIView {

    @IBOutlet weak var subCatCollectionView: UICollectionView!
    var nameChoosen = ""
    var itemSize1 = CGSize(width: 0, height: 0)

    func determineCollectionViewSpacing(){
        if let layout = subCatCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let itemPerRow: CGFloat = 2
            
            let width = subCatCollectionView.frame.width / itemPerRow
            let height = CGFloat(223)
            layout.minimumLineSpacing = 5
            layout.minimumInteritemSpacing = 10
            layout.estimatedItemSize = itemSize1
            itemSize1 = CGSize(width: width, height: height)
        }
    }
}
