//
//  LoginModel.swift
//  E-detailer
//
//  Created by Ammad on 8/10/18.
//  Copyright © 2018 Ammad. All rights reserved.
//
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)
//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseWelcome { response in
//     if let welcome = response.result.value {
//       ...
//     }
//   }

import Foundation
import ObjectMapper

struct LoginModel : Mappable {
    var message : String?
    var response : Response?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        message <- map["Message"]
        response <- map["Response"]
    }

}
struct Response : Mappable {
    var employeeId : String?
    var employeeName : String?
    var designation : String?
    var hierarchyLevel : Int?
    var city : String?
    var zone : String?
    var territory : String?
    var authToken : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        employeeId <- map["EmployeeId"]
        employeeName <- map["EmployeeName"]
        designation <- map["Designation"]
        hierarchyLevel <- map["HierarchyLevel"]
        city <- map["City"]
        zone <- map["Zone"]
        territory <- map["Territory"]
        authToken <- map["AuthToken"]
    }

}

