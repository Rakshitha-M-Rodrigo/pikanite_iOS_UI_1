//
//  PurchaseHistory.swift
//  tabbarconverted
//
//  Created by Rakshitha Muranga Rodrigo on 11/23/17.
//  Copyright © 2017 Sachithra Udayanga. All rights reserved.
//

import Foundation
import ObjectMapper

//"purchase_id": 23,
//"purchase_member_id": 26,
//"num_of_tickets_purchased": 0,
//"num_of_birthday_pack_purchased": 0,
//"event_id": 2,
//"txn_id": "TXN/26/2/1513249553",
//"total_amount": "20.00",
//"txn_type": "CC",
//"status": "COMPLETED",
//"api_response": "N/A",
//"created_at": "2017-12-14 11:05:53",
//"updated_at": "2017-12-14 11:05:53",
//"event_title": "Sample event title 2",
//"event_description": "Sample event description Sample event description Sample event description  Sample event description Sample event description Sample event description Sample event description Sample event description Sample event description Sample event description Sample event description Sample event description "


class PurchaseHistory: Mappable{

    var purchase_id: Int = 0
    var purchase_member_id: Int = 0
    var num_of_tickets_purchased: Int = 0
    var num_of_birthday_pack_purchased: Int = 0
    var event_id: Int = 0
    var txn_id: String = ""
    var total_amount: String = ""
    var txn_type: String = ""
    var status: String = ""
    var api_response: String = ""
    var created_at: String = ""
    var updated_at: String = ""
    var event_title: String = ""
    var event_description: String = ""
    
    required init?(map: Map) {}

    func mapping(map: Map) {
        purchase_id <- map["purchase_id"]
        purchase_member_id <- map["purchase_member_id"]
        num_of_tickets_purchased <- map["num_of_tickets_purchased"]
        num_of_birthday_pack_purchased <- map["num_of_birthday_pack_purchased"]
        event_id <- map["event_id"]
        txn_id <- map["txn_id"]
        total_amount <- map["total_amount"]
        txn_type <- map["txn_type"]
        status <- map["status"]
        api_response <- map["api_response"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        event_title <- map["event_title"]
        event_description <- map["event_description"]
    }
}
