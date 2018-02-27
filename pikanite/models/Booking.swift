//
//  Booking.swift
//  pikanite
//
//  Created by Rakshitha Muranga Rodrigo on 2/26/18.
//  Copyright © 2018 Rakshitha Muranga Rodrigo. All rights reserved.
//

import Foundation

struct Booking{
    var id: String = ""
    var currentStatus:String = ""
    var userContactNumber: String = ""
    var userName:String = ""
    var userEmail:String = ""
    var price:Double = 0.0
    var currentRoomType:String = ""
    var hotelAddress:String = ""
    var currentHotelProfile:String = ""
    var currentHotelRating:Int = 0
    var hotelContactNumber:String = ""
    var bookedCheckoutTime:String = ""
    var bookedCheckinTime:String = ""
    var numberOfRooms:String = ""
    var nearestCity:String = ""
    var hotelName:String = ""
    var hotelEmail:String = ""
    var bookingId:String = ""
    
    var recordedDate:String = ""
    
    //need to know
    var petLimit:Bool = false
    var cancellationLimit:Bool = false
    var ageLimit:String = ""
    var checkOutTime:String = ""
    var checkInTime:String = ""
    var hotelGeneralInfo:String = ""
    
    var discountAddedPrice: Double = 0.00
    var discount:Double = 0.000

    var lon: Double = 0.0000
    var lat: Double = 0.0000
    
    
    var hotelProfileImageUrl: String = ""
}

