//
//  MapVCView.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 4/29/21.
//

import MapKit
import CoreLocation
class MapVCView: UIView {
    

    
    @IBOutlet weak var mapView: MKMapView!
    
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var backDesign: UIButton!
    let locationManager = CLLocationManager()
    
    func updateUI(){
        if L10n.lang.localized == Language.arabic {
            backDesign.transform = CGAffineTransform(scaleX: -1, y: 1)
        }
        saveButton.layer.cornerRadius = 8
        saveButton.layer.masksToBounds = true
        
    }
    
}
