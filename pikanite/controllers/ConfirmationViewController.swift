//
//  ConfirmationViewController.swift
//  pikanite
//
//  Created by Rakshitha Muranga Rodrigo on 3/2/18.
//  Copyright © 2018 Rakshitha Muranga Rodrigo. All rights reserved.
//

import UIKit

class ConfirmationViewController: BaseViewController {

    //MARK: Outlets
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var breakfastLabel: UILabel!
    @IBOutlet weak var roomTypeLabel: UILabel!
    @IBOutlet weak var checkInLabel: UILabel!
    @IBOutlet weak var checkOutLabel: UILabel!
    @IBOutlet weak var roomPriceLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var paymentMethodLabel: UILabel!
    @IBOutlet weak var taxNameLabel: UILabel!
    
    var userName: String = ""
    var email: String = ""
    var breakfast: String = ""
    var roomType: String = ""
    var checkIn: String = ""
    var checkOut: String = ""
    var roomPrice: String = ""
    var tax: String = ""
    var total: String = ""
    var paymentMethod: String = ""
    var taxName: String = ""
    var roomCount: String = "1"
    var recordedDate: String = ""
    var promoCodeText: String = ""
    var hotelEmail: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userNameLabel.text = self.userName
        self.emailLabel.text = self.email
        self.breakfastLabel.text = self.breakfast
        self.roomTypeLabel.text = self.roomType
        self.checkInLabel.text = self.checkIn
        self.checkOutLabel.text = self.checkOut
        self.roomPriceLabel.text = self.roomPrice
        self.taxLabel.text = self.tax
        self.totalLabel.text = self.total
//        self.paymentMethodLabel.text = self.paymentMethod
        self.taxNameLabel.text = self.taxName
        
    }
    
    func bookNow(userEmail: String, HotelEmail: String, RoomCount: String, recordedDate: String, promoCode: String){
        self.showActivityIndicator()
        
        let recordedDate = self.getCurrentDateTime()
        let promoCode = self.appDelegate.promoCode
        UserHelper.bookHotel(userEmail: userEmail, HotelEmail: HotelEmail, RoomCount: RoomCount, recordedDate: recordedDate, promoCode: promoCode ) { (success, response, errors) in
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
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirmButtonPressed(_ sender: Any) {
        print("================> confirm button pressed !")
        self.bookNow(userEmail: self.email, HotelEmail: self.hotelEmail, RoomCount: self.roomCount, recordedDate: self.recordedDate, promoCode: self.promoCodeText)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
