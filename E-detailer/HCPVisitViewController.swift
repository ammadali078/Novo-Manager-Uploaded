//
//  HCPVisitViewController.swift
//  E-detailer
//
//  Created by macbook on 08/02/2022.
//  Copyright © 2022 Ammad. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import ObjectMapper
import DatePickerDialog

class HCPVisitViewController: UIViewController,UITextViewDelegate,UITextFieldDelegate,UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var PcNameLabel: UILabel!
    @IBOutlet weak var PCNameTextField: UITextField!
    @IBOutlet weak var activityTypeOutlet: UITextField!
    @IBOutlet weak var startActivityLabel: UITextField!
    @IBOutlet weak var completeActivityLabel: UITextField!
    @IBOutlet weak var addCommentTextView: UITextView!
    var lblPlaceHolder : UILabel!
    var indicator: UIActivityIndicatorView!
    var activitiyViewController: ActivityViewController!
    var calls: [MslActivityList] = []
    weak var pickerView: UIPickerView?
    let endDatePicker = UIDatePicker()
    var activityType = ["Admin day", "Training","Educational Activity" , "Meeting","HCP Visit","Other"]
    var pcName : [PlannedResult] = []
    var pcID: String?
    var hierarchyLevel = "0"
    var maxLength : Int?
    
    func textViewDidChange(_ textView: UITextView) {
        lblPlaceHolder.isHidden = !textView.text.isEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hierarchyLevel = CommonUtils.getJsonFromUserDefaults(forKey: Constants.territoryCode)
        
        if self.hierarchyLevel == "200" {
            
            self.PcNameLabel.text = "DE Name :"
            
        }else {
            
            self.PcNameLabel.text = "PC Name :"
            
        }
        
//        let date = Date()
//        let formatter = DateFormatter()
//        formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
//        let result = formatter.string(from: date)
//        startActivityLabel.text = result
        
        let date = Date()
        let formatter = DateFormatter()
        let apiFormatter = DateFormatter()
        apiFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        formatter.dateFormat = "dd-MM-YYYY"
        let planPasteDate = formatter.string(from: date)
        let apiPlanPasteDate = apiFormatter.string(from: date)
        self.startActivityLabel.text = planPasteDate
        
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.HCPDate, withJson: apiPlanPasteDate)
        
        addCommentTextView.delegate = self
        lblPlaceHolder = UILabel()
        lblPlaceHolder.text = "Enter your other Comments"
        lblPlaceHolder.font = UIFont.systemFont(ofSize: addCommentTextView.font!.pointSize)
        lblPlaceHolder.sizeToFit()
        addCommentTextView.addSubview(lblPlaceHolder)
        lblPlaceHolder.frame.origin = CGPoint(x: 5, y: (addCommentTextView.font?.pointSize)! / 2)
        lblPlaceHolder.textColor = UIColor.lightGray
        lblPlaceHolder.isHidden = !addCommentTextView.text.isEmpty
        self.addCommentTextView.layer.borderColor = UIColor.lightGray.cgColor
        self.addCommentTextView.layer.borderWidth = 1.0
        self.addCommentTextView.layer.cornerRadius = 8
        self.EndDatePicker()
        activitiyViewController = ActivityViewController(message: "Loading...")
        
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        
        self.activityTypeOutlet.delegate = self
        activityTypeOutlet.inputView = pickerView
        
        self.PCNameTextField.delegate = self
        PCNameTextField.inputView = pickerView
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.donePicker))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        
        toolBar.isUserInteractionEnabled = true
        
        activityTypeOutlet.inputAccessoryView = toolBar
        PCNameTextField.inputAccessoryView = toolBar
        self.pickerView = pickerView
        self.CallApi()
        
    }
    
    func textView(_ tsextView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (addCommentTextView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        return numberOfChars < 450    // 10 Limit Value
    }
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//
//        if textField == addCommentTextView{
//            maxLength = 450
//        }
//
//        let currentString: NSString = textField.text! as NSString
//
//        let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
//        return newString.length <= maxLength ?? 0
//
//    }
    
    @objc func donePicker(){
        self.activityTypeOutlet.resignFirstResponder()
        self.PCNameTextField.resignFirstResponder()
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if activityTypeOutlet.isFirstResponder{
            return self.activityType.count
        }else if PCNameTextField.isFirstResponder{
            return self.pcName.count ?? 0
        }
        
        return 0
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if activityTypeOutlet.isFirstResponder{
            return activityType[row]
        }else if PCNameTextField.isFirstResponder{
            return pcName[row].empName
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if activityTypeOutlet.isFirstResponder{
            let itemselected = self.activityType[row]
            activityTypeOutlet.text = itemselected
            //            self.pcID = self.pcName[row].empId
        }else if PCNameTextField.isFirstResponder{
            let itemselected = self.pcName[row].empName
            PCNameTextField.text = itemselected
            self.pcID = self.pcName[row].empId
        }
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
        completeActivityLabel.inputAccessoryView = toolbar
        completeActivityLabel.inputView = endDatePicker
    }
    
    @objc func doneEndPicker(){
        
        let Formatter = DateFormatter()
        Formatter.dateFormat = "dd-MM-YYYY HH:mm:ss"
        let strDate = Formatter.string(from: endDatePicker.date)
        completeActivityLabel.text = strDate
        
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    @IBAction func submitBtn(_ sender: Any) {
        
        let activityType = CommonUtils.getJsonFromUserDefaults(forKey: Constants.activity)
        
        if activityTypeOutlet.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter Activity Type")
            return
        }
        
        //        if PCNameTextField.text == "" {
        //
        //            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter PC Name ")
        //            return
        //        }
        
        //        if completeActivityLabel.text == "" {
        //
        //            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter Compelete Activity")
        //            return
        //        }
        
        if addCommentTextView.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter Comments")
            return
        }
        
        //        activitiyViewController.show(existingUiViewController: self)
        //        var params = Dictionary<String, String>()
        //
        //        params["ActivityType"] = activityType;
        //        params["Comment"] = addCommentTextView.text;
        //        params["EmpId"] = activityType;
        //        params["Comment"] = addCommentTextView.text;
        //        params["ActivityType"] = activityType;
        //        params["Comment"] = addCommentTextView.text;
        //        params["ActivityType"] = activityType;
        //        params["Comment"] = addCommentTextView.text;
        
        var Hdata = CommonUtils.getJsonFromUserDefaults(forKey: Constants.HcpPostData)
        if (Hdata == "") {Hdata = "[]"}
        
        var MslLists:[MslActivityList] = Mapper<MslActivityList>().mapArray(JSONString: Hdata)!
        
        var MslList = MslActivityList(map: Map(mappingType: .fromJSON, JSON: [:]))
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        let result = formatter.string(from: date)
        
        MslList?.activityType = activityTypeOutlet.text
        MslList?.comment = addCommentTextView.text
        MslList?.empId = CommonUtils.getJsonFromUserDefaults(forKey: Constants.EMP_ID)
        MslList?.startLat = CommonUtils.getJsonFromUserDefaults(forKey: Constants.LatitudeKey)
        MslList?.startLng = CommonUtils.getJsonFromUserDefaults(forKey: Constants.LongitudeKey)
        MslList?.endLat = CommonUtils.getJsonFromUserDefaults(forKey: Constants.LatitudeKey)
        MslList?.endLng = CommonUtils.getJsonFromUserDefaults(forKey: Constants.LongitudeKey)
        
        //        MslList?.startTime = String(CommonUtils.getCurrentTime())
        //
        //        if let startTime = MslList?.startTime {
        //            if startTime.contains(".") {
        //                MslList?.startTime = String(startTime.split(separator: ".")[0])
        //            }
        //        }
        
        MslList?.startTime = CommonUtils.getJsonFromUserDefaults(forKey: Constants.HCPDate)
//        MslList?.startTime = startActivityLabel.text
        
        //        MslList?.startTime = "2022-01-20 00:18:49.0040899"
        
        MslList?.endTime = result
        
        //        MslList?.endTime = String(CommonUtils.getCurrentTime())
        //
        //        if let endTime = MslList?.endTime {
        //            if endTime.contains(".") {
        //                MslList?.endTime = String(endTime.split(separator: ".")[0])
        //            }
        //        }
        //        MslList?.endTime = result
        
        MslLists.append(MslList!)
        
        let dualJsonString = Mapper().toJSONString(MslLists)!
        
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.HcpPostData, withJson: dualJsonString)
        
        let hCdata = CommonUtils.getJsonFromUserDefaults(forKey: Constants.HcpPostData)
        
        if hCdata == "" || hCdata == "[]" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "No Data available to preview")
            return
        }
        
        calls = Mapper<MslActivityList>().mapArray(JSONString: hCdata)!
        
        var req = MSLActivityModel(map: Map(mappingType: .fromJSON, JSON: [:]))
        
        req?.mslActivityList = calls
        
        //        var req = MSLActivityModel(map: Map(mappingType: .fromJSON, JSON: [:]))
        
        //        req?.mslActivityList?[0].activityType = activityType
        //        req?.mslActivityList?[0].comment = addCommentTextView.text
        //        req?.mslActivityList?[0].empId = CommonUtils.getJsonFromUserDefaults(forKey: Constants.EMP_ID)
        //        req?.mslActivityList?[0].startTime = startActivityLabel.text
        //        req?.mslActivityList?[0].endTime = completeActivityLabel.text
        
        activitiyViewController.show(existingUiViewController: self)
        
        let a = req?.toJSON()
        
        //        MSLActivityApi
        Alamofire.request(Constants.MSLActivityApi, method: .post, parameters: a, encoding: JSONEncoding.default, headers: nil)
            .responseString(completionHandler: {(response) in
                // On Response
                self.activitiyViewController.dismiss(animated: false, completion: {() in
                    
                    //On Dialog Close
                    if (response.error != nil) {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (response.error?.localizedDescription)!)
                        return
                    }
                    
                    let loginModel = Mapper<DualVisitModel>().map(JSONString: response.value!) //JSON to model
                    
                    if (loginModel?.result == "") {
                        
                        CommonUtils.showMsgDialogWithOk(showingPopupOn: self, withTitle: "Novo", withMessage: "Activity Synced Successfully", onOkClicked: {()
                            
                            CommonUtils.saveJsonToUserDefaults(forKey: Constants.HcpPostData, withJson: "[]")
                            self.dismiss(animated: false, completion: nil)
                            
                        })
                        
                    } else {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: response.value!)
                    }
                })
            })
        
    }
    
    func CallApi() {
        
        activitiyViewController.show(existingUiViewController: self)
        let empId = CommonUtils.getJsonFromUserDefaults(forKey: Constants.EMP_ID)
        
        var params = Dictionary<String, String>()
        
        params["empId"] = empId;
        
        Alamofire.request(Constants.getUnPlannedApi, method: .get, parameters: params, encoding: URLEncoding(destination: .queryString), headers: nil)
            .responseString(completionHandler: {(response) in
                // On Response
                self.activitiyViewController.dismiss(animated: true, completion: {() in
                    
                    //On Dialog Close
                    if (response.error != nil) {
                        //                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please check your internet connection")
                        //                        return
                        CommonUtils.showMsgDialogWithOk(showingPopupOn: self, withTitle: "Novo", withMessage: "Please check your internet connection", onOkClicked: {()
                            
                            self.dismiss(animated: true, completion: nil)
                        })
                        return
                    }
                    
                    let plannedDoctorModel = Mapper<PlannedDoctorModel>().map(JSONString: response.value!) //JSON to model
                    
                    if plannedDoctorModel != nil {
                        if (plannedDoctorModel?.success)! {
                            
                            self.pcName = plannedDoctorModel?.result ?? []
                            self.pickerView?.reloadAllComponents()
                            
                        } else {
                            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (plannedDoctorModel?.error!)!)
                        }
                        
                    } else {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: "Empty Response is coming from server")
                    }
                })
            })
    }
}
