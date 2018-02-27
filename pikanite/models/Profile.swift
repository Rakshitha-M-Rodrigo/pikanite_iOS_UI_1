//
//  Profile.swift
//  tabbarconverted
//
//  Created by Dinushanka Nayomal on 11/21/17.
//  Copyright © 2017 Sachithra Udayanga. All rights reserved.
//

import Foundation
import RealmSwift

enum AuthType: String {
    case generic = "GENERIC"
    case facebook = "FACEBOOK"
    case google = "GOOGLE"
}

enum Gender: String {
    case male = "M"
    case female = "F"
}

class Profile: Object {
    
    @objc dynamic var id: String = ""
    @objc dynamic var socialLoginId: String = ""
    @objc dynamic var birthDay: String = ""
    @objc dynamic var isEnableUser: Bool = true
    @objc dynamic var role: String = ""
    @objc dynamic var contactNumber: String = ""
    @objc dynamic var userType: String = "standard"
    @objc dynamic var password: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var regDate: String = ""
    @objc dynamic var userProfilePic: String = ""
    @objc dynamic var userFirstName: String = ""
}


