//
//  HotelProfile.swift
//  pikanite
//
//  Created by Rakshitha Muranga Rodrigo on 2/21/18.
//  Copyright © 2018 Rakshitha Muranga Rodrigo. All rights reserved.
//

import Foundation

struct HotelProfile{
    
    var id: String = ""
    var amenities: String = ""
    var hotelZipcode: Int = 0
    var hotelAddress: String = ""
    var nearestCityDistance: String = ""
    var nearestCity: String = ""
    var country: String = ""
    var contactNumber: String = ""
    var hotelEmail: String = ""
    var hotelWebSite: String = ""
    var hotelName: String = ""
    var hotelPartnerId: String = ""
    var hotelRoomCount: Int = 0
    var multipleEmail: String = ""
    var guestCountInRoom: Int = 0
    var regDate: String = ""
    var hotelProfile: String = ""
    var rating: Int = 0
//    var hotelLikeAboutInfo: String = ""
    var fact1: String = ""
    var fact2: String = ""
    var fact3: String = ""
//    var needToKnow: String = ""
    var coupleFriendly: Bool = false
    var petLimit: Bool = false
    var cancellationLimit: Bool = true
    var ageLimit: String = ""
    var checkOutTimeEnd: String = ""
    var checkOutTimeStart: String = ""
    var checkInTimeEnd: String = ""
    var checkInTimeStart: String = ""
//    var location: String = ""
    var lon: Double = 0.00000000
    var lat: Double = 0.00000000
//    var image: String = ""
    var image4: String = ""
    var image3: String = ""
    var image2: String = ""
    var image1: String = ""
    var profilePic: String = ""
    
    //added by achsuthan
    
    var breakfastIncluded: Bool!
    var smokingPolicy : Bool!
    var extraCharge : String = "Extra guests may be charged additionally at the hotel's discretion"
    var nonRefundable : String = "Booking non-refundable"
}
