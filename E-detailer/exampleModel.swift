//
//  exampleModel.swift
//  E-detailer
//
//  Created by macbook on 12/01/2023.
//  Copyright © 2023 Ammad. All rights reserved.
//

import Foundation
import ObjectMapper

struct exampleModel : Mappable {
    var success : Bool?
    var error : String?
    var result : ExampleResult?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        success <- map["Success"]
        error <- map["Error"]
        result <- map["Result"]
    }

}
struct ExampleResult : Mappable {
    var emp_city : [Emp_city] = []
    var name = [String]()

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        emp_city <- map["emp_city"]
        for i in emp_city{
            self.name.append(i.name ?? "")
        }
    }

}
struct Emp_city : Mappable {
    var id : Int?
    var name : String?
    var destinations : [Destinations] = []
    var desName = [String]()
    var desId = [Int]()

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["Id"]
        name <- map["Name"]
        destinations <- map["Destinations"]
        for i in destinations{
            self.desName.append(i.name ?? "")
        }
        
        for i in destinations{
            self.desId.append(i.id ?? 0)
        }
        
    }

}
struct Destinations : Mappable {
    var id : Int?
    var name : String?
    var distanceInKM : Double?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["Id"]
        name <- map["Name"]
        distanceInKM <- map["DistanceInKM"]
    }

}
