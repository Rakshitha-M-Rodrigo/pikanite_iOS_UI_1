//
//  NearbyHotelsViewController.swift
//  pikanite
//
//  Created by Rakshitha Muranga Rodrigo on 2/10/18.
//  Copyright © 2018 Rakshitha Muranga Rodrigo. All rights reserved.
//

import UIKit
import GoogleMaps

class NearbyHotelsViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var mapView: GMSMapView!
    var offerArray:[Offer] = []
    
    //MARK: Variables
    var lon: Double = 0.0000000000
    var lat: Double = 0.0000000000
    var name: String = "Hotel"
    var price: String = "0"
    var rate: Int = 0
    
    var mode: String = "discover"  //[discover, hotel]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self as? GMSMapViewDelegate
        switch self.mode {
        case "discover":
            print("loading discover map....")
            self.getMap()
        case "hotel":
            print("loading hotel map....")
            loadHotelMap()
        default:
            print("loading discover map.....")
        }
        
        
    }
    
    func loadHotelMap(){
        let camera = GMSCameraPosition.camera(withLatitude: self.lat, longitude: self.lon, zoom: 15.0)
        let gsmMapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        self.mapView = gsmMapView
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = self.mapView
    }
    
    
    func getMap() {
        
        let mainlon = self.offerArray[0].lon
        let mainlat = self.offerArray[0].lat
        
        let camera = GMSCameraPosition.camera(withLatitude: Double(mainlat), longitude: Double(mainlon), zoom: 15)
        let gMapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        
        self.mapView.animate(to: camera)
        self.mapView.isMyLocationEnabled = true

        
        for i in 0..<offerArray.count{
            let lon = self.offerArray[i].lon
            let lat = self.offerArray[i].lat
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2DMake(Double(lat), Double(lon))
            marker.appearAnimation = GMSMarkerAnimation.pop
            marker.title = self.offerArray[i].hotelName
            marker.infoWindowAnchor = CGPoint(x: 0.5, y: 0)
            marker.icon = #imageLiteral(resourceName: "icon_mapMaker")
            marker.map = self.mapView
        }
        self.mapView.addSubview(gMapView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
//        self.dismiss(animated: true, completion: nil)
    }
    
    

}
