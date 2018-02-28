//
//  NearbyHotelsViewController.swift
//  pikanite
//
//  Created by Rakshitha Muranga Rodrigo on 2/10/18.
//  Copyright © 2018 Rakshitha Muranga Rodrigo. All rights reserved.
//

import UIKit
import GoogleMaps

class NearbyHotelsViewController: BaseViewController {

    //MARK: Outlets
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var markerCustomView: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    var offerArray:[Offer] = []
    var offerIndex = 0
    
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
      
            
            let lat = self.offerArray[i].lat
            let long = self.offerArray[i].lon
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2DMake(lat,long)
            marker.appearAnimation = GMSMarkerAnimation.pop
                        marker.title = self.offerArray[i].hotelName
                        let address = self.offerArray[i].hotelAddress
                        let addressDict = self.convertToDictionary(text: address)
                        print(addressDict!)
                        marker.snippet = "\(addressDict!["No"]!),\(addressDict!["Street"]!), \(addressDict!["Address"]!)"
                        marker.infoWindowAnchor = CGPoint(x: 0.5, y: 0)
            let DynamicView=UIView(frame: CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 70, height: 70)))
            DynamicView.backgroundColor=UIColor.clear
            var imageViewForPinMarker : UIImageView
            imageViewForPinMarker  = UIImageView(frame:CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 70, height: 70)))
            imageViewForPinMarker.image = UIImage(named:"icon_priceTag") //icon_priceTag
            
            let textCurrency = UILabel(frame:CGRect(origin: CGPoint(x: 0,y :-20), size: CGSize(width: 70, height: 70)))
            textCurrency.text = "LKR"
            textCurrency.textAlignment = .center
            textCurrency.font = UIFont(name: textCurrency.font.fontName, size: 12)
            textCurrency.textAlignment = NSTextAlignment.center
            textCurrency.textColor = .white
            imageViewForPinMarker.addSubview(textCurrency)
            
            let text = UILabel(frame:CGRect(origin: CGPoint(x: 0,y :-5), size: CGSize(width: 70, height: 70)))
            text.text = "\((self.offerArray[i].discount)/1000)K"
            text.textAlignment = .center
            text.font = UIFont(name: text.font.fontName, size: 17)
            text.textAlignment = NSTextAlignment.center
            text.textColor = .white
            
            imageViewForPinMarker.addSubview(text)
            DynamicView.addSubview(imageViewForPinMarker)
            UIGraphicsBeginImageContextWithOptions(DynamicView.frame.size, false, UIScreen.main.scale)
            DynamicView.layer.render(in: UIGraphicsGetCurrentContext()!)
            let imageConverted: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            
            marker.icon = imageConverted
            marker.map = self.mapView
            
       
        }
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
