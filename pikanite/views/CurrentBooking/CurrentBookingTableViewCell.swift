//
//  CurrentBookingTableViewCell.swift
//  pikanite
//
//  Created by Rakshitha Muranga Rodrigo on 2/26/18.
//  Copyright © 2018 Rakshitha Muranga Rodrigo. All rights reserved.
//

import UIKit
import GoogleMaps
import SDWebImage

class CurrentBookingTableViewCell: UITableViewCell {

    @IBOutlet weak var hotelImageView: UIImageView!
    @IBOutlet weak var hotelNameLabel: UILabel!
    @IBOutlet weak var hotelAddressLabel: UILabel!
    @IBOutlet weak var checkInDate: UILabel!
    @IBOutlet weak var checkOutDate: UILabel!
    @IBOutlet weak var checkInTime: UILabel!
    @IBOutlet weak var checkOutTime: UILabel!
    @IBOutlet weak var roomTypeLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var mapView: GMSMapView!
    
    
    var lon = 0.0000
    var lat = 0.0000
    var url = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        self.hotelImageView.sd_setImage(with: URL(string: url))
        getMap()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        self.hotelImageView.sd_setImage(with: URL(string: url))

        // Configure the view for the selected state
    }
    
    func getMap(){
        let lon = self.lon
        let lat = self.lat
        
        let camera = GMSCameraPosition.camera(withLatitude: Double(lat), longitude: Double(lon), zoom: 15)
        let gMapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        self.mapView.isMyLocationEnabled = true
        self.mapView.animate(to: camera)
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(Double(lat), Double(lon))
        marker.appearAnimation = GMSMarkerAnimation.pop
        marker.title = self.hotelNameLabel.text!
        marker.snippet = self.hotelAddressLabel.text!
        marker.infoWindowAnchor = CGPoint(x: 0.5, y: 0)
        marker.icon = BaseViewController().imageWithImage(image: #imageLiteral(resourceName: "icon_mapMaker"), scaledToSize: CGSize(width: 40.0, height: 40.0))
        marker.map = self.mapView // Mapview here
        
        self.mapView.addSubview(gMapView)
    }
    
}
