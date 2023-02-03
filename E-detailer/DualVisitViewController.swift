//
//  DualVisitViewController.swift
//  E-detailer
//
//  Created by macbook on 30/12/2021.
//  Copyright © 2021 Ammad. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import ObjectMapper

class DualVisitViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var acivityEndTime: UITextField!
    @IBOutlet weak var nameTextFiled: UITextField!
    @IBOutlet weak var designationTextfield: UITextField!
    @IBOutlet weak var hcpNameTextField: UITextField!
    @IBOutlet weak var activityStartTimeTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var clinicNameTextField: UITextField!
    @IBOutlet weak var otherCommentsTextField: UITextView!
    @IBOutlet weak var achievement1TextField: UITextField!
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
    @IBOutlet weak var comment1TextField: UITextField!
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
    @IBOutlet weak var namePCTextField: UITextField!
    
    var indicator: UIActivityIndicatorView!
    var activitiyViewController: ActivityViewController!
    var lblPlaceHolder : UILabel!
    let datePicker = UIDatePicker()
    var maxLength : Int?
    let startDatePicker = UIDatePicker()
    let endDatePicker = UIDatePicker()
    var startTime: String?
    
    func textViewDidChange(_ textView: UITextView) {
        lblPlaceHolder.isHidden = !textView.text.isEmpty
    }
    
    override func viewDidLoad() {
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-YYYY HH:mm:ss"
        let result = formatter.string(from: date)
        activityStartTimeTextField.text = result
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.startTime, withJson: result)
        designationTextfield.text = CommonUtils.getJsonFromUserDefaults(forKey: Constants.designation)
        otherCommentsTextField.delegate = self
        lblPlaceHolder = UILabel()
        lblPlaceHolder.text = "Enter your conversation with patient"
        lblPlaceHolder.font = UIFont.systemFont(ofSize: otherCommentsTextField.font!.pointSize)
        lblPlaceHolder.sizeToFit()
        otherCommentsTextField.addSubview(lblPlaceHolder)
        lblPlaceHolder.frame.origin = CGPoint(x: 5, y: (otherCommentsTextField.font?.pointSize)! / 2)
        lblPlaceHolder.textColor = UIColor.lightGray
        lblPlaceHolder.isHidden = !otherCommentsTextField.text.isEmpty
        activitiyViewController = ActivityViewController(message: "Loading...")
        self.otherCommentsTextField.layer.borderColor = UIColor.lightGray.cgColor
        self.otherCommentsTextField.layer.borderWidth = 1.0
        self.otherCommentsTextField.layer.cornerRadius = 8
        self.nameTextFiled.text = CommonUtils.getJsonFromUserDefaults(forKey: Constants.Emp_Name)
        self.namePCTextField.text = CommonUtils.getJsonFromUserDefaults(forKey: Constants.selectedName)
        self.EndDatePicker()
        acivityEndTime.delegate = self
        hcpNameTextField.delegate = self
        activityStartTimeTextField.delegate = self
        cityTextField.delegate = self
        clinicNameTextField.delegate = self
        otherCommentsTextField.delegate = self
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
        comment1TextField.delegate = self
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
        startTime = String(CommonUtils.getCurrentTime())
        
    }
    
    func EndDatePicker(){
        //Formate Date
        endDatePicker.datePickerMode = .dateAndTime
        endDatePicker.minimumDate = Date()
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneEndPicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        acivityEndTime.inputAccessoryView = toolbar
        acivityEndTime.inputView = endDatePicker
    }
    
    @objc func doneEndPicker(){
        
        let Formatter = DateFormatter()
        Formatter.dateFormat = "dd-MM-YYYY HH:mm:ss"
        let strDate = Formatter.string(from: endDatePicker.date)
        acivityEndTime.text = strDate
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == acivityEndTime{
            maxLength = 80
        }else if textField == hcpNameTextField{
            maxLength = 160
        }else if textField == activityStartTimeTextField{
            maxLength = 80
        }else if textField == cityTextField{
            maxLength = 80
        }else if textField == clinicNameTextField{
            maxLength = 150
        }else if textField == otherCommentsTextField{
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
        }else if textField == comment1TextField{
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
        }
        
        let currentString: NSString = textField.text! as NSString
        
        let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength ?? 0
        
    }
    
    func textView(_ tsextView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (otherCommentsTextField.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        return numberOfChars < 500    // 10 Limit Value
    }
    
    @IBAction func onBackClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func oNSaveClicked(_ sender: Any) {
        
        let provideddTime = activityStartTimeTextField.text
        let providedEndTime = acivityEndTime.text
        let provideCity = cityTextField.text
        let provideClinicName = clinicNameTextField.text
        let HCPName = hcpNameTextField.text
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
        let Comment1TextField = comment1TextField.text
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
        let otherCommentTextField = otherCommentsTextField.text
        
        if provideddTime == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if providedEndTime == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if provideCity == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if provideClinicName == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if provideClinicName == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if HCPName == "" {
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
        if otherCommentTextField == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-YYYY HH:mm:ss"
        let endResult = formatter.string(from: date)
        
        var data = CommonUtils.getJsonFromUserDefaults(forKey: Constants.dualPostData)
        if (data == "") {data = "[]"}
        
        var callDuals:[DualVisitCallSync] = Mapper<DualVisitCallSync>().mapArray(JSONString: data)!
        
        var callDual = DualVisitCallSync(map: Map(mappingType: .fromJSON, JSON: [:]))
        
        callDual?.activityEndTime = CommonUtils.getCurrentTime()
        callDual?.activityStartTime = Double(startTime ?? "")
        callDual?.employeeExternalId = CommonUtils.getJsonFromUserDefaults(forKey: Constants.EMP_ID);
        callDual?.city = provideCity
        callDual?.dE_ExternalId = CommonUtils.getJsonFromUserDefaults(forKey: Constants.selectedDoctorId);
        callDual?.clinicName = provideClinicName
        callDual?.planStatus = CommonUtils.getJsonFromUserDefaults(forKey: Constants.planStatus);
        callDual?.hCPName = HCPName
        callDual?.patientEducation_Ach = achievement1TextField
        callDual?.patientEducation_Cmt = Comment1TextField
        callDual?.avgTimeForPatientEducation_Ach = achievement2TextField
        callDual?.avgTimeForPatientEducation_Cmt = Comment2TextField
        callDual?.nNDeviceDemo_Ach = achievement3TextField
        callDual?.nNDeviceDemo_Cmt = Comment3TextField
        callDual?.diabetesUnderstanding_Ach = achievement4TextField
        callDual?.diabetesUnderstanding_Cmt = Comment4TextField
        callDual?.nNProductUnderstanding_Ach = achievement5TextField
        callDual?.nNProductUnderstanding_Cmt = Comment5TextField
        callDual?.educationalMaterialUsage_Ach = achievement6TextField
        callDual?.educationalMaterialUsage_Cmt = Comment6TextField
        callDual?.effectiveResourceUse_Ach = achievement7TextField
        callDual?.effectiveResourceUse_Cmt = Comment7TextField
        callDual?.timelinesComplianceReport_Ach = achievement8TextField
        callDual?.timelinesComplianceReport_Cmt = Comment8TextField
        callDual?.attire_Ach = achievement9TextField
        callDual?.attire_Cmt = Comment9TextField
        callDual?.punctuality_Ach = achievement10TextField
        callDual?.punctuality_Cmt = Comment10TextField
        callDual?.patientSatisfactionLevel_Ach = achievement11TextField
        callDual?.patientSatisfactionLevel_Cmt = Comment11TextField
        callDual?.hCPFeedback_Ach = achievement12TextField
        callDual?.hCPFeedback_Cmt = Comment12TextField
        callDual?.overallComment = otherCommentTextField
        callDual?.startlatitude = CommonUtils.getJsonFromUserDefaults(forKey: Constants.LatitudeKey)
        callDual?.startlongitude = CommonUtils.getJsonFromUserDefaults(forKey: Constants.LongitudeKey)
        callDual?.macAddress = "abc"
        callDual?.requestIdentifier = "7118D6F8-7111-4CB7-AEE8-15030DBED12A"
        callDual?.employeeDate = endResult
        callDual?.coordinatorDate = endResult
        
        callDuals.append(callDual!)
        
        let dualJsonString = Mapper().toJSONString(callDuals)!
        
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.dualPostData, withJson: dualJsonString)
        
        CommonUtils.showMsgDialogWithOk(showingPopupOn: self, withTitle: "Novo", withMessage: "Form Submit Successfully", onOkClicked:{()
            self.dismiss(animated: true, completion: nil)
        })
        
    }
    
}

//        if (self.currentCall?.calls == nil)
//        { self.currentCall?.calls = [] }
//
//        self.currentCall?.calls?.append(Calls(map: Map(mappingType: .fromJSON, JSON: [:]))!)
//        let index = (self.currentCall?.calls?.count ?? 0) - 1
//
//        currentCall?.calls![index].employeeId = CommonUtils.getJsonFromUserDefaults(forKey: Constants.EMP_ID)
//        currentCall?.calls![index].lat = CommonUtils.getJsonFromUserDefaults(forKey: Constants.LatitudeKey)
//        currentCall?.calls![index].lng = CommonUtils.getJsonFromUserDefaults(forKey: Constants.LongitudeKey)
//        currentCall?.calls![index].startTime = provideddTime
//        currentCall?.calls![index].endTime = endResult
//        currentCall?.calls![index].mACAddress = "C0:F4:E6:6C:F7:F0"

//        AF.request(Constants.DualVisitApi, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
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
//                    let dualVisitModel = Mapper<DualVisitModel>().map(JSONString: response.value!) //JSON to model
//
//                    if dualVisitModel != nil {
//
//                        if dualVisitModel?.result == 1 {
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
//                    } else {
//                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: "Empty Response is coming from server")
//                    }
//                })
//            })
