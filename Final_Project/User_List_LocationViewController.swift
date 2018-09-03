//
//  User_List_LocationViewController.swift
//  Final_Project
//
//  Created by mb on 29/06/2018.
//  Copyright © 2018 mb. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire
import SwiftyJSON
class User_List_LocationViewController: UIViewController,  GMSMapViewDelegate, CLLocationManagerDelegate {

    
    @IBOutlet weak var MapView: GMSMapView!
    
    // var for map
    var locationManager = CLLocationManager()
    var lat = CLLocationDegrees()
    var long = CLLocationDegrees()
    var coord = CLLocationCoordinate2D()
    override func viewDidLoad() {
        super.viewDidLoad()
        set_map_things()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
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
        DispatchQueue.main.asyncAfter(deadline: .now()+10) {
            self.set_loc_camera()
            self.getPolylineRoute(lat1: "\(Map_Data.R_Lat)", lat2: "\(Mulana.M_Lat)", long1: "\(Map_Data.R_Long)", long2: "\(Mulana.M_Long)")
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
        coord = CLLocationCoordinate2D(latitude: Map_Data.R_Lat, longitude: Map_Data.R_Long)
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
        S_User_Lat = coordinate.latitude
        S_User_Long = coordinate.longitude
        print("Lat: \(coordinate.latitude) & Long: \(coordinate.longitude)")
        let geocoder = GMSGeocoder()
        
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            guard let address = response?.firstResult(), let lines = address.lines else {
                return
            }
            let addressLabel = lines.joined(separator: ",")
            print(addressLabel)
            S_User_Adress = addressLabel
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    // Pass your source and destination coordinates in this method.
    func getPolylineRoute(lat1:String,lat2:String,long1:String,long2:String){
        var url = ""
        
        url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(lat1),\(long1)&destination=\(lat2),\(long2)&mode=driving&alternatives=true&units=metric"
        
        
        print(url)
        Alamofire.request(url).responseJSON { response in
            print(response.request as Any)  // original URL request
            print(response.response as Any) // HTTP URL response
            print(response.data as Any)     // server data
            print(response.result as Any)   // result of response serialization
            //    let image = UIImage(cgImage: #imageLiteral(resourceName: "man.png") as! CGImage)
            var json = JSON(response.value!)
            print(json)
            let routes = json["routes"].arrayValue
            print(routes.count)
            if routes.count > 0
            {
                var co = 0
                for route in routes
                {
                    var routeOverviewPolyline = route["overview_polyline"].dictionary
                    let points = routeOverviewPolyline!["points"]?.stringValue
                    let path = GMSPath.init(fromEncodedPath: points!)!
                    
                    let polyline = GMSPolyline.init(path: path)
                    if co == 0
                    {
                        polyline.strokeWidth = 5
                        polyline.strokeColor = UIColor.darkGray.withAlphaComponent(0.75)
                        polyline.map = self.MapView
                        co += 1
                    }
                    
                }
                
            }
        }
    }

}
