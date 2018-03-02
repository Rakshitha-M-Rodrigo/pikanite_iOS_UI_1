//
//  HotelProfileViewController.swift
//  pikanite
//
//  Created by Rakshitha Muranga Rodrigo on 2/4/18.
//  Copyright © 2018 Rakshitha Muranga Rodrigo. All rights reserved.
//

import UIKit
import GoogleMaps

class HotelProfileViewController: BaseViewController, GMSMapViewDelegate, CLLocationManagerDelegate, PromocodeProtocol {
    
    var promoValues: [String:Double]?
    
    func setPromoCode(valueSent: [String : Double]) {
        print("################################")
        print(valueSent as Any)
        print("################################")
        self.loadPromoCodeCalculation(values: valueSent)
        
    }
    
    
    func loadPromoCodeCalculation(values: [String: Double]?){
        if let valueToDisplay = values {
            print("Value from display = \(values as Any)")
            if(values! == [:]){
                self.promoCodeLabel.text = "Add Promo Code"
            } else {
                self.percentage = values!["Percentage"]!
                self.amount = values!["Amount"]!
                print("=================================================> Valid Promocode found ##########")
                if ((self.percentage == 0) && (self.amount > 0)){
                    //cal amount
                    self.totalFinalFee = ((self.offerArray[offerIndex].discount * (100 + Double(self.offerArray[offerIndex].taxRate)!)/100) - amount)
                    if(Double(self.totalFinalFee)>=0){
                        self.totalCostLabel.text = String(self.totalFinalFee)
                    } else {
                        self.totalCostLabel.text = "0"
                    }
                    
                    let promoValue = amount
                    self.promoCodeLabel.text = "( LKR \(promoValue) )"
                    print("===================================== totalFinalFee : amount ============> \(String(describing: self.totalCostLabel.text)) ##########")
                } else if ((self.amount == 0) && (self.percentage > 0)){
                    //cal percentage
                    self.totalFinalFee = ((self.offerArray[offerIndex].discount * (100 + Double(self.offerArray[offerIndex].taxRate)!)/100)  * (100 - percentage))/100
                    self.totalCostLabel.text = String(self.totalFinalFee)
                    let promoValue = ((self.offerArray[offerIndex].discount * (100 + Double(self.offerArray[offerIndex].taxRate)!)/100)  * (percentage))/100
                    self.promoCodeLabel.text = "( LKR \(promoValue) )"
                    print("========================================== totalFinalFee : percentage =======> \(String(describing: self.totalCostLabel.text)) ##########")
                    
                }
                
                
            }
        }
    }
    
    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    @IBOutlet weak var topMenuBar: UIView!
    
    
    //Dynamic Data
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var hotelNameLabel: UILabel!
    @IBOutlet weak var hotelAddressLabel: UILabel!
    @IBOutlet weak var hotelRankLabel: UILabel!
    @IBOutlet weak var checkingTimesLabel: UILabel! // = "Check-In: 14:00        Check-Out: 11:00"
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var needToKNowLabel: UILabel!
    @IBOutlet weak var checkInDateLabel: UILabel!
    @IBOutlet weak var checkOutDateLabel: UILabel!
    @IBOutlet weak var roomTypeLabel: UILabel!
    @IBOutlet weak var taxRate: UILabel!
    @IBOutlet weak var taxRateNameLabel: UILabel!
    @IBOutlet weak var roomCostLabel: UILabel!
    @IBOutlet weak var promoCodeLabel: UILabel!
    @IBOutlet weak var totalCostLabel: UILabel!
    
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userPhoneNumberLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    
    //MARK: Global Variable
    var offerIndex = 0
    var offerArray: [Offer] = []
    let locationManager = CLLocationManager()
    var hotel = HotelProfile()
    var amenitiesImageArray: [UIImage] = []
    var amenitiesArray:[String] = []
    
    var roomCount = 1
    let userEmail = UserDefaults.standard.string(forKey: "userEmail")!
    
    var percentage = 0.0
    var amount = 0.0
    var totalFinalFee = 0.00

    
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.topMenuBar.alpha = 1
        self.appDelegate.password = false
        
        self.locationManager.delegate = self
        self.locationManager.requestAlwaysAuthorization()
        
        self.tableView.register(UINib(nibName: "ReviewsTableViewCell", bundle: nil), forCellReuseIdentifier: "ReviewsTableViewCell")
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 60
        
        self.collectionView.register(UINib(nibName: "AmenitiesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AmenitiesCollectionViewCell")
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout{
            flowLayout.estimatedItemSize = CGSize(width: 80, height: 70)
            
            let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
            swipeLeft.direction = .left
            self.view.addGestureRecognizer(swipeLeft)
            
            let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
            swipeRight.direction = .right
            self.view.addGestureRecognizer(swipeRight)
        }
        
       
        
        let image1 = RequestUrls.getBaseUrl()+self.offerArray[offerIndex].image1
        let image2 = RequestUrls.getBaseUrl()+self.offerArray[offerIndex].image2
        let image3 = RequestUrls.getBaseUrl()+self.offerArray[offerIndex].image3
        let image4 = RequestUrls.getBaseUrl()+self.offerArray[offerIndex].image4
        
        self.mainImageView.sd_setImage(with: URL(string: image1)!)
        
        
        getHotelProfile()
        getMap()
        
//        6.887755, 79.870558
//self.offerArray[offerIndex].lat

    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizerDirection.right {
            print("Swipe Right")
            self.navigationController?.popViewController(animated: true)
        }
        else if gesture.direction == UISwipeGestureRecognizerDirection.left {
            print("Swipe Left")
        }
        else if gesture.direction == UISwipeGestureRecognizerDirection.up {
            print("Swipe Up")
        }
        else if gesture.direction == UISwipeGestureRecognizerDirection.down {
            print("Swipe Down")
        }
    }
    
    func getMap() {
        let lon = self.offerArray[offerIndex].lon
        let lat = self.offerArray[offerIndex].lat
        
        let camera = GMSCameraPosition.camera(withLatitude: Double(lat), longitude: Double(lon), zoom: 15)
        let gMapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        self.mapView.isMyLocationEnabled = true
        self.mapView.animate(to: camera)
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(Double(lat), Double(lon))
        marker.appearAnimation = GMSMarkerAnimation.pop
        marker.title = self.offerArray[offerIndex].hotelName // Marker title here
        marker.snippet = String(self.offerArray[offerIndex].discount)
        marker.infoWindowAnchor = CGPoint(x: 0.5, y: 0)
        marker.icon = self.imageWithImage(image: #imageLiteral(resourceName: "icon_mapMaker"), scaledToSize: CGSize(width: 40.0, height: 40.0))
        marker.map = self.mapView
       
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func mapViewTapped(_ sender: Any) {
        self.pushViewController(viewController: "NearbyHotelsViewController")
    }
    
    @IBAction func userDetailsButtonPressed(_ sender: Any) {
        self.pushViewController(viewController: "ProfileViewController")
    }
    
    @IBAction func birthdayPicker(_ sender: Any) {
        
    }
    
    func getHotelProfile(){
        //self.showActivityIndicator()
//        UserHelper.getHotelProfile(hotelID: self.offerArray[offerIndex].hotelId) { (isSuccess, response, errors) in
//            if isSuccess && response != nil {
////                print("========== ***** =============")
////                print(response as Any)
////                print("========== ***** =============")
////                print(response?.dictionaryObject! as Any)
////                print("------------------------------")
////                print("count : \(response!.count)")
//
//                let jsonData = (response?.dictionaryObject)!
//                print("<><><><><><><><><><><><><><><><>")
//                print("JSON responce \(jsonData)")
//                print("<><><><><><><><><><><><><><><><>")
//                let dataDictionary = jsonData as! [String: Any]
//
//                print("<><><><><><><><><><><><><><><><>")
//                print("JSON responce \(dataDictionary["room"]! as! [String : Any])")
//                print("<><><><><><><><><><><><><><><><>")
//
//                self.hotel.id = dataDictionary["_id"]! as! String
//                self.hotel.amenities = dataDictionary["amenities"]! as! String
//                self.hotel.hotelZipcode = dataDictionary["hotelZipcode"]! as! Int
//                self.hotel.hotelAddress = dataDictionary["hotelAddress"]! as! String
//                self.hotel.nearestCityDistance = dataDictionary["nearestCityDistance"]! as! String
//                self.hotel.nearestCity = dataDictionary["nearestCity"]! as! String
//                self.hotel.country = dataDictionary["country"]! as! String
//                self.hotel.contactNumber = dataDictionary["contactNumber"]! as! String
//                self.hotel.hotelEmail = dataDictionary["hotelEmail"]! as! String
//                self.hotel.hotelWebSite = dataDictionary["hotelWebSite"]! as! String
//                self.hotel.hotelName = dataDictionary["hotelName"]! as! String
//                self.hotel.hotelPartnerId = dataDictionary["hotelPartnerId"]! as! String
////                self.hotel.hotelRoomCount = dataDictionary["hotelRoomCount"]! as! Int
////                self.hotel.multipleEmail = dataDictionary["multipleEmail"]! as! String
//                self.hotel.userCount = dataDictionary["userCount"]! as! Int
//                self.hotel.regDate = dataDictionary["regDate"]! as! String
//                self.hotel.hotelProfile = dataDictionary["hotelProfile"]! as! String
//                self.hotel.rating = dataDictionary["rating"]! as! Int
//                //    self.hotel.hotelLikeAboutInfo: String = ""
////                self.hotel.fact1 = (dataDictionary["hotelLikeAboutInfo"]! as! [String: Any])["fact1"] as! String
////                self.hotel.fact2 = (dataDictionary["hotelLikeAboutInfo"]! as! [String: Any])["fact2"] as! String
////                self.hotel.fact3 = (dataDictionary["hotelLikeAboutInfo"]! as! [String: Any])["fact3"] as! String
//                //    self.hotel.needToKnow: String = ""
//                self.hotel.coupleFriendly = (dataDictionary["needToKnow"]! as! [String: Any])["coupleFriendly"] as! Bool
//                self.hotel.petLimit = (dataDictionary["needToKnow"]! as! [String: Any])["petLimit"] as! Bool
//                self.hotel.cancellationLimit = (dataDictionary["needToKnow"]! as! [String: Any])["cancellationLimit"] as! Bool
//                self.hotel.ageLimit = (dataDictionary["needToKnow"]! as! [String: Any])["ageLimit"] as! String
//                self.hotel.checkOutTimeEnd = (dataDictionary["needToKnow"]! as! [String: Any])["checkOutTimeEnd"] as! String
//                self.hotel.checkOutTimeStart = (dataDictionary["needToKnow"]! as! [String: Any])["checkOutTimeStart"] as! String
//                self.hotel.checkInTimeEnd = (dataDictionary["needToKnow"]! as! [String: Any])["checkInTimeEnd"] as! String
//                self.hotel.checkInTimeStart = (dataDictionary["needToKnow"]! as! [String: Any])["checkInTimeStart"] as! String
//                //    self.hotel.location: String = ""
//                self.hotel.lon = (dataDictionary["location"]! as! [String: Any])["lon"] as! Double
//                self.hotel.lat = (dataDictionary["location"]! as! [String: Any])["lat"] as! Double
//                //    self.hotel.image: String = ""
//                self.hotel.image4 = dataDictionary["_id"]! as! String
//                self.hotel.image3 = dataDictionary["_id"]! as! String
//                self.hotel.image2 = dataDictionary["_id"]! as! String
//                self.hotel.image1 = dataDictionary["_id"]! as! String
//                self.hotel.profilePic = dataDictionary["_id"]! as! String
//
////                if let breakfast : String = (dataDictionary["room"]! as! [String :Any])["breakfastIncluded"] as? String
////                {
////                    self.hotel.breakfastIncluded = breakfast
////                    print("Breakfast included\(self.hotel.breakfastIncluded)")
////                }
//
//
//
//                self.extractAmenities()
//                print(self.hotel as! Any)
//                self.hideActivityIndicator()
//
//
//                //self.loadData()
//                //self.collectionView.reloadData()
//
//
//            } else if errors != nil {
//                self.hideActivityIndicator()
//                if errors!.errors.count > 0 {
//                    //                    self.showAlert(message: errors!.errors[0].message)
//                }
//            }
//
//        }
        
        
       // self.showActivityIndicator()
        UserHelper.getHotelProfileInfo(hotelID: self.offerArray[offerIndex].hotelId) { (isSuccess, response, errors) in
            if isSuccess && response != nil {
                //                print("========== ***** =============")
                //                print(response as Any)
                //                print("========== ***** =============")
                //                print(response?.dictionaryObject! as Any)
                //                print("------------------------------")
                //                print("count : \(response!.count)")
                
                let jsonData = (response?.dictionaryObject)!
                print("<><><><><><><><><><><><><><><><>")
                print("JSON responce \(jsonData)")
                print("<><><><><><><><><><><><><><><><>")
                let data = jsonData as! [String: Any]
                let dataDictionary = jsonData["content"] as! [String: Any]
                
                print("<><><><><><><><><><><><><><><><>")
                print("JSON responce \(dataDictionary)")
                print("<><><><><><><><><><><><><><><><>")
                
                let dataDictionaryOther = (dataDictionary["other"]! as! [String: Any])
                print("Rooms \(dataDictionaryOther)")
                
                let dataDictionaryOffer = (dataDictionary["offer"]! as! [String: Any])
                print("Rooms \(dataDictionaryOffer)")
                
                
                self.hotel.id = dataDictionaryOffer["hotelId"]! as! String
                self.hotel.amenities = dataDictionaryOther ["amenities"] as! String
                //self.hotel.hotelZipcode = dataDictionary["hotelZipcode"]! as! Int
                self.hotel.hotelAddress = dataDictionaryOffer ["hotelAddress"] as! String
                self.hotel.nearestCityDistance = dataDictionaryOffer["nearestCityDistance"] as! String
                self.hotel.nearestCity = dataDictionaryOffer["nearestCity"] as! String
                self.hotel.country = dataDictionaryOffer ["country"] as! String
                self.hotel.contactNumber = dataDictionaryOffer["contactNumber"] as! String
                self.hotel.hotelEmail = dataDictionaryOffer["hotelEmail"]! as! String
                self.hotel.hotelWebSite = dataDictionaryOffer["hotelWebsite"]! as! String
                self.hotel.hotelName = dataDictionaryOffer["hotelName"]! as! String
                
                //self.hotel.hotelPartnerId = dataDictionary["hotelPartnerId"]! as! String
                //                self.hotel.hotelRoomCount = dataDictionary["hotelRoomCount"]! as! Int
                //                self.hotel.multipleEmail = dataDictionary["multipleEmail"]! as! String
                
                
                self.hotel.guestCountInRoom = (dataDictionaryOffer["room"]! as! [String: Any])["guestCountInRoom"] as! Int
                
                //self.hotel.regDate = dataDictionary["regDate"]! as! String
                //self.hotel.hotelProfile = dataDictionary["hotelProfile"]! as! String
                self.hotel.rating = dataDictionaryOffer["rating"]! as! Int
                //    self.hotel.hotelLikeAboutInfo: String = ""
                //                self.hotel.fact1 = (dataDictionary["hotelLikeAboutInfo"]! as! [String: Any])["fact1"] as! String
                //                self.hotel.fact2 = (dataDictionary["hotelLikeAboutInfo"]! as! [String: Any])["fact2"] as! String
                //                self.hotel.fact3 = (dataDictionary["hotelLikeAboutInfo"]! as! [String: Any])["fact3"] as! String
                //    self.hotel.needToKnow: String = ""
                //self.hotel.coupleFriendly = (dataDictionary["needToKnow"]! as! [String: Any])["coupleFriendly"] as! Bool
                //self.hotel.petLimit = (dataDictionary["needToKnow"]! as! [String: Any])["petLimit"] as! Bool
                //self.hotel.cancellationLimit = (dataDictionary["needToKnow"]! as! [String: Any])["cancellationLimit"] as! Bool
                self.hotel.ageLimit = dataDictionaryOther["ageLimit"] as! String
                //self.hotel.checkOutTimeEnd = dataDictionaryOther["checkInTime"] as! String
                
                self.hotel.checkOutTimeStart = dataDictionaryOther["checkInTime"] as! String
                //self.hotel.checkInTimeEnd = (dataDictionary["needToKnow"]! as! [String: Any])["checkInTimeEnd"] as! String
                
                self.hotel.checkInTimeStart = dataDictionaryOther["checkOutTime"] as! String
                
                //    self.hotel.location: String = ""
                self.hotel.lon = (dataDictionaryOffer["location"]! as! [String: Any])["lon"] as! Double
                self.hotel.lat = (dataDictionaryOffer["location"]! as! [String: Any])["lat"] as! Double
                //    self.hotel.image: String = ""
                self.hotel.image4 = dataDictionaryOffer["hotelId"]! as! String
                self.hotel.image3 = dataDictionaryOffer["hotelId"]! as! String
                self.hotel.image2 = dataDictionaryOffer["hotelId"]! as! String
                self.hotel.image1 = dataDictionaryOffer["hotelId"]! as! String
                self.hotel.profilePic = dataDictionaryOffer["hotelId"]! as! String
                
                
                if let breakfast:Bool = (dataDictionaryOffer["room"]! as! [String: Any])["breakfastIncluded"] as! Bool
                {
                    self.hotel.breakfastIncluded = breakfast
                }
                
                if (dataDictionaryOther["hotelRoomCount"]  is NSNull){
                    self.hotel.hotelRoomCount = 0
                } else {
                    if let hotelRoom:Int = dataDictionaryOther["hotelRoomCount"] as? Int
                    {
                        self.hotel.hotelRoomCount = hotelRoom
                    }
                }
                
                
                print("Hotel Room Count \(self.hotel.hotelRoomCount)")
                print("Breakfast included \(self.hotel.breakfastIncluded)")
                
                
                
                
               self.extractAmenities()
                print(self.hotel as! Any)
                //self.hideActivityIndicator()
                
                
                self.loadData()
                self.collectionView.reloadData()
                
                
            } else if errors != nil {
                self.hideActivityIndicator()
                if errors!.errors.count > 0 {
                    //                    self.showAlert(message: errors!.errors[0].message)
                }
            }
            
        }
    }
    
    func loadData(){
        self.hotelNameLabel.text = self.hotel.hotelName
        let address = self.hotel.hotelAddress
        let addressDict = self.convertToDictionary(text: address)
        print(addressDict!)
       
        let hotelNo = "\(addressDict!["No"]!)"
        let hotelStreet = "\(addressDict!["Street"]!)"
        let hotelAddress = "\(addressDict!["Address"]!)"
        let hotelNoTrimmed = hotelNo.trimmingCharacters(in: NSCharacterSet.whitespaces)
        let hotelStreetTrimmed = hotelStreet.trimmingCharacters(in: NSCharacterSet.whitespaces)
        let hotelAddressTrimmed = hotelAddress.trimmingCharacters(in: NSCharacterSet.whitespaces)
        self.hotelAddressLabel.text = "\(hotelNoTrimmed), \(hotelStreetTrimmed), \(hotelAddressTrimmed)"
        self.checkingTimesLabel.text = "Check-In: \(self.getTimeOn_HH_MM_Format(string:(self.hotel.checkInTimeStart)))        Check-Out: \(self.getTimeOn_HH_MM_Format(string:self.hotel.checkOutTimeStart))"
        
        var needToKnow: [String] = []
        
        
        
        //coupleFriendly: false, petLimit: false, cancellationLimit: false, ageLimit: "21+ to Book"
        
        
//        if (self.hotel.coupleFriendly){
//            needToKnow.append("Couple Friendy")
//        } else {
//            needToKnow.append("Non - Couple Friendy")
//        }
//        if (self.hotel.petLimit){
//            needToKnow.append("Pets are allowed")
//        } else {
//            needToKnow.append("Pets are not allowed")
//        }
//        if (self.hotel.cancellationLimit){
//            needToKnow.append("Can be cancelled")
//        } else {
//            needToKnow.append("Can not be cancelled")
//        }
        
        if(self.hotel.breakfastIncluded != nil)
        {
            if(self.hotel.breakfastIncluded)
            {
                needToKnow.append("Breakfast included")
            }
            else
            {
                needToKnow.append("Breakfast not included")
            }
        }
        
        
        
        if (self.hotel.ageLimit == "21+ to Book") {
            needToKnow.append("You have to be 18+ to Book")
        }
        else if (self.hotel.ageLimit  == "18+ to Book") {
            needToKnow.append("You have to be 21+ to Book")
        }
        else if (self.hotel.ageLimit  == "No Age Limit") {
            needToKnow.append("No Age Limit")
        }
        if(self.hotel.guestCountInRoom > 1)
        {
            needToKnow.append("This room can accommodate \(self.hotel.guestCountInRoom) guests")
        }
        else
        {
            needToKnow.append("This room can accommodate \(self.hotel.guestCountInRoom) guest")
        }
        
        if(self.hotel.smokingPolicy != nil)
        {
            if(self.hotel.smokingPolicy)
            {
                needToKnow.append("This is a smoking room")
            }
            else
            {
                needToKnow.append("This is a non-smoking room")
            }
        }

        
        needToKnow.append(self.hotel.extraCharge)
        
        needToKnow.append(self.hotel.nonRefundable)

        if (self.hotel.hotelRoomCount>0)
        {
            needToKnow.append("This property has \(self.hotel.hotelRoomCount) rooms")
        }
        
        
        
        let bullete = self.bulletSymbol
        self.needToKNowLabel.text = "\(bullete) \(needToKnow[0])\n\(bullete) \(needToKnow[1])\n\(bullete) \(needToKnow[2])"
    
        
        
        self.userEmailLabel.text = UserDefaults.standard.string(forKey: "userEmail")
        self.userNameLabel.text = UserDefaults.standard.string(forKey: "UserName")
        self.userPhoneNumberLabel.text = UserDefaults.standard.string(forKey: "userContactNumber")
        self.birthdayLabel.text = UserDefaults.standard.string(forKey: "userBirthDay")
        
        self.roomTypeLabel.text = self.offerArray[offerIndex].roomType
//        self.roomCountLabel.text = "1"
        self.roomCostLabel.text = ("LKR \(String(self.offerArray[offerIndex].discount))")
        self.totalCostLabel.text = "LKR \(String((self.offerArray[offerIndex].discount * (100 + Double(self.offerArray[offerIndex].taxRate)!)/100) ))"
        self.taxRate.text = "LKR \((self.offerArray[offerIndex].discount * (Double(self.offerArray[offerIndex].taxRate)!)/100))"
        self.taxRateNameLabel.text = "Tax (\(self.offerArray[offerIndex].taxRate)%)"
        self.checkInDateLabel.text = self.getShrotDateTime(string: self.offerArray[offerIndex].recordDate)
        self.checkOutDateLabel.text = self.getShrotDateTime(string: self.offerArray[offerIndex].closingDate)
        
    }
    
    func extractAmenities(){
        amenitiesArray = (self.hotel.amenities).components(separatedBy: ",")
        print(amenitiesArray)
        for i in 0..<amenitiesArray.count{
            self.amenitiesImageArray.append(self.getAmenitiesImage(amenityName: amenitiesArray[i]))
        }
    }
    
    //MARK:PromoCode Handler
    @IBAction func promoCodeButtonPressed(_ sender: Any) {
        self.promocodePrompt()
    }
    
    
    

    @IBAction func bookingButtonPressed(_ sender: Any) {
        let facebookLogin = UserDefaults.standard.bool(forKey: "facebookLogin")
        let googleLogin = UserDefaults.standard.bool(forKey: "googleLogin")
        let genericLogin = UserDefaults.standard.bool(forKey: "genericLogin")
//        UserDefaults.standard.set(false, forKey: "joiningAgreement")
//        self.appDelegate.userAgreement = false
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ConfirmationViewController") as! ConfirmationViewController
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.userNameLabel.text = self.userNameLabel.text
        vc.emailLabel.text = self.userEmailLabel.text
        vc.breakfastLabel.text = ""
        
        self.present(vc, animated: true, completion: nil)
        
        if(facebookLogin){
            print("====> facebook ")
            self.bookNow()
        } else if(googleLogin){
            print("====> google ")
            self.bookNow()
        } else if(genericLogin){
            print("====> generic ")
            self.passwordPrompt(userEmail: userEmail, HotelEmail: self.offerArray[offerIndex].hotelEmail, RoomCount: String(self.roomCount), recordedDate: self.offerArray[offerIndex].recordDate)
        }
        
    }
    
    func bookNow(){
        self.showActivityIndicator()
        
        let recordedDate = self.getCurrentDateTime()
        let promoCode = self.appDelegate.promoCode
        UserHelper.bookHotel(userEmail: userEmail, HotelEmail: self.offerArray[offerIndex].hotelEmail, RoomCount: String(self.roomCount), recordedDate: recordedDate, promoCode: promoCode ) { (success, response, errors) in
            if (errors == nil){
                self.hideActivityIndicator()
                print(response as Any)
                let data = response!.dictionaryObject!
                if((data["message"] as! String) == "success"){
                    self.promptBookingStatus()
                } else {
                    self.displayAlertWithOk(title: "Pikanite Says!", alertMessage: "Sorry, couldn't place the booking, please contact us...")
                }
            } else {
                self.displayAlertWithOk(title: "Pikanite Says!", alertMessage: "Some thing went wrong...!")
                self.hideActivityIndicator()
            }
        }
        self.hideActivityIndicator()
    }
}

//MARK: User Reviews

//extension HotelProfileViewController: UITableViewDataSource, UITableViewDelegate{
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("selected \(indexPath.row)")
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 3
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewsTableViewCell", for: indexPath) as! ReviewsTableViewCell
//        cell.selectionStyle = .none
//
//        return cell
//    }
//
//}

extension HotelProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.amenitiesImageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AmenitiesCollectionViewCell", for: indexPath) as! AmenitiesCollectionViewCell
        cell.amenityImage.image = self.amenitiesImageArray[indexPath.row]
        cell.amenityNameLabel.text = self.amenitiesArray[indexPath.row]
        return cell
    }
}


extension HotelProfileViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset.y
        let scrollPercentage = (contentOffset/self.scrollView.bounds.height) * 100
        print(scrollPercentage)
        
        if (scrollPercentage<2){
            UIView.animate(withDuration: 0.3, animations: {
                self.topMenuBar.alpha = 1
            })
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.topMenuBar.alpha = 0
            })
        }
    }
}
