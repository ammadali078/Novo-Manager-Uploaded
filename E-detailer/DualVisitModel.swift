//
//  DualVisitModel.swift
//  E-detailer
//
//  Created by macbook on 24/01/2022.
//  Copyright © 2022 Ammad. All rights reserved.
//


import Foundation
import ObjectMapper

struct DualVisitModel : Mappable {
    var success : Bool?
    var error : String?
    var result : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        success <- map["Success"]
        error <- map["Error"]
        result <- map["Result"]
    }
    
}


