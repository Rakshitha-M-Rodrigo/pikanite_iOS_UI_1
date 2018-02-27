//
//  ProfileViewController.swift
//  pikanite
//
//  Created by Rakshitha Muranga Rodrigo on 2/22/18.
//  Copyright © 2018 Rakshitha Muranga Rodrigo. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userTelePhoneNumberTextField: UITextField!
    @IBOutlet weak var userBirthdayTextField: UITextField!
    @IBOutlet weak var oldPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var passwordChangeGuardView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadProfileInfo()
        
        
        let facebookLogin = UserDefaults.standard.bool(forKey: "facebookLogin")
        let googleLogin = UserDefaults.standard.bool(forKey: "googleLogin")
        let genericLogin = UserDefaults.standard.bool(forKey: "genericLogin")
        
        if(facebookLogin){
            print("====> facebook logout")
            self.passwordChangeGuardView.alpha = 1
        } else if(googleLogin){
            print("====> google logout")
            self.passwordChangeGuardView.alpha = 1
        } else if(genericLogin){
            print("====> generic logout")
            self.passwordChangeGuardView.alpha = 0
        }
    }
    
    func loadProfileInfo(){
        self.userEmailTextField.text = UserDefaults.standard.string(forKey: "userEmail")
        self.userNameTextField.text = UserDefaults.standard.string(forKey: "UserName")
        
        let contact = UserDefaults.standard.string(forKey: "userContactNumber")
        let birthday = UserDefaults.standard.string(forKey: "userBirthDay")
        self.userTelePhoneNumberTextField.text = contact
        self.userBirthdayTextField.text = birthday
    }
    
    
    @IBAction func updataProfileButtonPressed(_ sender: Any) {
        
        let userId = UserDefaults.standard.string(forKey: "userID")
        let userName = self.userNameTextField.text!
        let userContactNo = self.userTelePhoneNumberTextField.text!
        let uesrBirthday = self.userBirthdayTextField.text!
        
        self.showActivityIndicator()
        UserHelper.updateUserProfile(userID: userId!, birthDay: uesrBirthday, name: userName, contactNumber: userContactNo) { (success, response, errors) in
            if(errors == nil){
                print(response!)
                let jsonData = response!.dictionaryObject!
                if ((jsonData["message"]! as! String) == "success"){
                    self.displayAlertWithOk(title: "Pikanite Says!", alertMessage: "Your profile has been updated successfully..!")
                    let content = jsonData["content"]! as! [String : Any]
                    
                    let userName = content["name"] as! String!
                    let userEmail = content["email"] as! String!
                    let userProfilePic = content["userProfilePic"] as! String!
                    let userContactNumber = content["contactNumber"] as! String!
                    let userID = content["_id"] as! String!
                    let userBirthDay = content["birthDay"] as! String!
                    let userSocialLoginID = content["socialLoginId"] as! String!
                    
                    self.addUserData(userName: userName!, userEmail: userEmail!, userProfilePic: userProfilePic!, userContactNumber: userContactNumber!, userID: userID!, userBirthDay: userBirthDay!, userSocialLoginID: userSocialLoginID!)
                    self.loadProfileInfo()
                } else {
                    self.displayAlertWithOk(title: "Pikanite Says!", alertMessage: "Sorry, we could not update the profile., please try again shortly..!")
                }
                self.hideActivityIndicator()
            } else {
                self.hideActivityIndicator()
                self.displayAlertWithOk(title: "Oops !", alertMessage: "Pikanite says, some thing went wrong, please contact us...")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func updatePasswordButtonPressed(_ sender: Any) {
        
        let oldPassword = self.oldPasswordTextField.text
        let newPassword = self.newPasswordTextField.text
        
        let email = UserDefaults.standard.string(forKey: "userEmail")
        
        if (oldPassword == "" && newPassword == ""){
            self.displayAlertWithOk(title: "Pikanite Says!", alertMessage: "Please fill the required fields, before procceed to change...")
        } else {
            self.showActivityIndicator()
            UserHelper.updateUserPassword(userEmail: email!, oldPassword: oldPassword!, newPassword: newPassword!, completion: { (success, response, errors) in
                if (errors == nil){
                    print(response!)
                    let jsonData = response!.dictionaryObject!
                    let message = jsonData["message"] as! String!
                    if(message == "success"){
                        self.displayAlertWithOk(title: "Pikanite Says!", alertMessage: "Password updated successfully, please make sure to use new password!")
                    } else {
                        self.displayAlertWithOk(title: "Pikanite Says!", alertMessage: "Please Enter the correct your password...")
                    }
                    self.hideActivityIndicator()
                } else {
                    self.hideActivityIndicator()
                    self.displayAlertWithOk(title: "Oops !", alertMessage: "Pikanite says, some thing went wrong, please contact us...")
                }
            })
        }
        
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
