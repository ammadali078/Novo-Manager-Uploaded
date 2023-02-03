//
//  DoctorModel.swift
//  E-detailer
//
//  Created by Ammad on 8/13/18.
//  Copyright © 2018 Ammad. All rights reserved.
//


import Foundation
import ObjectMapper

struct DoctorModel : Mappable {
    var success : Bool?
    var error : String?
    var result : [DoctorResult]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        success <- map["Success"]
        error <- map["Error"]
        result <- map["Result"]
    }

}
struct DoctorResult : Mappable {
    var employeeId : String?
    var employeeName : String?
    var planStatus : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        employeeId <- map["EmployeeId"]
        employeeName <- map["EmployeeName"]
        planStatus <- map["PlanStatus"]
    }

}

