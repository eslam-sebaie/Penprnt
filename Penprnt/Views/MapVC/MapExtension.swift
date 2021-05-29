//
//  MapExtension.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 4/29/21.
//

import UIKit
import MapKit
extension MapVC: CLLocationManagerDelegate {
    
    func fetchCityAndCountry(from location: CLLocation, completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            completion(placemarks?.first?.subThoroughfare,
                       placemarks?.first?.thoroughfare,
                       error)
        }
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
    
}
extension MapVC: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = getCenterLocation(mapView: mapView)
        let geocoder = CLGeocoder()
        guard let previousLocation = self.previousLocation else {return}
        guard center.distance(from: previousLocation) > 50 else {return}
        self.previousLocation = center
        
        geocoder.reverseGeocodeLocation(center) {[weak self] (placemarks, error) in
            guard let self = self else {return}
            
            if let _  = error {
                return
            }
            
            guard let placemark = placemarks?.first else {
                
                return
            }
            let streetNumber = placemark.subThoroughfare
            
            let streetName = placemark.thoroughfare
            DispatchQueue.main.async {
                
//                self.searchBar.text = "\(streetNumber ?? "") \(streetName ?? "")"
                self.mapView.addressLabel.text = "\(streetNumber ?? "") \(streetName ?? "")"
                
               
            }
        }
        
    }
    
    
}

