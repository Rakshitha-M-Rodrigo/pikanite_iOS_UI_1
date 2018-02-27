//
//  LoginViewController.swift
//  pikanite
//
//  Created by Rakshitha Muranga Rodrigo on 1/11/18.
//  Copyright © 2018 Rakshitha Muranga Rodrigo. All rights reserved.
//

import UIKit
import Foundation
import FacebookLogin
import FacebookCore
import FBSDKLoginKit
import GoogleSignIn


class LoginViewController: BaseViewController  {

    //MARK: Outlets
    @IBOutlet weak var signInButtonView: UIView!
    @IBOutlet weak var mainContainer: UIView!
    @IBOutlet weak var pikaniteLogoImageView: UIImageView!
    @IBOutlet weak var signInFacebookButtonView: UIView!
    @IBOutlet weak var signInGoogleButtonView: UIView!
    @IBOutlet weak var orSeparatorView: UIView!
    @IBOutlet weak var standardSignInButtonView: UIView!
    @IBOutlet weak var createAccountView: UIView!
    
    
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var googleButton: GIDSignInButton!
    
    //MARK: Variables
    var dict: [String: Any]!
    
    let loginButton = LoginButton(readPermissions: [ .publicProfile ])
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("loading...")
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        
        self.mainContainer.alpha = 1
        self.pikaniteLogoImageView.alpha = 0
        self.signInFacebookButtonView.alpha = 0
        self.signInGoogleButtonView.alpha = 0
        self.orSeparatorView.alpha = 0
        self.standardSignInButtonView.alpha = 0
        self.createAccountView.alpha = 0

        self.signInButtonView.layer.borderColor = UIColor.white.cgColor
        self.signInButtonView.layer.borderWidth = 2
        
        UIView.animate(withDuration: 1, delay: 0.3, options: .curveEaseInOut, animations: {
            self.pikaniteLogoImageView.alpha = 1
        }, completion: nil)
        
        UIView.animate(withDuration: 0.3, delay: 1.3, options: .curveEaseInOut, animations: {
            self.signInFacebookButtonView.alpha = 1
        }, completion: nil)
        
        UIView.animate(withDuration: 0.3, delay: 1.6, options: .curveEaseInOut, animations: {
            self.signInGoogleButtonView.alpha = 1
        }, completion: nil)
        
        UIView.animate(withDuration: 0.3, delay: 1.8, options: .curveEaseInOut, animations: {
            self.orSeparatorView.alpha = 1
        }, completion: nil)
        
        UIView.animate(withDuration: 0.3, delay: 2, options: .curveEaseInOut, animations: {
            self.standardSignInButtonView.alpha = 1
        }, completion: nil)
        
        UIView.animate(withDuration: 0.3, delay: 2.2, options: .curveEaseInOut, animations: {
            self.createAccountView.alpha = 1
        }, completion: nil)
    }
    
    
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    UserDefaults.standard.set(true, forKey: "logged")
                    self.appDelegate.logged = true
                    self.appDelegate.loginHandler()
                    UserDefaults.standard.set(true, forKey: "facebookLogin")
                    
                    self.dict = result as! [String : AnyObject]
                    let id = self.dict["id"]! as! String
                    let name: String = self.dict["name"]! as! String
                    let email: String = self.dict["email"] as! String
                    let profilePicURL = (((self.dict["picture"] as! [String: Any])["data"]) as! [String: Any])["url"]!
                    print("####################")
                    print("id : \(id)")
                    print("name: \(name)")
                    print("profilePic: \(profilePicURL)")
                    print("####################")
                    
                    let fullNameArr = name.components(separatedBy: " ")
                    let firstName    = fullNameArr[0]
                    
                    UserDefaults.standard.set(profilePicURL,forKey: "profileImageURL")
                    UserDefaults.standard.set(firstName,forKey: "profileName")
                    UserDefaults.standard.set(name,forKey: "UserName")
                    UserDefaults.standard.set(email,forKey: "userEmail")
                    
                    //self.checkUser(email: email)
                    if(self.checkFbUserEmail(email: email)){
                        self.registerNewSocialMediaUser(name: name, email: email, socialLoginId: id, userType: "facebook")
                    }
                    
                    
                }
            })
        }
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func FaceBookSignInButtonPressed(_ sender: Any) {
        print("####### facebook pressed ######")
        if (self.appDelegate.userAgreement){
            loginButtonClicked()
        } else {
            self.promptJoiningAgreement(logginType: "facebook")
            //loginButtonClicked()
        }
        
    }
    
    @objc func loginButtonClicked() {
        self.loginManager.logIn(readPermissions: [ .publicProfile, .email ], viewController: self) { (loginResult) in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                self.getFBUserData()
                UserDefaults.standard.set(true, forKey: "facebookLogin")
            }
        }
    }
    
    
    
    @IBAction func GoogleSignInButtonPressed(_ sender: Any) {
        print("####### google pressed ######")
        if (self.appDelegate.userAgreement){
            GIDSignIn.sharedInstance().signIn()
        } else {
            self.promptJoiningAgreement(logginType: "google")
            //GIDSignIn.sharedInstance().signIn()
        }
        
    }
    
    func googleLogginButtonClicked(){
        GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction func ManualSignInButtonPressed(_ sender: Any) {
        
        self.pushViewController(viewController: "SignInViewController")
    }
    
    @IBAction func SignUpButtonPressed(_ sender: Any) {
        self.pushViewController(viewController: "SignUpViewController")
        
    }
    
    func checkFbUserEmail(email: String) -> Bool{
        UserHelper.checkUser(email: email) { (success, resposnse, errors) in
            if (errors == nil){
                let status = (resposnse!.dictionaryObject)!["message"]! as! String
                
                if (status == "failed"){
                    print("===> user does not exist")
                    self.register = true
                } else if (status == "success"){
                    self.register = false
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
                    UserDefaults.standard.set(true, forKey: "logged")
                    self.appDelegate.logged = true
                    self.dismiss(animated: true, completion: nil)
                    self.appDelegate.loginHandler()
                }
            }
        }
       return self.register
    }
    
}
