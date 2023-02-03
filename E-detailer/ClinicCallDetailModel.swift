//
//  ClinicCallDetailModel.swift
//  E-detailer
//
//  Created by Macbook Air on 08/12/2021.
//  Copyright © 2021 Ammad. All rights reserved.
//

import Foundation
import ObjectMapper

struct ClinicCallDetailModel : Mappable {
    var success : Bool?
    var error : String?
    var result : [CallDetailResult]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        success <- map["Success"]
        error <- map["Error"]
        result <- map["Result"]
    }

}
struct CallDetailResult : Mappable {
    var clinicalActivityId : Int?
    var doctorID : Int?
    var doctorName : String?
    var callStartTime : String?
    var callEndTime : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        clinicalActivityId <- map["clinicalActivityId"]
        doctorID <- map["doctorID"]
        doctorName <- map["doctorName"]
        callStartTime <- map["callStartTime"]
        callEndTime <- map["callEndTime"]
    }

}
