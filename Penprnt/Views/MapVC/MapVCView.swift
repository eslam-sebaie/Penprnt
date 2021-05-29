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
    
    let locationManager = CLLocationManager()
    
    func updateUI(){
        saveButton.layer.cornerRadius = 8
        saveButton.layer.masksToBounds = true
        
    }
    
}
