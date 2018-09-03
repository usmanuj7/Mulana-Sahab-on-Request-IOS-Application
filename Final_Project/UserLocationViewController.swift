//
//  UserLocationViewController.swift
//  Final_Project
//
//  Created by mb on 06/06/2018.
//  Copyright © 2018 mb. All rights reserved.
//

import UIKit
import GoogleMaps

class UserLocationViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate  {
    
    @IBOutlet weak var MapView: GMSMapView!

    // var for map
    var locationManager = CLLocationManager()
    var lat = CLLocationDegrees()
    var long = CLLocationDegrees()
    var coord = CLLocationCoordinate2D()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
         set_map_things()
        
    }
    override func viewWillAppear(_ animated: Bool) {
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func set_map_things() {
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        //        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        MapView.delegate = self
        MapView.isMyLocationEnabled = true
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            self.set_loc_camera()
        }
        
    }
    func set_loc_camera()  {
        let camera = GMSCameraPosition.camera(withTarget: coord, zoom: 16.0)
        print("loc \(self.lat)   \(self.long)")
        MapView.camera = camera
        view.addSubview(MapView)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //        if UIApplication.shared.applicationState == .active {
        //            print("App In Active State")
        //        } else {
        //            print("App in background State")
        //        }
        let location = locations.last!
        coord = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        self.lat = location.coordinate.latitude
        self.long = location.coordinate.longitude
        //        locationManager.stopUpdatingLocation()
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        mapView.selectedMarker = marker
        let camera = GMSCameraPosition.camera(withTarget: marker.position, zoom: 16.0)
        let update = GMSCameraUpdate.setCamera(camera)
        mapView.animate(with: update)
        //        mapView.animate(toViewingAngle: 60)
        //        mapView.animate(toViewingAngle: 60)
        
        //        let update = GMSCameraUpdate.zoom(by: 2)
        //        mapView.animate(with: update)
        
        
        //            mapView.animate(toZoom: 17)
        
        return true
    }
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        //        print(marker.userData!)
        
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        
            mapView.clear()
            print("Lat: \(coordinate.latitude) & Long: \(coordinate.longitude)")
            let position = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
            let marker = GMSMarker(position: position)
            marker.title = "abc"
            marker.map = MapView
            marker.icon = GMSMarker.markerImage(with: UIColor.red)
            _lat = coordinate.latitude
            _long = coordinate.longitude
        print("Lat: \(coordinate.latitude) & Long: \(coordinate.longitude)")
            let geocoder = GMSGeocoder()
        
            geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
                guard let address = response?.firstResult(), let lines = address.lines else {
                    return
                }
                let addressLabel = lines.joined(separator: ",")
                print(addressLabel)
                _Addres = addressLabel
            }
      
        
    }
    func get_location_Address(coord:CLLocationCoordinate2D) {
       
    }
    func user_loc_Draw_pins() {
        //        MapView.clear()
        var bounds = GMSCoordinateBounds()
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude:self.lat, longitude:self.long)
        
        //                marker.icon = GMSMarker.markerImage(with: AppDelegate.appcolor)
        
        marker.map = self.MapView
        bounds = bounds.includingCoordinate(marker.position)
        let update = GMSCameraUpdate.fit(bounds, withPadding: 100)
        MapView.animate(with: update)
    }


}
