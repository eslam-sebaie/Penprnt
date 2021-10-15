//
//  MapVC.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 4/29/21.
//

import UIKit

import MapKit
import CoreLocation
protocol sendingAddress {
    func send(address: String)
}

class MapVC: UIViewController {
    
    
    
    @IBOutlet var mapView: MapVCView!
    var delegate: sendingAddress?
    var previousLocation: CLLocation?
    var checkCat = false
    var lat = 0.0
    var lng = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        mapView.mapView.delegate = self
        
        checkLocationService()
        
        mapView.locationManager.delegate = self
        mapView.locationManager.requestAlwaysAuthorization()
        mapView.locationManager.startUpdatingLocation()
        
        let latitude = mapView.mapView.centerCoordinate.latitude
        let longtiude = mapView.mapView.centerCoordinate.longitude
        
        let location = CLLocation(latitude: latitude, longitude: longtiude)
        location.fetchCityAndCountry { city, country, error in
            guard let city = city, let country = country, error == nil else { return }
            print(city + ", " + country)
            
            let center = self.getCenterLocation(mapView: self.mapView.mapView)
            let geocoder = CLGeocoder()
            
            
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
                    
                    self.mapView.addressLabel.text = "\(streetNumber ?? "") \(streetName ?? "")"
                }
            }
        }
    }
    
    
    @IBAction func confirmPressed(_ sender: Any) {
        if checkCat {
            let searchRequest = MKLocalSearch.Request()
            searchRequest.naturalLanguageQuery =  mapView.addressLabel.text ?? ""
            let activeSearch = MKLocalSearch(request: searchRequest)
            activeSearch.start { (response, err) in
                if response == nil {
                    self.show_Alert("Sorry!","No Result Found")
                    
                }
                else {
                    
                    let latitude = response?.boundingRegion.center.latitude
                    let longitude = response?.boundingRegion.center.longitude
                    
                    self.lat = Double(latitude!)
                    self.lng = Double(longitude!)
                    
                    APIManager.updateAddress(emailNumber: UserDefaultsManager.shared().Email ?? "", address: self.mapView.addressLabel.text ?? "", lat: String(self.lat), lng: String(self.lng)) {
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
        else {
            self.delegate?.send(address: mapView.addressLabel.text ?? "eslam")
            dismiss(animated: true, completion: nil)
        }
    }
    
    
    
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func setupLocationManger(){
        mapView.locationManager.delegate = self
        mapView.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        
        
    }
    
    func centerViewOnUserLocation() {
        if let location = mapView.locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location , latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapView.mapView.setRegion(region, animated: true)
        }
    }
    
    func checkLocationAuthorization() {
        
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            // once we have authorization
            startTrackingUserLocation()
        case .denied:
            //not allowed not give this permission and show alert to show how turn on permission
            break
        case .notDetermined:
            mapView.locationManager.requestWhenInUseAuthorization()
        case .restricted:
            break
        case .authorizedAlways:
            break
        @unknown default:
            break
        }
        
    }
    
    func startTrackingUserLocation() {
        mapView.mapView.showsUserLocation = true
        centerViewOnUserLocation()
        mapView.locationManager.startUpdatingLocation()
        previousLocation = getCenterLocation(mapView: mapView.mapView)
    }
    
    func checkLocationService() {
        
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManger()
            checkLocationAuthorization()
        }
        else {
            print("errorSERVICE")
        }
        
    }
    
    func getCenterLocation(mapView: MKMapView) -> CLLocation {
        
        let latitude = self.mapView.mapView.centerCoordinate.latitude
        let longtiude = self.mapView.mapView.centerCoordinate.longitude
        
        let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longtiude)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: coordinate, span: span)
//        self.mapView.mapView.setRegion(region, animated: true)
        
        return CLLocation(latitude: latitude, longitude: longtiude)
        
    }
    
    
    
    
    
    
    
}

extension CLLocation {
    func fetchCityAndCountry(completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.locality, $0?.first?.country, $1) }
    }
}
