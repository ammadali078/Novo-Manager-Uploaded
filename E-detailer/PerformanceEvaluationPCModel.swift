//
//  PerformanceEvaluationPCModel.swift
//  E-detailer
//
//  Created by macbook on 15/06/2022.
//  Copyright © 2022 Ammad. All rights reserved.
//

import Foundation
import ObjectMapper

struct PerformanceEvaluationPCModel : Mappable {
    var success : Bool?
    var error : String?
    var result : Int?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        success <- map["Success"]
        error <- map["Error"]
        result <- map["Result"]
    }

}
