//
//  OutstationVisitViewController.swift
//  E-detailer
//
//  Created by macbook on 25/07/2022.
//  Copyright © 2022 Ammad. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import ObjectMapper

class OutstationVisitViewController: UIViewController,UITextViewDelegate,UITextFieldDelegate,UIPickerViewDelegate, UIPickerViewDataSource  {
    
    @IBOutlet weak var visitPurposeTextField: UITextField!
    @IBOutlet weak var dELabelOutlet: UILabel!
    @IBOutlet weak var dENameTextField: UITextField!
    @IBOutlet weak var hCPNameTextField: UITextField!
    @IBOutlet weak var visitObjectiveTextField: UITextField!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var startActivityTextField: UITextField!
    @IBOutlet weak var compeleteActivityTextField: UITextField!
    
    var visitPurpose = ["Visit with DE", "Visit with PC","HCP Visit","Educational Activity" , "Other"]
    var indicator: UIActivityIndicatorView!
    var activitiyViewController: ActivityViewController!
    weak var pickerView: UIPickerView?
    weak var pickerView2: UIPickerView?
    var OutCalls : [MslActivityList] = []
    let datePicker = UIDatePicker()
    let endDatePicker = UIDatePicker()
    var hierarchyLevel = "0"
    var ali = "0"
    var pcName : [PlannedResult] = []
    var pcID: String?
    var maxLength : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.activitiyViewController = ActivityViewController(message: "Loading....")
        
        self.CallApi()
        
//        let date = Date()
//        let formatter = DateFormatter()
//        formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
//        let result = formatter.string(from: date)
//        startActivityTextField.text = result
        
        let date = Date()
        let formatter = DateFormatter()
        let apiFormatter = DateFormatter()
        apiFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        formatter.dateFormat = "dd-MM-YYYY"
        let planPasteDate = formatter.string(from: date)
        let apiPlanPasteDate = apiFormatter.string(from: date)
        self.startActivityTextField.text = planPasteDate
        
        
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.startTime, withJson: apiPlanPasteDate)
        self.hierarchyLevel = CommonUtils.getJsonFromUserDefaults(forKey: Constants.territoryCode)
        
        if self.hierarchyLevel == "200" {
            
//            self.PcNameLabel.text = "DE Name :"
            self.visitPurpose = ["Visit with DE","HCP Visit","Educational Activity" , "Other"]
            self.dELabelOutlet.text = "DE Name"
            
        }else {
            
            self.dELabelOutlet.text = "PC Name"
            self.visitPurpose = ["Visit with PC","HCP Visit","Educational Activity" , "Other"]
            
        }
        self.activitiyViewController = ActivityViewController(message: "Loading....")
        let pickerview2 = UIPickerView()
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerview2.delegate = self
        pickerview2.dataSource = self
        compeleteActivityTextField.delegate = self
        
        self.visitPurposeTextField.delegate = self
        visitPurposeTextField.inputView = pickerView
        self.dENameTextField.delegate = self
        dENameTextField.inputView = pickerview2
        self.EndDatePicker()
        
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
        
        visitPurposeTextField.inputAccessoryView = toolBar
        dENameTextField.inputAccessoryView = toolBar
        self.pickerView = pickerView
        self.pickerView2 = pickerview2
      
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == commentTextField{
            maxLength = 450
        }
        
        let currentString: NSString = textField.text! as NSString
        
        let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength ?? 0
        
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
        compeleteActivityTextField.inputAccessoryView = toolbar
        compeleteActivityTextField.inputView = endDatePicker
    }
    
    @objc func doneEndPicker(){
        
        let Formatter = DateFormatter()
        Formatter.dateFormat = "dd-MM-YYYY HH:mm:ss"
        let strDate = Formatter.string(from: endDatePicker.date)
        compeleteActivityTextField.text = strDate
        
        
        
        
        
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    @objc func donePicker(){
        self.visitPurposeTextField.resignFirstResponder()
        self.dENameTextField.resignFirstResponder()
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if visitPurposeTextField.isFirstResponder{
            return self.visitPurpose.count
        }else if dENameTextField.isFirstResponder{
            return self.pcName.count
           
        }
        
        return 0
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if visitPurposeTextField.isFirstResponder{
            return visitPurpose[row]
        }else if dENameTextField.isFirstResponder{
            return pcName[row].empName ?? ""
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if visitPurposeTextField.isFirstResponder{
            let itemselected = self.visitPurpose[row]
            visitPurposeTextField.text = itemselected
//            self.pcID = self.pcName[row].empId
        }else if dENameTextField.isFirstResponder{
                let itemselected = self.pcName[row].empName ?? ""
                self.dENameTextField.text = itemselected
                self.pcID = self.pcName[row].empId
           
        }
    }
    
    @IBAction func submitBtn(_ sender: Any) {
        let activityType = CommonUtils.getJsonFromUserDefaults(forKey: Constants.activity)
        
        if visitPurposeTextField.text == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please enter HCP Name")
            return
        }
        if dENameTextField.text == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please enter HCP Name")
            return
        }
        if hCPNameTextField.text == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please enter HCP Name")
            return
        }
        if commentTextField.text == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please enter HCP Name")
            return
        }
        if startActivityTextField.text == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please enter HCP Name")
            return
        }
//        if compeleteActivityTextField.text == "" {
//            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please enter HCP Name")
//            return
//        }
      
        var Oudata = CommonUtils.getJsonFromUserDefaults(forKey: Constants.OutPostData)
        if (Oudata == "") {Oudata = "[]"}
        
        var OutLists:[MslActivityList] = Mapper<MslActivityList>().mapArray(JSONString: Oudata)!
        
        var OutList = MslActivityList(map: Map(mappingType: .fromJSON, JSON: [:]))
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        let result = formatter.string(from: date)
        
        OutList?.noOfHcp = hCPNameTextField.text
        OutList?.empId = CommonUtils.getJsonFromUserDefaults(forKey: Constants.EMP_ID)
        OutList?.activityType = CommonUtils.getJsonFromUserDefaults(forKey: Constants.activity)
        OutList?.comment = commentTextField.text
//        EduList?.startTime = CommonUtils.getJsonFromUserDefaults(forKey: Constants.eduStr)
//        EduList?.endTime = Endresult
        OutList?.startLat = CommonUtils.getJsonFromUserDefaults(forKey: Constants.LatitudeKey)
        OutList?.startLng = CommonUtils.getJsonFromUserDefaults(forKey: Constants.LongitudeKey)
        OutList?.endLat = CommonUtils.getJsonFromUserDefaults(forKey: Constants.LatitudeKey)
        OutList?.endLng = CommonUtils.getJsonFromUserDefaults(forKey: Constants.LongitudeKey)
        OutList?.doctorInternalId = Int(self.pcID ?? "")
//        OutList?.startTime = startActivityTextField.text
        
        OutList?.startTime = CommonUtils.getJsonFromUserDefaults(forKey: Constants.startTime)
        OutList?.endTime = result
        OutList?.VisitPurpose = visitPurposeTextField.text
        OutList?.VisitObjective = visitObjectiveTextField.text
        
        OutLists.append(OutList!)
        
        let outJsonString = Mapper().toJSONString(OutLists)!
        
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.OutPostData, withJson: outJsonString)
        
        let outdata = CommonUtils.getJsonFromUserDefaults(forKey: Constants.OutPostData)
        
        if outdata == "" || outdata == "[]" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "No Data available to preview")
            return
        }
        
        OutCalls = Mapper<MslActivityList>().mapArray(JSONString: outdata)!
        
        var req = MSLActivityModel(map: Map(mappingType: .fromJSON, JSON: [:]))
        
        req?.mslActivityList = OutCalls
        
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
                            
                            CommonUtils.saveJsonToUserDefaults(forKey: Constants.EduPostData, withJson: "[]")
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
                        CommonUtils.showMsgDialogWithOk(showingPopupOn: self, withTitle: "Novo", withMessage: "Please check your internet connection", onOkClicked: {()
                            
                            self.dismiss(animated: true, completion: nil)
                        })
                        return
                    }
                    
                    let plannedDoctorModel = Mapper<PlannedDoctorModel>().map(JSONString: response.value!) //JSON to model
                    
                    if plannedDoctorModel != nil {
                        if (plannedDoctorModel?.success)! {
                            
                            self.pcName = plannedDoctorModel?.result ?? []
                            self.pickerView2?.reloadAllComponents()
                            
                        } else {
                            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (plannedDoctorModel?.error!)!)
                        }
                        
                        
                    } else {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: "Empty Response is coming from server")
                    }
                })
            })
        
    }
    
    @IBAction func onBackClicked(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
}


