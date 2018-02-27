//
//  AppDelegate.swift
//  pikanite
//
//  Created by Rakshitha Muranga Rodrigo on 1/6/18.
//  Copyright © 2018 Rakshitha Muranga Rodrigo. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import FBSDKLoginKit
import GoogleSignIn
import Google
import Firebase
import GoogleMaps
import GooglePlaces


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    var window: UIWindow?
    var storyboard = UIStoryboard(name: "Main", bundle: nil)
    var logged: Bool = UserDefaults.standard.bool(forKey: "logged")
    var userAgreement: Bool = UserDefaults.standard.bool(forKey: "joiningAgreement")
    var password = false
    var promoCode = "nan"
    //MARK: App Objects
    var userProfile = Profile()
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

//        logged = (UserDefaults.standard.value(forKey: "logged") != nil)
        //AIzaSyDL2poyoc6EeLpVIsTkfSgw45qqItED0bs
        
        //google API-Key
        GMSServices.provideAPIKey("AIzaSyDL2poyoc6EeLpVIsTkfSgw45qqItED0bs")
        GMSPlacesClient.provideAPIKey("AIzaSyDL2poyoc6EeLpVIsTkfSgw45qqItED0bs")
        
        GIDSignIn.sharedInstance().clientID = "610124749144-cujpq9t37na35b801kg77ajushv60vct.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
        
        self.setInitialProfileData()
        
        loginHandler()
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any])
        -> Bool {
            return GIDSignIn.sharedInstance().handle(url,
                                                     sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                     annotation: [:])
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            // Perform any operations on signed in user here.
//            let userId = user.userID                  // For client-side use only!
//            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
//            let givenName = user.profile.givenName
//            let familyName = user.profile.familyName
//            let email = user.profile.email
            
            let fullNameArr = fullName!.components(separatedBy: " ")
            let firstName    = fullNameArr[0]
        
            UserDefaults.standard.set(firstName,forKey: "profileImageURL")
            UserDefaults.standard.set(firstName,forKey: "profileName")
            
        }
    }
    
    func setInitialProfileData(){
        if (UserDefaults.standard.string(forKey: "UserName") != nil ){
            self.userProfile.name = UserDefaults.standard.string(forKey: "UserName")!
        }
        if (UserDefaults.standard.string(forKey: "userEmail") != nil ){
            self.userProfile.email = UserDefaults.standard.string(forKey: "userEmail")!
        }
        if (UserDefaults.standard.string(forKey: "profileImageURL") != nil ){
            self.userProfile.userProfilePic = UserDefaults.standard.string(forKey: "profileImageURL")!
        }
        if (UserDefaults.standard.string(forKey: "userContactNumber") != nil ){
            self.userProfile.contactNumber = UserDefaults.standard.string(forKey: "userContactNumber")!
        }
        if (UserDefaults.standard.string(forKey: "userID") != nil ){
            self.userProfile.id = UserDefaults.standard.string(forKey: "userID")!
        }
        if (UserDefaults.standard.string(forKey: "userBirthDay") != nil ){
            self.userProfile.birthDay = UserDefaults.standard.string(forKey: "userBirthDay")!
        }
        if (UserDefaults.standard.string(forKey: "userSocialLoginID") != nil ){
            self.userProfile.socialLoginId = UserDefaults.standard.string(forKey: "userSocialLoginID")!
        }
        if (UserDefaults.standard.string(forKey: "profileName") != nil ){
            self.userProfile.userFirstName = UserDefaults.standard.string(forKey: "profileName")!
        }
        
        
//        self.userProfile.name = UserDefaults.standard.string(forKey: "UserName")!
//        self.userProfile.email = UserDefaults.standard.string(forKey: "userEmail")!
//        self.userProfile.userProfilePic = UserDefaults.standard.string(forKey: "profileImageURL")!
//        self.userProfile.contactNumber = UserDefaults.standard.string(forKey: "userContactNumber")!
//        self.userProfile.id = UserDefaults.standard.string(forKey: "userID")!
//        self.userProfile.birthDay = UserDefaults.standard.string(forKey: "userBirthDay")!
//        self.userProfile.socialLoginId = UserDefaults.standard.string(forKey: "userSocialLoginID")!
//        self.userProfile.userFirstName = UserDefaults.standard.string(forKey: "profileName")!
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }

    func applicationWillResignActive(_ application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    //For dissmissal of fb web page prompt - checking..
    func applicationDidBecomeActive(_ application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    func loginHandler() {
        if self.isLoggedIn() {
            self.logged = true
            UserDefaults.standard.set(true, forKey: "logged")

//            //TokenUpdateHelper.fetchClientToken()
            let rootViewController = self.storyboard.instantiateViewController(withIdentifier:"MainUINavigationController") as! UINavigationController
            self.window!.rootViewController = rootViewController
            self.window!.makeKeyAndVisible()
        } else {
            self.logged = false
            UserDefaults.standard.set(false, forKey: "logged")
            let rootViewController = self.storyboard.instantiateViewController(withIdentifier:"IntroViewController") as! UIViewController
            self.window!.rootViewController = rootViewController
            self.window!.makeKeyAndVisible()
        }
    }
    
    
    func isLoggedIn() -> Bool {
//        if UserHelper.getToken() != "" && UserHelper.getUserId() != "" {
//            TokenUpdateHelper.fetchClientToken()
//
//            return true
//        }
        return logged
    }
    
    
//    func switchNavigation() {
//
//        if logged {
//
//
//        } else {
//
//            var storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let rootViewController = storyboard.instantiateViewController(withIdentifier:"StartingViewController") as! UIViewController
//            self.window!.rootViewController = rootViewController
//            self.window!.makeKeyAndVisible()
//        }
//    }


}

