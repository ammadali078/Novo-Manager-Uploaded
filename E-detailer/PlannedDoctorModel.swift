//
//  PlannedDoctorModel.swift
//  E-detailer
//
//  Created by Macbook Air on 30/11/2021.
//  Copyright © 2021 Ammad. All rights reserved.
//

import Foundation
import ObjectMapper

struct PlannedDoctorModel : Mappable {
    var success : Bool?
    var error : String?
    var result : [PlannedResult]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        success <- map["Success"]
        error <- map["Error"]
        result <- map["Result"]
    }

}
struct PlannedResult : Mappable {
    var empId : String?
    var empName : String?
    var planStatus : String?
    

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        empId <- map["empId"]
        empName <- map["empName"]
        planStatus <- map["PlanStatus"]
    }

}
