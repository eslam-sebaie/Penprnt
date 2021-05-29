//
//  ProfileView.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 5/23/21.
//

import UIKit

class ProfileView: UIView {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    
    func updateUI(){
        userImage.setCornerRadius(radius: 8)
    }
    
    
    
}
