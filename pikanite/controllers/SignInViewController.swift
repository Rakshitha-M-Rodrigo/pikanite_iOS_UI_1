//
//  SignInViewController.swift
//  pikanite
//
//  Created by Rakshitha Muranga Rodrigo on 2/7/18.
//  Copyright © 2018 Rakshitha Muranga Rodrigo. All rights reserved.
//

import UIKit

class SignInViewController: BaseViewController {
    
    //MARK: Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        UserDefaults.standard.set("test@pikanite.com", forKey: "email")
        UserDefaults.standard.set("1234", forKey: "password")

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func BackButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func signInButtonPressed(_ sender: Any) {
        
        let email = self.emailTextField.text
        let password = self.passwordTextField.text
        
        if ( self.emailTextField.text != "" && self.passwordTextField.text != ""){
            self.checkUser(email: email!)
        } else {
            self.displayAlertWithOk(title: "Pikanite Alert!", alertMessage: "Please fill the all infomations...")
        }
    }
    
    func checkUser(email: String){
        self.showActivityIndicator()
        UserHelper.checkUser(email: email) { (success, resposnse, errors) in
            if (errors == nil){
                let status = (resposnse!.dictionaryObject)!["message"]! as! String
                
                if (status == "failed"){
                    print("===> user does not exist")
                    self.hideActivityIndicator()
                    self.displayAlertWithOk(title: "Oops!", alertMessage: "Pikanite Says!, You are not registered before pikanite, use SigUP or your Social LogIn.")
                } else if (status == "success"){
                    let content = (resposnse!.dictionaryObject)!["content"]! as! [String: Any]
                    print("===> user exist")
                    print(content["name"] as! String)
                    
                    let name = content["name"] as! String
                    let userEmail = content["email"] as! String
                    let userProfilePic = content["userProfilePic"] as! String
                    let contactNumber = content["contactNumber"] as! String
                    let id = content["_id"] as! String
                    let birthDay = content["birthDay"] as! String
                    let socialID = content["socialLoginId"] as! String
                    
                    self.addUserData(userName: name, userEmail: userEmail, userProfilePic: userProfilePic, userContactNumber: contactNumber, userID: id, userBirthDay: birthDay, userSocialLoginID: socialID)
                   
                    
                    if((content["userType"]! as! String) == "standard"){
                        UserHelper.loginUser(email: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (isSuccess, response, errors) in
                            if(errors == nil){
                                print(response!.dictionaryObject!)
                                let result = response!.dictionaryObject!
                                let userStatus = result["message"]! as! String
                                if (userStatus == "success"){
                                    UserDefaults.standard.set(true, forKey: "genericLogin")
                                    UserDefaults.standard.set(true, forKey: "logged")
                                    self.appDelegate.logged = true
                                    self.appDelegate.loginHandler()
                                    self.hideActivityIndicator()
                                } else {
                                    self.hideActivityIndicator()
                                    self.displayAlertWithOk(title: "Pikanite Says!", alertMessage: "Wrong logging combination, if you have forgotten your password, please follow the forget password steps to get access!")
                                }
                            } else {
                                self.hideActivityIndicator()
                                self.displayAlertWithOk(title: "Opps!", alertMessage: "Pikanite Says!, Some thing went wrong!")
                            }
                        })
                    } else if ((content["userType"]! as! String) == "facebook"){
                        self.hideActivityIndicator()
                        self.displayAlertWithOk(title: "Opps!", alertMessage: "You are previously signUP with facebook logging combinations, please use facebook signIn!")
                    } else if ((content["userType"]! as! String) == "google"){
                        self.hideActivityIndicator()
                        self.displayAlertWithOk(title: "Pikanite Says!", alertMessage: "You are previously signUP with google logging combinations, please use google signIn!")
                    }
                    
                }
            } else {
                self.hideActivityIndicator()
                self.displayAlertWithOk(title: "Opps!", alertMessage: "Pikanite Says!, Some thing went wrong!")
            }
        }
    }

}
