//
//  Offer.swift
//  pikanite
//
//  Created by Rakshitha Muranga Rodrigo on 2/15/18.
//  Copyright © 2018 Rakshitha Muranga Rodrigo. All rights reserved.
//

import Foundation


struct Offer{
    
    var id: String = ""
    var hotelName: String = ""
    var nearestCityDistance: String = ""
    var nearestCity: String = ""
    var hotelAddress: String = ""
    var contactNumber: String = ""
    var hotelWebsite: String = ""
    var country: String = ""
    var taxRate: String = ""
    var currencyCode: String = ""
    var hotelId: String = ""
    var hotelEmail: String = ""
    var isEnable: Bool = true
    var closingDate: String = ""
    var timeZoneTime: Double = 0
    var recordDate: String = ""
    var hotelProfile: String = "standard"
    var rating: Int = 0
    
    var lon: Double = 0.00000000000
    var lat: Double = 0.00000000000
    
    var image4: String = ""
    var image3: String = ""
    var image2: String = ""
    var image1: String = ""
    var profilePic: String = "nan"
    
    
    var breakfastIncluded: Bool = false
    var guestCountInRoom: Int = 0
    var normalRoomRate: Double = 0.000
    var roomSize: Double = 0.0000
    var smokingPolicy: Bool = false
    var roomSubType: String = ""
    var roomType: String = ""
    var roomAmenities: String = ""
    
    var discount: Double = 0.000
    var todayOfferedRooms: Int = 0
    var todayOfferIndex: String = ""
}
