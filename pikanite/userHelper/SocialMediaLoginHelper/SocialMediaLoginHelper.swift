//
//  SocialMediaLoginHelper.swift
//  pikanite
//
//  Created by Rakshitha Muranga Rodrigo on 2/15/18.
//  Copyright © 2018 Rakshitha Muranga Rodrigo. All rights reserved.
//

import Foundation
import UIKit
import FacebookLogin
import FacebookCore
import FBSDKLoginKit
import GoogleSignIn


class SocialMediaLoginHelper{
    
    var dict: [String: Any]!
    
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    self.dict = result as! [String : AnyObject]
                    let id = self.dict["id"]!
                    let name = self.dict["name"]!
                    let profilePicURL = (((self.dict["picture"] as! [String: Any])["data"]) as! [String: Any])["url"]!
                    print("####################")
                    print("id : \(id)")
                    print("name: \(name)")
                    print("profilePic: \(profilePicURL)")
                    print("####################")
                }
            })
        }
        
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        print(user.userID)
        print(user.authentication.idToken)
        print(user.profile.name)
        print(user.profile.givenName)
        print(user.profile.familyName)
        print(user.profile.email)
        if user.profile.hasImage
        {
            let pic = user.profile.imageURL(withDimension: 300)
            print(pic!)
        } else {
            //no profile image on google.
        }
    }
    
    
}
