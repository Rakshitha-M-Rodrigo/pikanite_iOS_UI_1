//
//  DiscoverViewController.swift
//  pikanite
//
//  Created by Rakshitha Muranga Rodrigo on 1/23/18.
//  Copyright © 2018 Rakshitha Muranga Rodrigo. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

class DiscoverViewController: BaseViewController {

    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noOffersLabel: UILabel!
    
    //MARK: Variables
    var offerArray: [Offer] = []
    var animated = true
    
    override func viewWillAppear(_ animated: Bool) {
//        self.viewWillAppear(animated)
        self.getOffers()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.noOffersLabel.alpha = 0
        self.tableView.register(UINib(nibName: "DiscoverTableViewCell", bundle: nil), forCellReuseIdentifier: "DiscoverTableViewCell")
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100
        self.tableView.contentInset.top = 30
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func mapSearchPressed(_ sender: Any) {
        let destinationVC = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "NearbyHotelsViewController") as! NearbyHotelsViewController
        destinationVC.offerArray = self.offerArray
        //self.pushViewController(viewController: "NearbyHotelsViewController")
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func getOffers(){
        self.offerArray = []
        self.showActivityIndicator()
        UserHelper.getOffers { (isSuccess, response, errors) in
            if isSuccess && response != nil {
                print("========== ***** =============")
                print(response as Any)
                print("========== ***** =============")
                //print(response![0].dictionaryObject!)
                print("------------------------------")
                print("count : \(response!.count)")
                
                let parsedResponse = response!
                
                for i in 0..<parsedResponse.count{
                    var offer = Offer()
                    var offerData = parsedResponse[i].dictionaryObject!
                    offer.id = offerData["_id"]! as! String
                    offer.hotelName = offerData["hotelName"]! as! String
                    offer.nearestCityDistance = offerData["nearestCityDistance"]! as! String
                    offer.nearestCity = offerData["nearestCity"]! as! String
                    offer.hotelAddress = offerData["hotelAddress"]! as! String
                    offer.contactNumber = offerData["contactNumber"]! as! String
                    offer.hotelWebsite = offerData["hotelWebsite"]! as! String
                    offer.country = offerData["country"]! as! String
                    offer.taxRate = offerData["taxRate"]! as! String
                    offer.currencyCode = offerData["currencyCode"]! as! String
                    offer.hotelId = offerData["hotelId"]! as! String
                    offer.hotelEmail = offerData["hotelEmail"]! as! String
                    offer.isEnable = offerData["isEnable"]! as! Bool
                    offer.closingDate = offerData["closingDate"]! as! String
                    offer.timeZoneTime = offerData["rating"]! as! Double
                    offer.recordDate = offerData["recordDate"]! as! String
                    offer.hotelProfile = offerData["hotelProfile"]! as! String
                    offer.rating = offerData["rating"]! as! Int
                    
                    offer.lon = (offerData["location"]! as! [String: Any])["lon"]! as! Double
                    offer.lat = (offerData["location"]! as! [String: Any])["lat"]! as! Double
                    
                    offer.image4 = (offerData["image"]! as! [String: Any])["image4"]! as! String
                    offer.image3 = (offerData["image"]! as! [String: Any])["image3"]! as! String
                    offer.image2 = (offerData["image"]! as! [String: Any])["image2"]! as! String
                    offer.image1 = (offerData["image"]! as! [String: Any])["image1"]! as! String
                    offer.profilePic = (offerData["image"]! as! [String: Any])["profilePic"]! as! String
                    
                    
                    offer.breakfastIncluded = (offerData["room"]! as! [String: Any])["breakfastIncluded"]! as! Bool
                    offer.guestCountInRoom = (offerData["room"]! as! [String: Any])["guestCountInRoom"]! as! Int
                    offer.normalRoomRate = (offerData["room"]! as! [String: Any])["normalRoomRate"]! as! Double
                    offer.roomSize = (offerData["room"]! as! [String: Any])["roomSize"]! as! Double
                    offer.smokingPolicy = (offerData["room"]! as! [String: Any])["smokingPolicy"]! as! Bool
                    offer.roomSubType = (offerData["room"]! as! [String: Any])["roomSubType"]! as! String
                    offer.roomType = (offerData["room"]! as! [String: Any])["roomType"]! as! String
                    offer.roomAmenities = (offerData["room"]! as! [String: Any])["roomAmenities"]! as! String
                    
                    offer.discount = offerData["discount"]! as! Double
                    offer.todayOfferedRooms = offerData["todayOfferedRooms"]! as! Int
                    offer.todayOfferIndex = offerData["todayOfferIndex"]! as! String
                    
                    self.offerArray.append(offer)
                }
                if (parsedResponse.count == 0){
                    self.tabBarController?.tabBar.items?.first?.badgeValue = .none
                    self.noOffersLabel.alpha = 1    
                } else {
                    
                    self.tableView.reloadData()
                    self.tabBarController?.tabBar.items?.first?.badgeValue = "\(self.offerArray.count)"
                    
                }
                self.hideActivityIndicator()
               
                
            } else if errors != nil {
                self.hideActivityIndicator()
                if errors!.errors.count > 0 {
//                    self.showAlert(message: errors!.errors[0].message)
                }
            }
        }
    }

}


extension DiscoverViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return self.offerArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pushViewControllerTable(index: indexPath.row, viewController: "HotelProfileViewController")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DiscoverTableViewCell", for: indexPath) as! DiscoverTableViewCell
        cell.selectionStyle = .none
        cell.hotelImageView.sd_setImage(with: URL(string: RequestUrls.getBaseUrl()+self.offerArray[indexPath.row].image1)!)
        cell.hotelName.text = self.offerArray[indexPath.row].hotelName
        cell.price.text = "LKR \(self.offerArray[indexPath.row].discount)"
        
        cell.previousPrice.attributedText = getStrikeThoroughText(text: "was LKR \(self.offerArray[indexPath.row].normalRoomRate)")
//        cell.taxDetails.attributedText = getStrikeThoroughText(text: "(Inc. Tax)")
        let address = self.offerArray[indexPath.row].hotelAddress
        let addressDict = self.convertToDictionary(text: address)
        print(addressDict!)
        cell.address.text = "\(addressDict!["Street"]!), \(addressDict!["Address"]!)"
        cell.profile.text = self.offerArray[indexPath.row].hotelProfile
        cell.additoinalInfo.text = ""
        
        return cell
    }
    
    func pushViewControllerTable(index: Int, viewController: String) {
        let destinationVC = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: viewController) as! HotelProfileViewController
        destinationVC.offerIndex = index
        destinationVC.offerArray = self.offerArray
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }

    
}

extension String {
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
}

