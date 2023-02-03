//
//  PostSamAndExpModel.swift
//  E-detailer
//
//  Created by macbook on 12/01/2023.
//  Copyright © 2023 Ammad. All rights reserved.
//

import Foundation
import ObjectMapper

struct PostSamAndExpModel : Mappable {
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
