//
//  CallDual.swift
//  E-detailer
//
//  Created by macbook on 18/07/2022.
//  Copyright © 2022 Ammad. All rights reserved.
//

import Foundation
import ObjectMapper

struct CallDualModel : Mappable {
    var dualVisitCallSync : [DualVisitCallSync]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        dualVisitCallSync <- map["DualVisitCallSync"]
    }

}


struct DualVisitCallSync : Mappable {
    var employeeExternalId : String?
    var dE_ExternalId : String?
    var planStatus : String?
    var city : String?
    var clinicName : String?
    var hCPName : String?
    var activityStartTime : Double?
    var activityEndTime : Double?
    var patientEducation_Ach : String?
    var patientEducation_Cmt : String?
    var avgTimeForPatientEducation_Ach : String?
    var avgTimeForPatientEducation_Cmt : String?
    var nNDeviceDemo_Ach : String?
    var nNDeviceDemo_Cmt : String?
    var diabetesUnderstanding_Ach : String?
    var diabetesUnderstanding_Cmt : String?
    var nNProductUnderstanding_Ach : String?
    var nNProductUnderstanding_Cmt : String?
    var educationalMaterialUsage_Ach : String?
    var educationalMaterialUsage_Cmt : String?
    var effectiveResourceUse_Ach : String?
    var effectiveResourceUse_Cmt : String?
    var timelinesComplianceReport_Ach : String?
    var timelinesComplianceReport_Cmt : String?
    var attire_Ach : String?
    var attire_Cmt : String?
    var punctuality_Ach : String?
    var punctuality_Cmt : String?
    var patientSatisfactionLevel_Ach : String?
    var patientSatisfactionLevel_Cmt : String?
    var hCPFeedback_Ach : String?
    var hCPFeedback_Cmt : String?
    var overallComment : String?
    var employeeDate : String?
    var coordinatorName : String?
    var coordinatorDate : String?
    var startlatitude : String?
    var startlongitude : String?
    var endlatitude : String?
    var endlongitude : String?
    var macAddress : String?
    var requestIdentifier : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        employeeExternalId <- map["EmployeeExternalId"]
        dE_ExternalId <- map["DE_ExternalId"]
        planStatus <- map["PlanStatus"]
        city <- map["City"]
        clinicName <- map["ClinicName"]
        hCPName <- map["HCPName"]
        activityStartTime <- map["ActivityStartTime"]
        activityEndTime <- map["ActivityEndTime"]
        patientEducation_Ach <- map["PatientEducation_Ach"]
        patientEducation_Cmt <- map["PatientEducation_Cmt"]
        avgTimeForPatientEducation_Ach <- map["AvgTimeForPatientEducation_Ach"]
        avgTimeForPatientEducation_Cmt <- map["AvgTimeForPatientEducation_Cmt"]
        nNDeviceDemo_Ach <- map["NNDeviceDemo_Ach"]
        nNDeviceDemo_Cmt <- map["NNDeviceDemo_Cmt"]
        diabetesUnderstanding_Ach <- map["DiabetesUnderstanding_Ach"]
        diabetesUnderstanding_Cmt <- map["DiabetesUnderstanding_Cmt"]
        nNProductUnderstanding_Ach <- map["NNProductUnderstanding_Ach"]
        nNProductUnderstanding_Cmt <- map["NNProductUnderstanding_Cmt"]
        educationalMaterialUsage_Ach <- map["EducationalMaterialUsage_Ach"]
        educationalMaterialUsage_Cmt <- map["EducationalMaterialUsage_Cmt"]
        effectiveResourceUse_Ach <- map["EffectiveResourceUse_Ach"]
        effectiveResourceUse_Cmt <- map["EffectiveResourceUse_Cmt"]
        timelinesComplianceReport_Ach <- map["TimelinesComplianceReport_Ach"]
        timelinesComplianceReport_Cmt <- map["TimelinesComplianceReport_Cmt"]
        attire_Ach <- map["Attire_Ach"]
        attire_Cmt <- map["Attire_Cmt"]
        punctuality_Ach <- map["Punctuality_Ach"]
        punctuality_Cmt <- map["Punctuality_Cmt"]
        patientSatisfactionLevel_Ach <- map["PatientSatisfactionLevel_Ach"]
        patientSatisfactionLevel_Cmt <- map["PatientSatisfactionLevel_Cmt"]
        hCPFeedback_Ach <- map["HCPFeedback_Ach"]
        hCPFeedback_Cmt <- map["HCPFeedback_Cmt"]
        overallComment <- map["OverallComment"]
        employeeDate <- map["EmployeeDate"]
        coordinatorName <- map["CoordinatorName"]
        coordinatorDate <- map["CoordinatorDate"]
        startlatitude <- map["Startlatitude"]
        startlongitude <- map["Startlongitude"]
        endlatitude <- map["Endlatitude"]
        endlongitude <- map["Endlongitude"]
        macAddress <- map["MacAddress"]
        requestIdentifier <- map["RequestIdentifier"]
    }

}
