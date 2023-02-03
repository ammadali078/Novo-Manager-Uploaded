//
//  CallTripleModel.swift
//  E-detailer
//
//  Created by macbook on 20/07/2022.
//  Copyright © 2022 Ammad. All rights reserved.
//

import Foundation
import ObjectMapper

struct CallTripleModel : Mappable {
    var tripleVisitCallSync : [TripleVisitCallSync]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        tripleVisitCallSync <- map["TripleVisitCallSync"]
    }

}

struct TripleVisitCallSync : Mappable {
    var employeeExternalId : String?
    var pC_ExternalId : String?
    var planStatus : String?
    var activityStartTime : Double?
    var activityEndTime : Double?
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
        pC_ExternalId <- map["PC_ExternalId"]
        planStatus <- map["PlanStatus"]
        activityStartTime <- map["ActivityStartTime"]
        activityEndTime <- map["ActivityEndTime"]
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
        startlatitude <- map["Startlatitude"]
        startlongitude <- map["Startlongitude"]
        endlatitude <- map["Endlatitude"]
        endlongitude <- map["Endlongitude"]
        macAddress <- map["MacAddress"]
        requestIdentifier <- map["RequestIdentifier"]
    }

}
