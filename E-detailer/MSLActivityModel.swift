//
//  MSLActivityModel.swift
//  E-detailer
//
//  Created by macbook on 06/07/2022.
//  Copyright © 2022 Ammad. All rights reserved.
//

import Foundation
import ObjectMapper

struct MSLActivityModel : Mappable {
    var mslActivityList : [MslActivityList]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        mslActivityList <- map["mslActivityList"]
    }

}

struct MslActivityList : Mappable {
    var activityType : String?
    var comment : String?
    var empId : String?
    var startLat : String?
    var startLng : String?
    var endLat : String?
    var endLng : String?
    var startTime : String?
    var endTime : String?
    var noOfHcp : String?
    var team : String?
    var doctorInternalId : Int?
    var clinic : String?
    var address : String?
    var VisitObjective : String?
    var VisitPurpose : String?
    var Image1 : String?
    var Image2 : String?
    var mSLActivityAttachments : [MSLActivityAttachments]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        activityType <- map["ActivityType"]
        comment <- map["Comment"]
        empId <- map["EmpId"]
        startLat <- map["StartLat"]
        startLng <- map["StartLng"]
        endLat <- map["EndLat"]
        endLng <- map["EndLng"]
        startTime <- map["StartTime"]
        endTime <- map["EndTime"]
        noOfHcp <- map["NoOfHcp"]
        team <- map["Team"]
        doctorInternalId <- map["DoctorInternalId"]
        clinic <- map["Clinic"]
        address <- map["Address"]
        VisitObjective <- map["VisitObjective"]
        VisitPurpose <- map["VisitPurpose"]
        Image1 <- map["Image1"]
        Image2 <- map["Image2"]
    }

}

struct MSLActivityAttachments : Mappable {
    var fileUrl : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        fileUrl <- map["FileUrl"]
    }

}
