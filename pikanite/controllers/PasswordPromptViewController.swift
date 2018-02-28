//
//  PasswordPromptViewController.swift
//  pikanite
//
//  Created by Rakshitha Muranga Rodrigo on 2/18/18.
//  Copyright © 2018 Rakshitha Muranga Rodrigo. All rights reserved.
//

import UIKit

class PasswordPromptViewController: BaseViewController {

    var userEmail = ""
    var hotelEmail = ""
    var roomCount = ""
    var recordedDate = ""
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.appDelegate.password = false

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func confirmBookingButtonPressed(_ sender: Any) {
        if (self.passwordTextField.text != ""){
            self.showActivityIndicator()
            UserHelper.loginUser(email: self.appDelegate.userProfile.email, password: self.passwordTextField.text!) { (success, response, errors) in
                if(errors == nil){
                    print(response!.dictionaryObject!)
                    let result = response!.dictionaryObject!
                    let userStatus = result["message"]! as! String
                    if (userStatus == "success"){
                        self.hideActivityIndicator()
                        self.appDelegate.password = true
                        let promoCode = self.appDelegate.promoCode
                        let recordedDate = self.getCurrentDateTime()
//                        self.dismiss(animated: true, completion: nil)
                        self.bookHotelNow(userEmail: self.userEmail, HotelEmail: self.hotelEmail, RoomCount: self.roomCount, PromoCode: promoCode)
                        
                    } else {
                        self.hideActivityIndicator()
                        self.displayAlertWithOk(title: "Pikanite Says!", alertMessage: "Wrong password ! Please try again...")
                    }
                    
                }
            }
        } else {
            self.displayAlertWithOk(title: "Pikanite Says!", alertMessage: "Please enter your password to procceed!")
        }
        
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
