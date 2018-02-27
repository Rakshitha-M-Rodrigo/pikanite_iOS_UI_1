//
//  RewardList.swift
//  tabbarconverted
//
//  Created by Rakshitha Muranga Rodrigo on 11/22/17.
//  Copyright © 2017 Sachithra Udayanga. All rights reserved.
//

import Foundation
import ObjectMapper

//"reward_id": 1,
//"reward_title": "Sample Title",
//"description": "demo dmeo",
//"point_required": 12

class RewardList : Mappable{
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        reward_id <- map["reward_id"]
        reward_title <- map["reward_title"]
        description <- map["description"]
        point_required <- (map["point_required"],TransformOf<String, Int>(fromJSON: { String($0!) }, toJSON: { $0.map { Int($0)! } }))
    }
    

    var reward_id: Int = 0
    var reward_title: String = ""
    var description: String = ""
    var point_required: String = ""
    
    
}


