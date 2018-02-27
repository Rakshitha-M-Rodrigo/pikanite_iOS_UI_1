//
//  UIKit+extensions.swift
//  tabbarconverted
//
//  Created by Rakshitha Muranga Rodrigo on 11/22/17.
//  Copyright © 2017 Sachithra Udayanga. All rights reserved.
//

import Foundation


extension String {
    
    func toNotificationDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: self)
        if date == nil {
            return ""
        }
        dateFormatter.dateFormat = "d/M/yyyy"
        return dateFormatter.string(from: date!) 
    }
    
    
    func toNotificationDateString(format: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: self)
        if date == nil {
            return ""
        }
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date!)
    }
    
    func isValidEmail() -> Bool {
        if self == nil || self == "" { return false }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
}

extension Optional where Wrapped == String {
    
//    func isValidEmail() -> Bool {
//        if self == nil || self == "" { return false }
//        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
//        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
//        return emailTest.evaluate(with: self)
//    }
    
    func isValidNumber() -> Bool {
        if self == nil || self == "" { return false }
        //let PHONE_REGEX = "^((\\+)|(00))[0-9]{6,14}$"
        //let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        //let result =  phoneTest.evaluate(with: self)
        //return result
        let length = self!.count
        if length > 6 && length < 10 {
            return true
        } else {
            return false
        }
    }
}
