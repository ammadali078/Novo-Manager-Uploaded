//
//  TripleVisitViewController.swift
//  E-detailer
//
//  Created by macbook on 01/01/2022.
//  Copyright © 2022 Ammad. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import ObjectMapper
import DatePickerDialog

class TripleVisitViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var designationTextField: UITextField!
    @IBOutlet weak var visitedNoTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var regionTextField: UITextField!
    @IBOutlet weak var otherCommentTextField: UITextView!
    @IBOutlet weak var achievement1TextField: UITextField!
    @IBOutlet weak var Comment1TextField: UITextField!
    @IBOutlet weak var achievement2TextField: UITextField!
    @IBOutlet weak var achievement3TextField: UITextField!
    @IBOutlet weak var achievement4TextField: UITextField!
    @IBOutlet weak var achievement5TextField: UITextField!
    @IBOutlet weak var achievement6TextField: UITextField!
    @IBOutlet weak var achievement7TextField: UITextField!
    @IBOutlet weak var achievement8TextField: UITextField!
    @IBOutlet weak var achievement9TextField: UITextField!
    @IBOutlet weak var achievement10TextField: UITextField!
    @IBOutlet weak var achievement11TextField: UITextField!
    @IBOutlet weak var achievement12TextField: UITextField!
    @IBOutlet weak var achievement13TextField: UITextField!
    @IBOutlet weak var achievement14TextField: UITextField!
    @IBOutlet weak var achievement15TextField: UITextField!
    @IBOutlet weak var achievement16TextField: UITextField!
    @IBOutlet weak var achievement17TextField: UITextField!
    @IBOutlet weak var achievement18TextField: UITextField!
    @IBOutlet weak var achievement19TextField: UITextField!
    @IBOutlet weak var comment2TextField: UITextField!
    @IBOutlet weak var comment3TextField: UITextField!
    @IBOutlet weak var comment4TextField: UITextField!
    @IBOutlet weak var comment5TextField: UITextField!
    @IBOutlet weak var comment6TextField: UITextField!
    @IBOutlet weak var comment7TextField: UITextField!
    @IBOutlet weak var comment8TextField: UITextField!
    @IBOutlet weak var comment9TextField: UITextField!
    @IBOutlet weak var comment10TextField: UITextField!
    @IBOutlet weak var comment11TextField: UITextField!
    @IBOutlet weak var comment12TextField: UITextField!
    @IBOutlet weak var comment13TextField: UITextField!
    @IBOutlet weak var comment14TextField: UITextField!
    @IBOutlet weak var comment15TextField: UITextField!
    @IBOutlet weak var comment16TextField: UITextField!
    @IBOutlet weak var comment17TextField: UITextField!
    @IBOutlet weak var comment18TextField: UITextField!
    @IBOutlet weak var comment19TextField: UITextField!
    @IBOutlet weak var pcNameTextField: UITextField!
    
    
    var indicator: UIActivityIndicatorView!
    var activitiyViewController: ActivityViewController!
    var lblPlaceHolder : UILabel!
    let datePicker = UIDatePicker()
    var maxLength : Int?
    let startDatePicker = UIDatePicker()
    var startTime: String?
    
    func textViewDidChange(_ textView: UITextView) {
        lblPlaceHolder.isHidden = !textView.text.isEmpty
    }
    
    override func viewDidLoad() {
        
        dateTextField.delegate = self
        otherCommentTextField.delegate = self
        designationTextField.text = CommonUtils.getJsonFromUserDefaults(forKey: Constants.designation)
        regionTextField.text = CommonUtils.getJsonFromUserDefaults(forKey: Constants.zone)
        lblPlaceHolder = UILabel()
        lblPlaceHolder.text = "Enter your other Comments"
        lblPlaceHolder.font = UIFont.systemFont(ofSize: otherCommentTextField.font!.pointSize)
        lblPlaceHolder.sizeToFit()
        otherCommentTextField.addSubview(lblPlaceHolder)
        lblPlaceHolder.frame.origin = CGPoint(x: 5, y: (otherCommentTextField.font?.pointSize)! / 2)
        lblPlaceHolder.textColor = UIColor.lightGray
        lblPlaceHolder.isHidden = !otherCommentTextField.text.isEmpty
//        self.showDatePicker()
        activitiyViewController = ActivityViewController(message: "Loading...")
        self.otherCommentTextField.layer.borderColor = UIColor.lightGray.cgColor
        self.otherCommentTextField.layer.borderWidth = 1.0
        self.otherCommentTextField.layer.cornerRadius = 8
        self.nameTextField.text = CommonUtils.getJsonFromUserDefaults(forKey: Constants.Emp_Name)
        
        self.StartDatePicker()
        

        let planSelectedName = CommonUtils.getJsonFromUserDefaults(forKey: Constants.selectedName)
        
        self.pcNameTextField.text = planSelectedName
        
        dateTextField.delegate = self
        otherCommentTextField.delegate = self
        achievement1TextField.delegate = self
        achievement2TextField.delegate = self
        achievement3TextField.delegate = self
        achievement4TextField.delegate = self
        achievement5TextField.delegate = self
        achievement6TextField.delegate = self
        achievement7TextField.delegate = self
        achievement8TextField.delegate = self
        achievement9TextField.delegate = self
        achievement10TextField.delegate = self
        achievement11TextField.delegate = self
        achievement12TextField.delegate = self
        achievement13TextField.delegate = self
        achievement14TextField.delegate = self
        achievement15TextField.delegate = self
        achievement16TextField.delegate = self
        achievement17TextField.delegate = self
        achievement18TextField.delegate = self
        achievement19TextField.delegate = self
        visitedNoTextField.delegate = self
        Comment1TextField.delegate = self
        comment2TextField.delegate = self
        comment3TextField.delegate = self
        comment4TextField.delegate = self
        comment5TextField.delegate = self
        comment6TextField.delegate = self
        comment7TextField.delegate = self
        comment8TextField.delegate = self
        comment9TextField.delegate = self
        comment10TextField.delegate = self
        comment11TextField.delegate = self
        comment12TextField.delegate = self
        comment13TextField.delegate = self
        comment14TextField.delegate = self
        comment15TextField.delegate = self
        comment16TextField.delegate = self
        comment17TextField.delegate = self
        comment18TextField.delegate = self
        comment19TextField.delegate = self
        startTime = String(CommonUtils.getCurrentTime())
        
    }
    
    func StartDatePicker(){
        //Formate Date
        startDatePicker.datePickerMode = .date
        startDatePicker.minimumDate = Date()
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneStartPicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        dateTextField.inputAccessoryView = toolbar
        dateTextField.inputView = startDatePicker
        
    }

    @objc func doneStartPicker(){
        
        let Formatter = DateFormatter()
        Formatter.dateFormat = "dd-MM-YYYY HH:mm:ss"
        let strDate = Formatter.string(from: startDatePicker.date)
        dateTextField.text = strDate
        self.view.endEditing(true)
    }

    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    
    @IBAction func onDateClicked(_ sender: Any) {
        
        DatePickerDialog().show("Select Date", doneButtonTitle: "Search",cancelButtonTitle: "Cancel", minimumDate: Date(), datePickerMode: .date) { date in
            if let dt = date {
                let formatter = DateFormatter()
                formatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
                let planPasteDate = formatter.string(from: dt)
                self.dateTextField.text = planPasteDate
                
                
            }
        }
        
        
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == visitedNoTextField{
            maxLength = 80
        }else if textField == dateTextField{
            maxLength = 80
        }else if textField == otherCommentTextField{
            maxLength = 600
        }else if textField == achievement1TextField{
            maxLength = 240
        }else if textField == achievement2TextField{
            maxLength = 240
        } else if textField == achievement3TextField{
            maxLength = 240
        }else if textField == achievement4TextField{
            maxLength = 240
        }else if textField == achievement5TextField{
            maxLength = 240
        }else if textField == achievement6TextField{
            maxLength = 240
        }else if textField == achievement7TextField{
            maxLength = 240
        }else if textField == achievement8TextField{
            maxLength = 240
        }else if textField == achievement9TextField{
            maxLength = 240
        }else if textField == achievement10TextField{
            maxLength = 240
        }else if textField == achievement11TextField{
            maxLength = 240
        }else if textField == achievement12TextField{
            maxLength = 240
        }else if textField == achievement13TextField{
            maxLength = 240
        }else if textField == achievement14TextField{
            maxLength = 240
        }else if textField == achievement15TextField{
            maxLength = 240
        }else if textField == achievement16TextField{
            maxLength = 240
        }else if textField == achievement17TextField{
            maxLength = 240
        }else if textField == achievement18TextField{
            maxLength = 240
        }else if textField == achievement19TextField{
            maxLength = 240
        }else if textField == Comment1TextField{
            maxLength = 490
        }else if textField == comment2TextField{
            maxLength = 490
        }else if textField == comment3TextField{
            maxLength = 490
        }else if textField == comment4TextField{
            maxLength = 490
        }else if textField == comment5TextField{
            maxLength = 490
        }else if textField == comment6TextField{
            maxLength = 490
        }else if textField == comment7TextField{
            maxLength = 490
        }else if textField == comment8TextField{
            maxLength = 490
        }else if textField == comment9TextField{
            maxLength = 490
        }else if textField == comment10TextField{
            maxLength = 490
        }else if textField == comment11TextField{
            maxLength = 490
        }else if textField == comment12TextField{
            maxLength = 490
        }else if textField == comment13TextField{
            maxLength = 490
        }else if textField == comment14TextField{
            maxLength = 490
        }else if textField == comment15TextField{
            maxLength = 490
        }else if textField == comment16TextField{
            maxLength = 490
        }else if textField == comment17TextField{
            maxLength = 490
        }else if textField == comment18TextField{
            maxLength = 490
        }else if textField == comment19TextField{
            maxLength = 490
        }
        
        let currentString: NSString = textField.text! as NSString
        
        let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength ?? 0
        
    }
    
//    func showDatePicker(){
//        //Formate Date
//        datePicker.datePickerMode = .date
//        //ToolBar
//        let toolbar = UIToolbar();
//        toolbar.sizeToFit()
//
//        //done button & cancel button
//        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.donedatePicker))
//        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
//        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelDatePicker))
//        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
//
//        // add toolbar to textField
//        dateTextField.inputAccessoryView = toolbar
//        // add datepicker to textField
//        dateTextField.inputView = datePicker
//    }
//
//    @objc func donedatePicker(){
//
//        let formatter = DateFormatter()
//        formatter.dateFormat = "dd-MM-yyyy"
//
//        let strDate = formatter.string(from: datePicker.date)
//        dateTextField.text = strDate
//        CommonUtils.saveJsonToUserDefaults(forKey: Constants.startDate, withJson: strDate)
//        self.view.endEditing(true)
//
//        //                 self.datePickerOutlet.isHidden = true
//    }
//
//    @objc func cancelDatePicker(){
//           self.view.endEditing(true)
//       }
    
    
    
    func textView(_ tsextView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (otherCommentTextField.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        return numberOfChars < 500    // 10 Limit Value
    }
    
    @IBAction func onBackClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func onSaveClicked(_ sender: Any) {
        
        let provideddDate = dateTextField.text
        let providedVisitNo = visitedNoTextField.text
        let achievement1TextField = achievement1TextField.text
        let achievement2TextField = achievement2TextField.text
        let achievement3TextField = achievement3TextField.text
        let achievement4TextField = achievement4TextField.text
        let achievement5TextField = achievement5TextField.text
        let achievement6TextField = achievement6TextField.text
        let achievement7TextField = achievement7TextField.text
        let achievement8TextField = achievement8TextField.text
        let achievement9TextField = achievement9TextField.text
        let achievement10TextField = achievement10TextField.text
        let achievement11TextField = achievement11TextField.text
        let achievement12TextField = achievement12TextField.text
        let achievement13TextField = achievement13TextField.text
        let achievement14TextField = achievement14TextField.text
        let achievement15TextField = achievement15TextField.text
        let achievement16TextField = achievement16TextField.text
        let achievement17TextField = achievement17TextField.text
        let achievement18TextField = achievement18TextField.text
        let achievement19TextField = achievement19TextField.text
        let Comment1TextField = Comment1TextField.text
        let Comment2TextField = comment2TextField.text
        let Comment3TextField = comment3TextField.text
        let Comment4TextField = comment4TextField.text
        let Comment5TextField = comment5TextField.text
        let Comment6TextField = comment6TextField.text
        let Comment7TextField = comment7TextField.text
        let Comment8TextField = comment8TextField.text
        let Comment9TextField = comment9TextField.text
        let Comment10TextField = comment10TextField.text
        let Comment11TextField = comment11TextField.text
        let Comment12TextField = comment12TextField.text
        let Comment13TextField = comment13TextField.text
        let Comment14TextField = comment14TextField.text
        let Comment15TextField = comment15TextField.text
        let Comment16TextField = comment16TextField.text
        let Comment17TextField = comment17TextField.text
        let Comment18TextField = comment18TextField.text
        let Comment19TextField = comment19TextField.text
        let otherCommentTextField = otherCommentTextField.text
        
        
        
        if provideddDate == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        
        if providedVisitNo == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if achievement1TextField == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if achievement2TextField == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if achievement3TextField == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if achievement4TextField == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if achievement5TextField == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if achievement6TextField == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if achievement7TextField == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if achievement8TextField == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if achievement9TextField == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if achievement10TextField == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if achievement11TextField == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if achievement12TextField == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if achievement13TextField == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if achievement14TextField == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if achievement15TextField == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if achievement16TextField == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if achievement17TextField == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if achievement18TextField == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if achievement19TextField == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if Comment1TextField == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if Comment2TextField == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if Comment3TextField == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if Comment4TextField == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if Comment5TextField == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if Comment6TextField == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if Comment7TextField == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if Comment8TextField == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if Comment9TextField == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if Comment10TextField == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if Comment11TextField == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if Comment12TextField == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if Comment13TextField == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if Comment14TextField == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if Comment15TextField == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if Comment16TextField == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if Comment17TextField == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if Comment18TextField == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if Comment19TextField == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if otherCommentTextField == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        
        
        var Tdata = CommonUtils.getJsonFromUserDefaults(forKey: Constants.triplePostData)
        if (Tdata == "") {Tdata = "[]"}
        
        var callTriples:[TripleVisitCallSync] = Mapper<TripleVisitCallSync>().mapArray(JSONString: Tdata)!
        
        var callTriple = TripleVisitCallSync(map: Map(mappingType: .fromJSON, JSON: [:]))
        
        
        callTriple?.employeeExternalId = CommonUtils.getJsonFromUserDefaults(forKey: Constants.EMP_ID);
        callTriple?.pC_ExternalId = CommonUtils.getJsonFromUserDefaults(forKey: Constants.selectedDoctorId)
        callTriple?.planStatus = providedVisitNo
        callTriple?.activityStartTime = Double(startTime ?? "")
        callTriple?.activityEndTime = CommonUtils.getCurrentTime()
        callTriple?.formSubmitDate = provideddDate
        callTriple?.noOfCampsVisited = providedVisitNo
        callTriple?.pCUnderstandingScopeActivity_Ach = achievement1TextField
        callTriple?.pCUnderstandingScopeActivity_Cmt = Comment1TextField
        callTriple?.territoryUnderstanding_Ach = achievement2TextField
        callTriple?.territoryUnderstanding_Cmt = Comment2TextField
        callTriple?.pCCoordinationWithHCP_Ach = achievement3TextField
        callTriple?.pCCoordinationWithHCP_Cmt = Comment3TextField
        callTriple?.regularDiscussionsWithHCP_Ach = achievement4TextField
        callTriple?.regularDiscussionsWithHCP_Cmt = Comment4TextField
        callTriple?.collabWithOtherStakeHolder_Ach = achievement5TextField
        callTriple?.collabWithOtherStakeHolder_Cmt = Comment5TextField
        callTriple?.pCCoordinationWithTeam_Ach = achievement6TextField
        callTriple?.pCCoordinationWithTeam_Cmt = Comment6TextField
        callTriple?.regionalTargetKPI_Ach = achievement7TextField
        callTriple?.regionalTargetKPI_Cmt = Comment7TextField
        callTriple?.activitiesConductedVSTarget_Ach = achievement8TextField
        callTriple?.activitiesConductedVSTarget_Cmt = Comment8TextField
        callTriple?.avgPatientNumberEducated_Ach = achievement9TextField
        callTriple?.avgPatientNumberEducated_Cmt = Comment9TextField
        callTriple?.focusOnTeamRetention_Ach = achievement10TextField
        callTriple?.focusOnTeamRetention_Cmt = Comment10TextField
        callTriple?.diabetesAndNNProductUnderstanding_Ach = achievement11TextField
        callTriple?.diabetesAndNNProductUnderstanding_Cmt = Comment11TextField
        callTriple?.understandingProcessesImplementation_Ach = achievement12TextField
        callTriple?.understandingProcessesImplementation_Cmt = Comment12TextField
        callTriple?.attitude_Ach = achievement13TextField
        callTriple?.attitude_Cmt = Comment13TextField
        callTriple?.pCReportingTimelines_Ach = achievement14TextField
        callTriple?.pCReportingTimelines_Cmt = Comment14TextField
        callTriple?.teamManagementAndOrganization_Ach = achievement15TextField
        callTriple?.teamManagementAndOrganization_Cmt = Comment15TextField
        callTriple?.teamForQualityOrganization_Ach = achievement16TextField
        callTriple?.teamForQualityOrganization_Cmt = Comment16TextField
        callTriple?.dualWorkingWithDE_Ach = achievement17TextField
        callTriple?.dualWorkingWithDE_Cmt = Comment17TextField
        callTriple?.qualityOfFeedbackProvidedToDEs_Ach = achievement18TextField
        callTriple?.qualityOfFeedbackProvidedToDEs_Cmt = Comment18TextField
        callTriple?.coachingOfTeamMembers_Ach = achievement19TextField
        callTriple?.coachingOfTeamMembers_Cmt = Comment19TextField
        callTriple?.overAllComments = otherCommentTextField
        callTriple?.startlatitude = CommonUtils.getJsonFromUserDefaults(forKey: Constants.LatitudeKey)
        callTriple?.startlongitude = CommonUtils.getJsonFromUserDefaults(forKey: Constants.LongitudeKey)
        callTriple?.macAddress = "abc123"
        callTriple?.requestIdentifier = "7118D6F8-7111-4CB7-AEE8-15030DBED12A"
       
        
        callTriples.append(callTriple!)
        
        let tripleJsonString = Mapper().toJSONString(callTriples)!
        
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.triplePostData, withJson: tripleJsonString)
        
        CommonUtils.showMsgDialogWithOk(showingPopupOn: self, withTitle: "Novo", withMessage: "Form Submit Successfully", onOkClicked:{()
            self.dismiss(animated: true, completion: nil)
        })
        
    }
    
}

//        activitiyViewController.show(existingUiViewController: self)
//        var params = Dictionary<String, String>()
//
//        params["EmployeeExternalId"] = CommonUtils.getJsonFromUserDefaults(forKey: Constants.EMP_ID);
//        params["FormSubmitDate"] = provideddDate;
//        params["PC_ExternalId"] = CommonUtils.getJsonFromUserDefaults(forKey: Constants.selectedDoctorId)
//        params["NoOfCampsVisited"] = providedVisitNo;
//        params["PlanStatus"] = CommonUtils.getJsonFromUserDefaults(forKey: Constants.planStatus);
//        params["PCUnderstandingScopeActivity_Ach"] = achievement1TextField;
//        params["PCUnderstandingScopeActivity_Cmt"] = Comment1TextField;
//        params["TerritoryUnderstanding_Ach"] = achievement2TextField;
//        params["TerritoryUnderstanding_Cmt"] = Comment2TextField;
//        params["PCCoordinationWithHCP_Ach"] = achievement3TextField;
//        params["PCCoordinationWithHCP_Cmt"] = Comment3TextField;
//        params["RegularDiscussionsWithHCP_Ach"] = achievement4TextField;
//        params["RegularDiscussionsWithHCP_Cmt"] = Comment4TextField;
//        params["CollabWithOtherStakeHolder_Ach"] = achievement5TextField;
//        params["CollabWithOtherStakeHolder_Cmt"] = Comment5TextField;
//        params["PCCoordinationWithTeam_Ach"] = achievement6TextField;
//        params["PCCoordinationWithTeam_Cmt"] = Comment6TextField;
//        params["RegionalTargetKPI_Ach"] = achievement7TextField;
//        params["RegionalTargetKPI_Cmt"] = Comment7TextField;
//        params["ActivitiesConductedVSTarget_Ach"] = achievement8TextField;
//        params["ActivitiesConductedVSTarget_Cmt"] = Comment8TextField;
//        params["AvgPatientNumberEducated_Ach"] = achievement9TextField;
//        params["AvgPatientNumberEducated_Cmt"] = Comment9TextField;
//        params["FocusOnTeamRetention_Ach"] = achievement10TextField;
//        params["FocusOnTeamRetention_Cmt"] = Comment10TextField;
//        params["DiabetesAndNNProductUnderstanding_Ach"] = achievement11TextField;
//        params["DiabetesAndNNProductUnderstanding_Cmt"] = Comment12TextField;
//        params["UnderstandingProcessesImplementation_Ach"] = achievement12TextField;
//        params["UnderstandingProcessesImplementation_Cmt"] = Comment12TextField;
//        params["Attitude_Ach"] = achievement13TextField;
//        params["Attitude_Cmt"] = Comment13TextField;
//        params["PCReportingTimelines_Ach"] = achievement14TextField;
//        params["PCReportingTimelines_Cmt"] = Comment14TextField;
//        params["TeamManagementAndOrganization_Ach"] = achievement15TextField;
//        params["TeamManagementAndOrganization_Cmt"] = Comment15TextField;
//        params["TeamForQualityOrganization_Ach"] = achievement16TextField;
//        params["TeamForQualityOrganization_Cmt"] = Comment16TextField;
//        params["DualWorkingWithDE_Ach"] = achievement17TextField;
//        params["DualWorkingWithDE_Cmt"] = Comment17TextField;
//        params["QualityOfFeedbackProvidedToDEs_Ach"] = achievement18TextField;
//        params["QualityOfFeedbackProvidedToDEs_Cmt"] = Comment18TextField;
//        params["CoachingOfTeamMembers_Ach"] = achievement19TextField;
//        params["CoachingOfTeamMembers_Cmt"] = Comment19TextField;
//        params["OverAllComments"] = otherCommentTextField;
//
//
//
//        // Api Executed
//        AF.request(Constants.TripleVisitApi, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
//            .responseString(completionHandler: {(response) in
//                // On Response
//                self.activitiyViewController.dismiss(animated: true, completion: {() in
//
//                    //On Dialog Close
//                    if (response.error != nil) {
//                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please check your internet connection")
//                        return
//                    }
//
//                    let tripleVisitModel = Mapper<TripleVisitModel>().map(JSONString: response.value!) //JSON to model
//
//                    if tripleVisitModel != nil {
//
//                        if tripleVisitModel?.result == 1 {
//
//                            CommonUtils.showMsgDialogWithOk(showingPopupOn: self, withTitle: "Novo", withMessage: "Form successfully submitted", onOkClicked: {()
//
//                                self.dismiss(animated: true, completion: nil)
//                            })
//
//                        }else {
//                            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Invalid")
//                        }
//
//
//
//
//                    } else {
//                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: "Empty Response is coming from server")
//                    }
//                })
//            })
