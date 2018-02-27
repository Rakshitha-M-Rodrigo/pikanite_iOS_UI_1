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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.loadAllBookingsInfo()
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
        
        //self.loadBookingInfo()
        

    }
    
    func loadAllBookingsInfo(){
        self.showActivityIndicator()
        UserHelper.getbookings(userID: UserDefaults.standard.string(forKey: "userID")!) { (success, response, errors) in
            
            self.pastBookings = []
            self.currentBookings = []
            
            print(response!.dictionaryObject!)
            let dataJson = response!.dictionaryObject!
            
            self.hideActivityIndicator()
            if ((dataJson["message"]! as! String) == "success"){
                let bookingData = dataJson["booking"]! as! Array<Any>
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
                    
                    let date = newBookingData.recordedDate
                    let date_formatted = self.dateFromISOString(string: date)
                    let formatter = DateFormatter()
                    formatter.dateStyle = .full
                    formatter.timeStyle = .long
                    let result = formatter.string(from: date_formatted!)
                    print("=====> \(result)")
                    
                    let current = true
                    
                    let newDate = self.dateFromISOString(string: date)!
                    print(String(describing: newDate))
                    if(current){
                        self.currentBookings.append(newBookingData)
                    } else {
                        self.pastBookings.append(newBookingData)
                    }
                }
                
                print(self.currentBookings.count)
                print(self.pastBookings.count)
                self.currentBookingTableView.reloadData()
                self.pastBookingTableView.reloadData()
                self.hideActivityIndicator()
            } else {
                self.hideActivityIndicator()
               // self.displayAlertWithOk(title: "Oops!", alertMessage: "Pikanite says!, server connection error, contact admin...")
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
            cell.dateLabel.text = self.pastBookings[indexPath.row].recordedDate
            cell.timeLabel.text = self.pastBookings[indexPath.row].bookedCheckinTime
            cell.priceLabel.text = String(self.pastBookings[indexPath.row].price)
            cell.hotelImageView.sd_setImage(with: URL(string: "\(RequestUrls.getBaseUrl()+self.pastBookings[indexPath.row].profilePic)"))
            cell.selectionStyle = .none
            cell.url = RequestUrls.getBaseUrl()+self.pastBookings[indexPath.row].profilePic
            //return cell
            cellValue = cell
            
        }
        if tableView == currentBookingTableView {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CurrentBookingTableViewCell", for: indexPath) as! CurrentBookingTableViewCell
            
//            cell.imageView?.sd_setImage(with: URL(string:(RequestUrls.getBaseUrl()+self.currentBookings[indexPath.row].profilePic)))
            cell.url = (RequestUrls.getBaseUrl()+self.currentBookings[indexPath.row].profilePic)
            cell.hotelNameLabel.text = self.currentBookings[indexPath.row].hotelName
            let addressDict = self.convertToDictionary(text: self.currentBookings[indexPath.row].hotelAddress)
            print(addressDict!)
            //cell.address.text = "\(addressDict!["Street"]!), \(addressDict!["Address"]!)"
            cell.hotelAddressLabel.text = "\(addressDict!["Street"]!), \(addressDict!["Address"]!)"
            cell.checkInDate.text = self.currentBookings[indexPath.row].recordedDate
            cell.checkOutDate.text = self.currentBookings[indexPath.row].recordedDate
            cell.checkInTime.text = self.currentBookings[indexPath.row].bookedCheckinTime
            cell.checkOutTime.text = self.currentBookings[indexPath.row].bookedCheckoutTime
            cell.roomTypeLabel.text = self.currentBookings[indexPath.row].currentRoomType
            cell.costLabel.text = "LKR \(self.currentBookings[indexPath.row].price)"
            cell.lat = 0.00000
            cell.lon = 0.00000
            
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
            count = 0 //self.currentBookings.count
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
