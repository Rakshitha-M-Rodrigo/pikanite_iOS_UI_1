//
//  BookingsViewController.swift
//  pikanite
//
//  Created by Rakshitha Muranga Rodrigo on 1/23/18.
//  Copyright © 2018 Rakshitha Muranga Rodrigo. All rights reserved.
//

import UIKit

class BookingsViewController: BaseViewController {
    
    //MARK: Outlets
    @IBOutlet weak var pastBookingTableView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollContainerView: UIView!
    @IBOutlet weak var currentLabel: UILabel!
    @IBOutlet weak var pastLabel: UILabel!
    @IBOutlet weak var underLineView: UIView!
    @IBOutlet weak var currentLabelContainerView: UIView!
    @IBOutlet weak var pastLabelContainerView: UILabel!
    @IBOutlet weak var currentBookingTableView: UITableView!
    
    @IBOutlet weak var noCurrentBookingView: UIView!
    @IBOutlet weak var noPastBookingView: UIView!
//    @IBOutlet weak var noPastBookingView: UIView!
    
    var pastBookings:[BookingNew] = []
    var currentBookings:[BookingNew] = []
    var serverCurrentTime = ""
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        DispatchQueue.main.async {
             self.loadAllBookingsInfo()
        }
       
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.noCurrentBookingView.alpha = 0
        self.noPastBookingView.alpha = 0
        self.pastBookingTableView.register(UINib(nibName: "PastBookingTableViewCell", bundle: nil), forCellReuseIdentifier: "PastBookingTableViewCell")
        self.pastBookingTableView.rowHeight = UITableViewAutomaticDimension
        self.pastBookingTableView.estimatedRowHeight = 180
        
        
        //currentBookings
        self.currentBookingTableView.register(UINib(nibName: "CurrentBookingTableViewCell", bundle: nil), forCellReuseIdentifier: "CurrentBookingTableViewCell")
        self.currentBookingTableView.rowHeight = UITableViewAutomaticDimension
        self.currentBookingTableView.estimatedRowHeight = 500
        
        //Tabcontroll
        self.underLineView.center.x = self.currentLabelContainerView.center.x
        self.currentLabel.textColor = UIColor(red: 21/255, green: 172/255, blue: 162/255, alpha: 1)
        self.pastLabel.textColor = UIColor(red: 118/255, green: 151/255, blue: 162/255, alpha: 1)

    }
    
    func loadAllBookingsInfo(){
        self.showActivityIndicator()
        UserHelper.getbookings(userID: UserDefaults.standard.string(forKey: "userID")!) { (success, response, errors) in
            
            if(response != nil && errors == nil){
            
            self.pastBookings = []
            self.currentBookings = []
            
            print(response!.dictionaryObject!)
            let dataJson = response!.dictionaryObject!
            
            
            
            if ((dataJson["message"]! as! String) == "success"){
                let bookingData = dataJson["booking"]! as! Array<Any>
                DispatchQueue.main.async {
                 
                for i in 0..<bookingData.count{
                    var newBookingData = BookingNew()
                    let data = bookingData[i] as! [String:Any]
                    newBookingData.hotelName = data["hotelName"]! as! String
                    newBookingData.currencyCode = data["currencyCode"]! as! String
                    newBookingData.bookingId = data["bookingId"]! as! String
                    newBookingData.profilePic = data["profilePic"]! as! String
                    newBookingData.hotelAddress = data["hotelAddress"]! as! String
                    newBookingData.currentRoomType = data["currentRoomType"]! as! String
                    newBookingData.lat = data["lat"]! as! Double
                    newBookingData.lon = data["lon"]! as! Double
                    newBookingData.price = data["price"]! as! Double
                    newBookingData.recordedDate = data["recordedDate"]! as! String
                    newBookingData.bookedCheckinTime = data["bookedCheckinTime"]! as! String
                    newBookingData.bookedCheckoutTime = data["bookedCheckoutTime"]! as! String
                    
                    let currentTime = self.getCurrentDateTime()
                    let recordDate = self.dateFromISOString(string: (data["recordedDate"]! as! String))
                    let recordDateString = (data["recordedDate"]! as! String)
                    let checkOutTime = (data["bookedCheckoutTime"]! as! String)
                    let checkOutTimeDict = self.getTimeOn_HH_MM_Array(string:checkOutTime)
                    let checkInTime = data["bookedCheckinTime"]! as! String
                    let checkInTimeDict = self.getTimeOn_HH_MM_Array(string:checkInTime)
                    let recTime = self.extractTimefromDateString(string: recordDateString)
                    let recTimeDict = self.getTimeOn_HH_MM_Array(string: recTime)
                    

                    var current = false
                    
                    //recordededDate -> <convert to local time> -> take only the date part -> day 1 +append 12:00 -> then check current local time -> if before the currentTime past : else current
                    print((data["recordedDate"]! as! String))
                    print(self.getBookingValidatoroDate(string: self.convertNextDate(dateString:(data["recordedDate"]! as! String))))
                    let validatorTime = self.getBookingValidatoroDate(string: self.convertNextDate(dateString:(data["recordedDate"]! as! String)))
                    
                    
                    let validationTime_DateFormatted = self.dateFromISOString(string: validatorTime)
                    
                    UserHelper.getServerCurrentTime { (success, response, errors) in
                        if(errors == nil){
                            print(response!)
                            self.serverCurrentTime = (response!.dictionaryObject!)["content"] as! String!
                            print(self.serverCurrentTime)
                            
                            
                            let currentServerTime_DateFormatted = self.dateFromISOString(string: self.serverCurrentTime)
                            print("######################################")
                            print(validationTime_DateFormatted)
                            print(currentServerTime_DateFormatted)
                            print("######################################")
                            
                            if (validationTime_DateFormatted! > currentServerTime_DateFormatted!){
                                print("#########=====> current offer")
                                current = true
                                newBookingData.checkoutDate = validatorTime
                                self.currentBookings.append(newBookingData)
                                print(self.currentBookings.count)
                                print(self.pastBookings.count)
                                self.currentBookingTableView.reloadData()
                                self.pastBookingTableView.reloadData()
                                self.hideActivityIndicator()
                            } else {
                                print("#########=====> past offer")
                                current = false
                                newBookingData.checkoutDate = (data["recordedDate"]! as! String)
                                self.pastBookings.append(newBookingData)
                                print(self.currentBookings.count)
                                print(self.pastBookings.count)
                                self.currentBookingTableView.reloadData()
                                self.pastBookingTableView.reloadData()
                                self.hideActivityIndicator()
                            }
                            
                            
                            
                            
                        } else {
                            self.hideActivityIndicator()
                            self.displayAlertWithOk(title: "Opps!", alertMessage: "Pikanite Says!, Communication to the server error..., please retry again, and if this is occuring simultinously pleased to contact admins...")
                        }
                    }
                    
                } }
                
               
                
                
            } else {
                self.hideActivityIndicator()
                self.displayAlertWithOk(title: "Oops!", alertMessage: "Pikanite says!, server connection error, contact admin...")
            }

            } else {
                 self.displayAlertWithOk(title: "Oops!", alertMessage: "Pikanite says!, server connection error, contact admin...")
            }
        }
    }

    func loadBookingInfo(){
        self.showActivityIndicator()
        UserHelper.getbookings(userID: self.appDelegate.userProfile.id) { (success, response, errors) in
            if(errors == nil){
                self.hideActivityIndicator()
                print(response as Any)
            } else {
                self.hideActivityIndicator()
                self.displayAlertWithOk(title: "Oops!", alertMessage: "Pikanite says!, some thing went wrong!")
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func exploreButtonPressed(_ sender: Any) {
        self.tabBarController?.selectedIndex = 0
        //self.appDelegate.loginHandler()
    }
    
    @IBAction func exploreButtonPressedPastBooking(_ sender: Any) {
        self.tabBarController?.selectedIndex = 0
    }
}

extension BookingsViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        ////var cell: UITableViewCell!
        var cellValue = UITableViewCell()
        if tableView == pastBookingTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PastBookingTableViewCell", for: indexPath) as! PastBookingTableViewCell
            
            cell.hotelName.text = self.pastBookings[indexPath.row].hotelName
            cell.dateLabel.text = "Date : \(self.getShrotDateTimeWithYear(string:self.pastBookings[indexPath.row].recordedDate))"
            cell.timeLabel.text = "Time : \(self.getTimeOn_HH_MM_Format(string: self.pastBookings[indexPath.row].bookedCheckinTime))"
            cell.priceLabel.text = "Price : LKR \(String(self.pastBookings[indexPath.row].price))"
            cell.hotelImageView.sd_setImage(with: URL(string: "\(RequestUrls.getBaseUrl()+self.pastBookings[indexPath.row].profilePic)"))
            cell.selectionStyle = .none
            cell.url = RequestUrls.getBaseUrl()+self.pastBookings[indexPath.row].profilePic
            //return cell
            cellValue = cell
            
        }
        if tableView == currentBookingTableView {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CurrentBookingTableViewCell", for: indexPath) as! CurrentBookingTableViewCell
            
            //cell.imageView?.sd_setImage(with: URL(string:(RequestUrls.getBaseUrl()+self.currentBookings[indexPath.row].profilePic)))
            cell.url = (RequestUrls.getBaseUrl()+self.currentBookings[indexPath.row].profilePic)
            cell.hotelNameLabel.text = self.currentBookings[indexPath.row].hotelName
            let addressDict = self.convertToDictionary(text: self.currentBookings[indexPath.row].hotelAddress)
            print(addressDict!)
            //cell.address.text = "\(addressDict!["Street"]!), \(addressDict!["Address"]!)"
            cell.hotelAddressLabel.text = "\(addressDict!["No"]!), \(addressDict!["Street"]!), \(addressDict!["Address"]!)"
            cell.checkInDate.text = self.getShrotDateTimeWithYear(string:(self.currentBookings[indexPath.row].recordedDate))
            cell.checkOutDate.text = self.getShrotDateTimeWithYear(string:(self.currentBookings[indexPath.row].checkoutDate))
            cell.checkInTime.text = self.getTimeOn_HH_MM_Format(string:(self.currentBookings[indexPath.row].bookedCheckinTime))
            cell.checkOutTime.text = self.getTimeOn_HH_MM_Format(string:(self.currentBookings[indexPath.row].bookedCheckoutTime))
            cell.roomTypeLabel.text = self.currentBookings[indexPath.row].currentRoomType
            cell.costLabel.text = "LKR \(self.currentBookings[indexPath.row].price)"
            cell.lat = self.currentBookings[indexPath.row].lat
            cell.lon = self.currentBookings[indexPath.row].lon
            
            cell.selectionStyle = .none
            //return cell
            cellValue = cell
        }
        //cell.selectionStyle = .none
        return cellValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        if tableView == pastBookingTableView {
            count = self.pastBookings.count
            if (count == 0 ){
                self.noPastBookingView.alpha = 1
            } else {
               self.noPastBookingView.alpha = 0
            }
        }
        if tableView == currentBookingTableView {
            count = self.currentBookings.count
            if (count == 0){
                self.noCurrentBookingView.alpha = 1
            } else {
                self.noCurrentBookingView.alpha = 0
            }
        }
        return count
    }
}


extension BookingsViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset
        let scrollPercentage = (contentOffset.x/self.scrollView.bounds.width) * 100
        print(scrollPercentage)
        
        if(scrollPercentage>=0 && scrollPercentage<50){
            print("current bookings....")
        
//                self.underLineView.center.x = self.currentLabelContainerView.center.x
                self.currentLabel.textColor = UIColor(red: 21/255, green: 172/255, blue: 162/255, alpha: 1)
                self.pastLabel.textColor = UIColor(red: 118/255, green: 151/255, blue: 162/255, alpha: 1)

        }
        if(scrollPercentage>=50 && scrollPercentage<=100){
            print("past bookings....")
//                self.underLineView.center.x = self.pastLabelContainerView.center.x
                self.currentLabel.textColor = UIColor(red: 118/255, green: 151/255, blue: 162/255, alpha: 1)
                self.pastLabel.textColor = UIColor(red: 21/255, green: 172/255, blue: 162/255, alpha: 1)
  
        }
        if(0<scrollPercentage && scrollPercentage<100){
            self.underLineView.center.x = (self.view.frame.width/4) + ((self.view.frame.width/200.00) * scrollPercentage)
        }
        
    }
}
