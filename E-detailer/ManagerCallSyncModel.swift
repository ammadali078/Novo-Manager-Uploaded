//
//  ManagerCallSyncModel.swift
//  E-detailer
//
//  Created by macbook on 05/04/2022.
//  Copyright © 2022 Ammad. All rights reserved.
//


import Foundation
import ObjectMapper

struct ManagerCallSyncModel : Mappable {
    var calls : [Calls]?
    var connectivityMedium : String?
    var lat : String?
    var lng : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        calls <- map["Calls"]
        connectivityMedium <- map["ConnectivityMedium"]
        lat <- map["Lat"]
        lng <- map["Lng"]
    }

}
struct Calls : Mappable {
    var connectivityMedium : String?
    var employeeId : String?
    var endTime : String?
    var lat : String?
    var lng : String?
    var mACAddress : String?
    var managerCallDoctors : [ManagerCallDoctors]?
    var managerId : String?
    var startTime : String?
    var edu_DualVisitEvaluationForm : [Edu_DualVisitEvaluationForm]?
    var edu_TriplelVisitEvaluationForm : [Edu_TriplelVisitEvaluationForm]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        connectivityMedium <- map["ConnectivityMedium"]
        employeeId <- map["EmployeeId"]
        endTime <- map["EndTime"]
        lat <- map["Lat"]
        lng <- map["Lng"]
        mACAddress <- map["MACAddress"]
        managerCallDoctors <- map["ManagerCallDoctors"]
        managerId <- map["ManagerId"]
        startTime <- map["StartTime"]
        edu_DualVisitEvaluationForm <- map["Edu_DualVisitEvaluationForm"]
        edu_TriplelVisitEvaluationForm <- map["Edu_TriplelVisitEvaluationForm"]
    }

}
struct ManagerCallDoctors : Mappable {
    var doctorId : String?
    var doctorName : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        doctorId <- map["DoctorId"]
        doctorName <- map["doctorName"]
    }

}
struct Edu_DualVisitEvaluationForm : Mappable {
    var employeeExternalId : String?
    var dE_ExternalId : String?
    var planStatus : String?
    var city : String?
    var clinicName : String?
    var hCPName : String?
    var activityStartTime : String?
    var activityEndTime : String?
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
    }

}
struct Edu_TriplelVisitEvaluationForm : Mappable {
    var employeeExternalId : String?
    var pC_ExternalId : String?
    var planStatus : String?
    var formSubmitDate : String?
    var noOfCampsVisited : String?
    var pCUnderstandingScopeActivity_Ach : String?
    var pCUnderstandingScopeActivity_Cmt : String?
    var territoryUnderstanding_Ach : String?
    var territoryUnderstanding_Cmt : String?
    var pCCoordinationWithHCP_Ach : String?
    var pCCoordinationWithHCP_Cmt : String?
    var regularDiscussionsWithHCP_Ach : String?
    var regularDiscussionsWithHCP_Cmt : String?
    var collabWithOtherStakeHolder_Ach : String?
    var collabWithOtherStakeHolder_Cmt : String?
    var pCCoordinationWithTeam_Ach : String?
    var pCCoordinationWithTeam_Cmt : String?
    var regionalTargetKPI_Ach : String?
    var regionalTargetKPI_Cmt : String?
    var activitiesConductedVSTarget_Ach : String?
    var activitiesConductedVSTarget_Cmt : String?
    var avgPatientNumberEducated_Ach : String?
    var avgPatientNumberEducated_Cmt : String?
    var focusOnTeamRetention_Ach : String?
    var focusOnTeamRetention_Cmt : String?
    var diabetesAndNNProductUnderstanding_Ach : String?
    var diabetesAndNNProductUnderstanding_Cmt : String?
    var understandingProcessesImplementation_Ach : String?
    var understandingProcessesImplementation_Cmt : String?
    var attitude_Ach : String?
    var attitude_Cmt : String?
    var pCReportingTimelines_Ach : String?
    var pCReportingTimelines_Cmt : String?
    var teamManagementAndOrganization_Ach : String?
    var teamManagementAndOrganization_Cmt : String?
    var teamForQualityOrganization_Ach : String?
    var teamForQualityOrganization_Cmt : String?
    var dualWorkingWithDE_Ach : String?
    var dualWorkingWithDE_Cmt : String?
    var qualityOfFeedbackProvidedToDEs_Ach : String?
    var qualityOfFeedbackProvidedToDEs_Cmt : String?
    var coachingOfTeamMembers_Ach : String?
    var coachingOfTeamMembers_Cmt : String?
    var overAllComments : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        employeeExternalId <- map["EmployeeExternalId"]
        pC_ExternalId <- map["PC_ExternalId"]
        planStatus <- map["PlanStatus"]
        formSubmitDate <- map["FormSubmitDate"]
        noOfCampsVisited <- map["NoOfCampsVisited"]
        pCUnderstandingScopeActivity_Ach <- map["PCUnderstandingScopeActivity_Ach"]
        pCUnderstandingScopeActivity_Cmt <- map["PCUnderstandingScopeActivity_Cmt"]
        territoryUnderstanding_Ach <- map["TerritoryUnderstanding_Ach"]
        territoryUnderstanding_Cmt <- map["TerritoryUnderstanding_Cmt"]
        pCCoordinationWithHCP_Ach <- map["PCCoordinationWithHCP_Ach"]
        pCCoordinationWithHCP_Cmt <- map["PCCoordinationWithHCP_Cmt"]
        regularDiscussionsWithHCP_Ach <- map["RegularDiscussionsWithHCP_Ach"]
        regularDiscussionsWithHCP_Cmt <- map["RegularDiscussionsWithHCP_Cmt"]
        collabWithOtherStakeHolder_Ach <- map["CollabWithOtherStakeHolder_Ach"]
        collabWithOtherStakeHolder_Cmt <- map["CollabWithOtherStakeHolder_Cmt"]
        pCCoordinationWithTeam_Ach <- map["PCCoordinationWithTeam_Ach"]
        pCCoordinationWithTeam_Cmt <- map["PCCoordinationWithTeam_Cmt"]
        regionalTargetKPI_Ach <- map["RegionalTargetKPI_Ach"]
        regionalTargetKPI_Cmt <- map["RegionalTargetKPI_Cmt"]
        activitiesConductedVSTarget_Ach <- map["ActivitiesConductedVSTarget_Ach"]
        activitiesConductedVSTarget_Cmt <- map["ActivitiesConductedVSTarget_Cmt"]
        avgPatientNumberEducated_Ach <- map["AvgPatientNumberEducated_Ach"]
        avgPatientNumberEducated_Cmt <- map["AvgPatientNumberEducated_Cmt"]
        focusOnTeamRetention_Ach <- map["FocusOnTeamRetention_Ach"]
        focusOnTeamRetention_Cmt <- map["FocusOnTeamRetention_Cmt"]
        diabetesAndNNProductUnderstanding_Ach <- map["DiabetesAndNNProductUnderstanding_Ach"]
        diabetesAndNNProductUnderstanding_Cmt <- map["DiabetesAndNNProductUnderstanding_Cmt"]
        understandingProcessesImplementation_Ach <- map["UnderstandingProcessesImplementation_Ach"]
        understandingProcessesImplementation_Cmt <- map["UnderstandingProcessesImplementation_Cmt"]
        attitude_Ach <- map["Attitude_Ach"]
        attitude_Cmt <- map["Attitude_Cmt"]
        pCReportingTimelines_Ach <- map["PCReportingTimelines_Ach"]
        pCReportingTimelines_Cmt <- map["PCReportingTimelines_Cmt"]
        teamManagementAndOrganization_Ach <- map["TeamManagementAndOrganization_Ach"]
        teamManagementAndOrganization_Cmt <- map["TeamManagementAndOrganization_Cmt"]
        teamForQualityOrganization_Ach <- map["TeamForQualityOrganization_Ach"]
        teamForQualityOrganization_Cmt <- map["TeamForQualityOrganization_Cmt"]
        dualWorkingWithDE_Ach <- map["DualWorkingWithDE_Ach"]
        dualWorkingWithDE_Cmt <- map["DualWorkingWithDE_Cmt"]
        qualityOfFeedbackProvidedToDEs_Ach <- map["QualityOfFeedbackProvidedToDEs_Ach"]
        qualityOfFeedbackProvidedToDEs_Cmt <- map["QualityOfFeedbackProvidedToDEs_Cmt"]
        coachingOfTeamMembers_Ach <- map["CoachingOfTeamMembers_Ach"]
        coachingOfTeamMembers_Cmt <- map["CoachingOfTeamMembers_Cmt"]
        overAllComments <- map["OverAllComments"]
    }

}
