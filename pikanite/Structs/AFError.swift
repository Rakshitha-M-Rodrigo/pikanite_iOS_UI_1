//
//  AFError.swift
//  tabbarconverted
//
//  Created by Sachithra Udayanga on 11/9/17.
//  Copyright © 2017 Sachithra Udayanga. All rights reserved.
//

import Foundation
import ObjectMapper

struct AFGeneralError: Mappable {
    
    var id = ""
    var message: String!
    
    init?(map: Map) {
        
    }
    
    init(id: String, message: String) {
        self.id = id
        self.message = message
    }
    
    mutating func mapping(map: Map) {
        message <- map["message"]
    }
}

struct AFValidationError: Mappable {
    
    var id: String!
    var message: String!
    
    init?(map: Map) {
        
    }
    
    init(id: String, message: String) {
        self.id = id
        self.message = message
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        message <- map["message"]
    }
}

struct AFErrors: Mappable {
    
    var errors: [AFValidationError]!
    
    init?(map: Map) {
        
    }
    
    init(errors: [AFValidationError]) {
        self.errors = errors
    }
    
    mutating func mapping(map: Map) {
        errors <- map["errors"]
    }
}
