//
//  tabViewController.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 4/29/21.
//

import UIKit

class tabViewController: UITabBarController {

  override func viewDidLoad() {
    super.viewDidLoad()
//    self.tabBarItem.badgeColor = .red
    let layer = CAShapeLayer()
    layer.path = UIBezierPath(roundedRect: CGRect(x: 24, y: tabBar.bounds.minY , width: tabBar.bounds.width - 48, height: tabBar.bounds.height + 3), cornerRadius: (tabBar.frame.width/2)).cgPath
    layer.shadowColor = UIColor.white.cgColor
    layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
    layer.shadowRadius = 25.0
    layer.shadowOpacity = 0.3
    layer.borderWidth = 1.0
    layer.opacity = 1.0
    layer.isHidden = false
    layer.masksToBounds = false
    layer.fillColor = ColorName.mainColor.color.cgColor

    UITabBar.appearance().layer.borderWidth = 0.0
    UITabBar.appearance().clipsToBounds = true

    tabBar.layer.insertSublayer(layer, at: 0)

    if let items = tabBar.items {
        items.forEach { item in
            item.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -5, right: 0)
        }
    }
//    tabBar.barStyle = .default
    tabBar.itemWidth = 30.0
    tabBar.itemPositioning = .centered
  }
}
