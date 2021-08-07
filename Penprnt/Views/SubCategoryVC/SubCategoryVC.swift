//
//  SubCategoryVC.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 8/6/21.
//

import UIKit

class SubCategoryVC: UIViewController , UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{

    @IBOutlet var subCatCollectionView: SubCategoryView!
    var receiveCatID = ""
    var receiveVendorID = ""
    var subCat = [SubCatInfo]()
    override func viewDidLoad() {
        super.viewDidLoad()
        subCatCollectionView.determineCollectionViewSpacing()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        getSubCats()
    }
    

    class func create() -> SubCategoryVC {
        let searchVC: SubCategoryVC = UIViewController.create(storyboardName: Storyboards.home, identifier: ViewControllers.subCategoryVC)
        return searchVC
    }
    
    
    func getSubCats() {
        self.subCatCollectionView.showLoader()
        APIManager.getSubCategories(categoryId: receiveCatID) { (response) in
            switch response {
            case .failure(let err):
                print(err)
            case .success(let result):
                self.subCatCollectionView.hideLoader()
                self.subCat = result.data ?? []
                self.subCatCollectionView.subCatCollectionView.reloadData()
            }
        }
    }

    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subCat.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = subCatCollectionView.subCatCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SubCategoryCollectionViewCell
        cell.subCatName.text = subCat[indexPath.row].name
        cell.subCatDetails.text = subCat[indexPath.row].details
        cell.subCatImage.sd_setImage(with: URL(string: subCat[indexPath.row].image ?? ""), completed: nil)

        cell.subCatImage.layer.cornerRadius = 8
        cell.subCatImage.layer.masksToBounds = true
        cell.contentView.layer.cornerRadius = 8
        cell.contentView.layer.masksToBounds = true
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        print("@@##@#@")
        print(Int(receiveVendorID)!)
        print(Int(receiveCatID)!)
        print(subCat[indexPath.row].id ?? 0)
        subCatCollectionView.nameChoosen = subCat[indexPath.row].name ?? ""
        let products = ProductsVC.create()
        products.receiveCatName = subCatCollectionView.nameChoosen
        products.receiveVendorID = Int(receiveVendorID)!
        products.receiveCatID = Int(receiveCatID)!
        products.receiveSubCatID = subCat[indexPath.row].id ?? 0
        
        self.present(products, animated: true, completion: nil)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = 0.4 * self.view.frame.size.width
        let yourHeight = CGFloat(223)

        return CGSize(width: yourWidth, height: yourHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}
