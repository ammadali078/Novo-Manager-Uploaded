//
//  PatientModel.swift
//  E-detailer
//
//  Created by Macbook Air on 13/11/2021.
//  Copyright © 2021 Ammad. All rights reserved.
//

import Foundation
import ObjectMapper

struct PatientModel : Mappable {
    var success : Bool?
    var error : String?
    var result : [Patients]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        success <- map["Success"]
        error <- map["Error"]
        result <- map["Result"]
    }
}

struct Patients : Mappable {
    var id : Int?
    var name : String?
    var iNovoId : String?
    var allProductId : Int?
    var allProductName : String?
    var allDoctorId : Int?
    var allDoctorName : String?
    var patientId : Int?
    var patientName : String?
    var scheduleType : String?
    var planDate : String?
    var isRescheduled : Bool?
    var isCanceled : Bool?
    var patientType : String?
    var novoID : String?
    var cancelReason : String?
    var updatedDate : String?
    var canceledDate : String?
    var doctorId : Int?
    var doctorName : String?
    var productId : Int?
    var productName : String?

    
    

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["Id"]
        name <- map["Name"]
        iNovoId <- map["INovoId"]
        allProductId <- map["AllProductId"]
        allProductName <- map["AllProductName"]
        allDoctorId <- map["AllDoctorId"]
        allDoctorName <- map["AllDoctorName"]
        patientId <- map["PatientId"]
        patientName <- map["PatientName"]
        scheduleType <- map["ScheduleType"]
        planDate <- map["PlanDate"]
        isRescheduled <- map["IsRescheduled"]
        isCanceled <- map["IsCanceled"]
        patientType <- map["PatientType"]
        novoID <- map["NovoID"]
        cancelReason <- map["CancelReason"]
        updatedDate <- map["UpdatedDate"]
        canceledDate <- map["CanceledDate"]
        doctorId <- map["DoctorId"]
        doctorName <- map["DoctorName"]
        productId <- map["ProductId"]
        productName <- map["ProductName"]
    }

}

