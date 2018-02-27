//
//  EarnPoint.swift
//  tabbarconverted
//
//  Created by Rakshitha Muranga Rodrigo on 11/22/17.
//  Copyright © 2017 Sachithra Udayanga. All rights reserved.
//

import Foundation
import ObjectMapper


//"name": "Buy Tickets",
//"available_points": 0

class EarnPoint: Mappable {
    required init?(map: Map) {

    }
    
    func mapping(map: Map) {
        name <- map["name"]
        available_points <- map["available_points"]
    }
    
    var name: String = ""
    var available_points: Int = 0
    
}
