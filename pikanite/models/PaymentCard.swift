//
//  PaymentCard.swift
//  tabbarconverted
//
//  Created by Gayanath Damith Amarasinghe on 12/13/17.
//  Copyright © 2017 Sachithra Udayanga. All rights reserved.
//

import Foundation
import ObjectMapper

//"type": "CREDIT CARD",
//"cardType": "Visa",
//"token": 4,
//"maskedNumber": "411111******1111",
//"expirationDate": "03/2020",
//"imageUrl": "https://assets.braintreegateway.com/payment_method_logo/visa.png?environment=sandbox"

class PaymentCard: Mappable {
    
    var type: String?
    var cardType: String?
    var token: NSNumber?
    var maskedNumber: String?
    var expirationDate: String?
    var imageUrl: String?
    var isApplePay = false
    
    func mapping(map: Map) {
        type <- map["type"]
        cardType <- map["cardType"]
        token <- map["token"]
        maskedNumber <- map["maskedNumber"]
        expirationDate <- map["expirationDate"]
        imageUrl <- map["imageUrl"]
    }
    
    required init?(map: Map) {
        
    }
    
    init() {
        
    }
}
