//
//  PerformanceEvaluationPCController.swift
//  E-detailer
//
//  Created by macbook on 10/01/2022.
//  Copyright © 2022 Ammad. All rights reserved.
//


import Foundation
import UIKit
import Alamofire
import ObjectMapper

class PerformanceEvaluationPCController: UIViewController, UITextFieldDelegate,UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var pcNameTextField: UITextField!
    @IBOutlet weak var designationTextField: UITextField!
    @IBOutlet weak var baseTownTextField: UITextField!
    @IBOutlet weak var priorityGoal1: UITextField!
    @IBOutlet weak var priorityKPI1: UITextField!
    @IBOutlet weak var priorityTarget1: UITextField!
    @IBOutlet weak var priorityComment1: UITextField!
    @IBOutlet weak var priorityGoal2: UITextField!
    @IBOutlet weak var priorityKPI2: UITextField!
    @IBOutlet weak var priorityTarget2: UITextField!
    @IBOutlet weak var priorityComment2: UITextField!
    @IBOutlet weak var priorityGoal3: UITextField!
    @IBOutlet weak var priorityKPI3: UITextField!
    @IBOutlet weak var priorityTarget3: UITextField!
    @IBOutlet weak var priorityComment3: UITextField!
    @IBOutlet weak var priorityGoal4: UITextField!
    @IBOutlet weak var priorityKPI4: UITextField!
    @IBOutlet weak var priorityTarget4: UITextField!
    @IBOutlet weak var priorityComment4: UITextField!
    @IBOutlet weak var teamGoal1: UITextField!
    @IBOutlet weak var teamGoal2: UITextField!
    @IBOutlet weak var teamGoal3: UITextField!
    @IBOutlet weak var teamGoal4: UITextField!
    @IBOutlet weak var teamTarget1: UITextField!
    @IBOutlet weak var teamTarget2: UITextField!
    @IBOutlet weak var teamTarget3: UITextField!
    @IBOutlet weak var teamTarget4: UITextField!
    @IBOutlet weak var teamKPI1: UITextField!
    @IBOutlet weak var teamKPI2: UITextField!
    @IBOutlet weak var teamKPI3: UITextField!
    @IBOutlet weak var teamKPI4: UITextField!
    @IBOutlet weak var teamComment1: UITextField!
    @IBOutlet weak var teamComment2: UITextField!
    @IBOutlet weak var teamComment3: UITextField!
    @IBOutlet weak var teamComment4: UITextField!
    @IBOutlet weak var IndividualGoal1: UITextField!
    @IBOutlet weak var IndividualGoal2: UITextField!
    @IBOutlet weak var IndividualGoal3: UITextField!
    @IBOutlet weak var IndividualGoal4: UITextField!
    @IBOutlet weak var IndividualTarget1: UITextField!
    @IBOutlet weak var IndividualTarget2: UITextField!
    @IBOutlet weak var IndividualTarget3: UITextField!
    @IBOutlet weak var IndividualTarget4: UITextField!
    @IBOutlet weak var IndividualKPI1: UITextField!
    @IBOutlet weak var IndividualKPI2: UITextField!
    @IBOutlet weak var IndividualKPI3: UITextField!
    @IBOutlet weak var IndividualKPI4: UITextField!
    @IBOutlet weak var IndividualComment1: UITextField!
    @IBOutlet weak var IndividualComment2: UITextField!
    @IBOutlet weak var IndividualComment3: UITextField!
    @IBOutlet weak var IndividualComment4: UITextField!
    
    var indicator: UIActivityIndicatorView!
    var activitiyViewController: ActivityViewController!
    weak var pickerView: UIPickerView?
    var pcName : [PlannedResult] = []
    var pcID: String?
    var PGoal: [String] = ["", "" , "", ""]
    var PKPI: [String] = ["", "" , "", ""]
    var PTarget: [String] = ["", "" , "", ""]
    var PComment: [String] = ["", "" , "", ""]
    var TGoal: [String] = ["", "" , "", ""]
    var TKPI: [String] = ["", "" , "", ""]
    var TTarget: [String] = ["", "" , "", ""]
    var TComment: [String] = ["", "" , "", ""]
    var IGoal: [String] = ["", "" , "", ""]
    var IKPI: [String] = ["", "" , "", ""]
    var ITarget: [String] = ["", "" , "", ""]
    var IComment: [String] = ["", "" , "", ""]
    var startTime: String?
    var maxLength : Int?
    
    
    override func viewDidLoad() {
        
        activitiyViewController = ActivityViewController(message: "Loading...")
        
        self.CallApi()
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        
        startTime = String(CommonUtils.getCurrentTime())
        
        self.pcNameTextField.delegate = self
        pcNameTextField.inputView = pickerView
        
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
        
        pcNameTextField.inputAccessoryView = toolBar
        self.pickerView = pickerView
        
        self.priorityGoal1.delegate = self
        self.priorityKPI1.delegate = self
        self.priorityTarget1.delegate = self
        self.priorityComment1.delegate = self
        self.priorityGoal2.delegate = self
        self.priorityKPI2.delegate = self
        self.priorityTarget2.delegate = self
        self.priorityComment2.delegate = self
        self.priorityGoal3.delegate = self
        self.priorityKPI3.delegate = self
        self.priorityTarget3.delegate = self
        self.priorityComment3.delegate = self
        self.priorityGoal4.delegate = self
        self.priorityKPI4.delegate = self
        self.priorityTarget4.delegate = self
        self.priorityComment4.delegate = self
        self.teamGoal1.delegate = self
        self.teamGoal2.delegate = self
        self.teamGoal3.delegate = self
        self.teamGoal4.delegate = self
        self.teamTarget1.delegate = self
        self.teamTarget2.delegate = self
        self.teamTarget3.delegate = self
        self.teamTarget4.delegate = self
        self.teamKPI1.delegate = self
        self.teamKPI2.delegate = self
        self.teamKPI3.delegate = self
        self.teamKPI4.delegate = self
        self.teamComment1.delegate = self
        self.teamComment2.delegate = self
        self.teamComment3.delegate = self
        self.teamComment4.delegate = self
        self.IndividualGoal1.delegate = self
        self.IndividualGoal2.delegate = self
        self.IndividualGoal3.delegate = self
        self.IndividualGoal4.delegate = self
        self.IndividualTarget1.delegate = self
        self.IndividualTarget2.delegate = self
        self.IndividualTarget3.delegate = self
        self.IndividualTarget4.delegate = self
        self.IndividualKPI1.delegate = self
        self.IndividualKPI2.delegate = self
        self.IndividualKPI3.delegate = self
        self.IndividualKPI4.delegate = self
        self.IndividualComment1.delegate = self
        self.IndividualComment2.delegate = self
        self.IndividualComment3.delegate = self
        self.IndividualComment4.delegate = self
        
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == priorityGoal1{
            maxLength = 50
        }else if textField == priorityKPI1{
            maxLength = 50
        }else if textField == priorityTarget1{
            maxLength = 50
        }else if textField == priorityComment1{
            maxLength = 50
        }else if textField == priorityGoal2{
            maxLength = 50
        }else if textField == priorityKPI2{
            maxLength = 50
        }else if textField == priorityTarget2{
            maxLength = 50
        }else if textField == priorityComment2{
            maxLength = 50
        }else if textField == priorityGoal3{
            maxLength = 50
        }else if textField == priorityKPI3{
            maxLength = 50
        }else if textField == priorityTarget3{
            maxLength = 50
        }else if textField == priorityComment3{
            maxLength = 50
        }else if textField == priorityGoal4{
            maxLength = 50
        }else if textField == priorityKPI4{
            maxLength = 50
        }else if textField == priorityTarget4{
            maxLength = 50
        }else if textField == priorityComment4{
            maxLength = 50
        }else if textField == teamGoal1{
            maxLength = 50
        }else if textField == teamTarget1{
            maxLength = 50
        }else if textField == teamKPI1{
            maxLength = 50
        }else if textField == teamComment1{
            maxLength = 50
        }else if textField == teamGoal2{
            maxLength = 50
        }else if textField == teamTarget2{
            maxLength = 50
        }else if textField == teamKPI2{
            maxLength = 50
        }else if textField == teamComment2{
            maxLength = 50
        }else if textField == teamGoal3{
            maxLength = 50
        }else if textField == teamTarget3{
            maxLength = 50
        }else if textField == teamKPI3{
            maxLength = 50
        }else if textField == teamComment3{
            maxLength = 50
        }else if textField == teamGoal4{
            maxLength = 50
        }else if textField == teamTarget4{
            maxLength = 50
        }else if textField == teamKPI4{
            maxLength = 50
        }else if textField == teamComment4{
            maxLength = 50
        }else if textField == IndividualGoal1{
            maxLength = 50
        }else if textField == IndividualTarget1{
            maxLength = 50
        }else if textField == IndividualKPI1{
            maxLength = 50
        }else if textField == IndividualComment1{
            maxLength = 50
        }else if textField == IndividualGoal2{
            maxLength = 50
        }else if textField == IndividualTarget2{
            maxLength = 50
        }else if textField == IndividualKPI2{
            maxLength = 50
        }else if textField == IndividualComment2{
            maxLength = 50
        }else if textField == IndividualGoal3{
            maxLength = 50
        }else if textField == IndividualTarget3{
            maxLength = 50
        }else if textField == IndividualKPI3{
            maxLength = 50
        }else if textField == IndividualComment3{
            maxLength = 50
        }else if textField == IndividualGoal4{
            maxLength = 50
        }else if textField == IndividualTarget4{
            maxLength = 50
        }else if textField == IndividualKPI4{
            maxLength = 50
        }else if textField == IndividualComment4{
            maxLength = 50
        }
        
        let currentString: NSString = textField.text! as NSString
        
        let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength ?? 0
        
    }
    
    @objc func donePicker(){
        self.pcNameTextField.resignFirstResponder()
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pcNameTextField.isFirstResponder{
            return self.pcName.count ?? 0
        }
        
        return 0
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pcNameTextField.isFirstResponder{
            return pcName[row].empName
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pcNameTextField.isFirstResponder{
            let itemselected = self.pcName[row].empName
            pcNameTextField.text = itemselected
            self.pcID = self.pcName[row].empId
            self.designationTextField.text = "Project Coordinator"
        }
    }
    
    @IBAction func onBackClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSaveClicked(_ sender: Any) {
        callVisitApi()
    }
    
    func CallApi() {
        
        let empId = CommonUtils.getJsonFromUserDefaults(forKey: Constants.EMP_ID)
        
        activitiyViewController.show(existingUiViewController: self)
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
    
    func callVisitApi() {
        
        self.PGoal[0] = self.priorityGoal1.text ?? ""
        self.PGoal[1] = self.priorityGoal2.text ?? ""
        self.PGoal[2] = self.priorityGoal3.text ?? ""
        self.PGoal[3] = self.priorityGoal4.text ?? ""
        self.PTarget[0] = self.priorityTarget1.text ?? ""
        self.PTarget[1] = self.priorityTarget2.text ?? ""
        self.PTarget[2] = self.priorityTarget3.text ?? ""
        self.PTarget[3] = self.priorityTarget4.text ?? ""
        self.PKPI[0] = self.priorityKPI1.text ?? ""
        self.PKPI[1] = self.priorityKPI2.text ?? ""
        self.PKPI[2] = self.priorityKPI3.text ?? ""
        self.PKPI[3] = self.priorityKPI4.text ?? ""
        self.PComment[0] = self.priorityComment1.text ?? ""
        self.PComment[1] = self.priorityComment2.text ?? ""
        self.PComment[2] = self.priorityComment3.text ?? ""
        self.PComment[3] = self.priorityComment4.text ?? ""
        self.TGoal[0] = self.teamGoal1.text ?? ""
        self.TGoal[1] = self.teamGoal2.text ?? ""
        self.TGoal[2] = self.teamGoal3.text ?? ""
        self.TGoal[3] = self.teamGoal4.text ?? ""
        self.TKPI[0] = self.teamKPI1.text ?? ""
        self.TKPI[1] = self.teamKPI2.text ?? ""
        self.TKPI[2] = self.teamKPI3.text ?? ""
        self.TKPI[3] = self.teamKPI4.text ?? ""
        self.TTarget[0] = self.teamTarget1.text ?? ""
        self.TTarget[1] = self.teamTarget2.text ?? ""
        self.TTarget[2] = self.teamTarget3.text ?? ""
        self.TTarget[3] = self.teamTarget4.text ?? ""
        self.TComment[0] = self.teamComment1.text ?? ""
        self.TComment[1] = self.teamComment2.text ?? ""
        self.TComment[2] = self.teamComment3.text ?? ""
        self.TComment[3] = self.teamComment4.text ?? ""
        self.IGoal[0] = self.IndividualGoal1.text ?? ""
        self.IGoal[1] = self.IndividualGoal2.text ?? ""
        self.IGoal[2] = self.IndividualGoal3.text ?? ""
        self.IGoal[3] = self.IndividualGoal4.text ?? ""
        self.IKPI[0] = self.IndividualKPI1.text ?? ""
        self.IKPI[1] = self.IndividualKPI2.text ?? ""
        self.IKPI[2] = self.IndividualKPI3.text ?? ""
        self.IKPI[3] = self.IndividualKPI4.text ?? ""
        self.IComment[0] = self.IndividualComment1.text ?? ""
        self.IComment[1] = self.IndividualComment2.text ?? ""
        self.IComment[2] = self.IndividualComment3.text ?? ""
        self.IComment[3] = self.IndividualComment4.text ?? ""
        self.ITarget[0] = self.IndividualTarget1.text ?? ""
        self.ITarget[1] = self.IndividualTarget2.text ?? ""
        self.ITarget[2] = self.IndividualTarget3.text ?? ""
        self.ITarget[3] = self.IndividualTarget4.text ?? ""
        
        if self.pcNameTextField.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter the PC Name")
            return
        }
        if self.designationTextField.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter the Designation")
            return
        }
        
        if self.baseTownTextField.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter the Base Town")
            return
        }
        
        if self.baseTownTextField.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter the Base Town")
            return
        }
        if self.priorityGoal1.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter the Priority Goal 1")
            return
        }
        if self.priorityKPI1.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter the Priority KPI 1")
            return
        }
        if self.priorityTarget1.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter the Target 1")
            return
        }
        if self.priorityComment1.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter the Comment 1")
            return
        }
        if self.priorityGoal2.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter the Priority Goal 2")
            return
        }
        if self.priorityKPI2.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter the Priority KPI 2")
            return
        }
        if self.priorityTarget2.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter the Target 2")
            return
        }
        if self.priorityComment2.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter the Comment 2")
            return
        }
        if self.priorityGoal3.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter the Priority Goal 3")
            return
        }
        if self.priorityKPI3.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter the Priority KPI 3")
            return
        }
        if self.priorityTarget3.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter the Target 3")
            return
        }
        if self.priorityComment3.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter the Comment 3")
            return
        }
        if self.priorityGoal4.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter the Priority Goal 4")
            return
        }
        if self.priorityKPI4.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter the Priority KPI 4")
            return
        }
        if self.priorityTarget4.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter the Target 4")
            return
        }
        if self.priorityComment4.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter the Comment 4")
            return
        }
        if self.teamGoal1.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter the Team Goal 1")
            return
        }
        if self.teamKPI1.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter the Team KPI 1")
            return
        }
        if self.teamTarget1.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter the Team Target 1")
            return
        }
        if self.teamComment1.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter the Team Comment 1")
            return
        }
        if self.teamGoal2.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter the Team Goal 2")
            return
        }
        if self.teamKPI2.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter the Team KPI 2")
            return
        }
        if self.teamTarget2.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter the Team Target 2")
            return
        }
        if self.teamComment2.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter the Team Comment 2")
            return
        }
        if self.teamGoal3.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter the Team Goal 3")
            return
        }
        if self.teamKPI3.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter the Team KPI 3")
            return
        }
        if self.teamTarget3.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter the Team Target 3")
            return
        }
        if self.teamComment3.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter the Team Comment 3")
            return
        }
        if self.teamGoal4.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter the Team Goal 4")
            return
        }
        if self.teamKPI4.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter the Team KPI 4")
            return
        }
        if self.teamTarget4.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter the Team Target 4")
            return
        }
        if self.teamComment4.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter the Team Comment 4")
            return
        }
        if self.IndividualGoal1.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter the Individual Goal 1")
            return
        }
        if self.IndividualKPI1.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter the Individual KPI 1")
            return
        }
        if self.IndividualTarget1.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter the Individual Target 1")
            return
        }
        if self.IndividualComment1.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter the Individual Comment 1")
            return
        }
        if self.IndividualGoal2.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter the Individual Goal 2")
            return
        }
        if self.IndividualKPI2.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter the Individual KPI 2")
            return
        }
        if self.IndividualTarget2.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter the Individual Target 2")
            return
        }
        if self.IndividualComment2.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter the Individual Comment 2")
            return
        }
        if self.IndividualGoal3.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter the Individual Goal 3")
            return
        }
        if self.IndividualKPI3.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter the Individual KPI 3")
            return
        }
        if self.IndividualTarget3.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter the Individual Target 3")
            return
        }
        if self.IndividualComment3.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter the Individual Comment 3")
            return
        }
        if self.IndividualGoal4.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter the Individual Goal 4")
            return
        }
        if self.IndividualKPI4.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter the Individual KPI 4")
            return
        }
        if self.IndividualTarget4.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter the Individual Target 4")
            return
        }
        if self.IndividualComment4.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter the Individual Comment 4")
            return
        }
        
        activitiyViewController.show(existingUiViewController: self)
        
        let userId = CommonUtils.getJsonFromUserDefaults(forKey: Constants.EMP_ID)
        
        var params = Dictionary<String, Any>()
        params["PC_ExertnalId"] = self.pcID
        params["Employee_ExternalId"] = userId
        params["Latitude"] = CommonUtils.getJsonFromUserDefaults(forKey: Constants.LatitudeKey)
        params["Longitude"] = CommonUtils.getJsonFromUserDefaults(forKey: Constants.LongitudeKey)
        params["DStartTime"] = Double(startTime ?? "")
        params["DEndTime"] = CommonUtils.getCurrentTime()
        
        var PerformanceEvaFormPC_Priorities: [Dictionary<String, Any>] = []
        PerformanceEvaFormPC_Priorities.append(["KeyPrioritiesOrGoals": "Prioritie: 1","PrioritiesGoals": self.PGoal[0],"PrioritesTarget": self.PTarget[0], "ProritiesComment": self.PComment[0], "PrioritiesKPI": self.PKPI[0]])
        
        if self.PGoal[1] != "" && self.PKPI[1] != "" && self.PTarget[1] != "" && self.PComment[1] != "" {
            
            PerformanceEvaFormPC_Priorities.append(["KeyPrioritiesOrGoals": "Prioritie: 2","PrioritiesGoals": self.PGoal[1],"PrioritesTarget": self.PTarget[1], "ProritiesComment": self.PComment[1], "PrioritiesKPI": self.PKPI[1]])
            
        }
        
        if self.PGoal[2] != "" && self.PKPI[2] != "" && self.PTarget[2] != "" && self.PComment[2] != "" {
            PerformanceEvaFormPC_Priorities.append(["KeyPrioritiesOrGoals": "Prioritie: 3","PrioritiesGoals": self.PGoal[2],"PrioritesTarget": self.PTarget[2], "ProritiesComment": self.PComment[2], "PrioritiesKPI": self.PKPI[2]])
            
        }
        
        if self.PGoal[3] != "" && self.PKPI[3] != "" && self.PTarget[3] != "" && self.PComment[3] != "" {
            PerformanceEvaFormPC_Priorities.append(["KeyPrioritiesOrGoals": "Prioritie: 4","PrioritiesGoals": self.PGoal[3],"PrioritesTarget": self.PTarget[3], "ProritiesComment": self.PComment[3], "PrioritiesKPI": self.PKPI[3]])
            
        }
        params["Edu_PerformanceEvaFormPC_Priorities"] = PerformanceEvaFormPC_Priorities
        
        var PerformanceEvaFormPC_TeamLevel: [Dictionary<String, Any>] = []
        PerformanceEvaFormPC_TeamLevel.append(["TeamLevel": "Prioritie: 1","TeamLevelGoals": self.TGoal[0],"TeamLevelTarget": self.TTarget[0],"TeamLevelComment": self.TComment[0],"TeamLevelKPI": self.TKPI[0]])
        
        if self.TGoal[1] != "" && self.TKPI[1] != "" && self.TTarget[1] != "" && self.TComment[1] != "" {
            PerformanceEvaFormPC_TeamLevel.append(["TeamLevel": "Prioritie: 2","TeamLevelGoals": self.TGoal[1],"TeamLevelTarget": self.TTarget[1],"TeamLevelComment": self.TComment[1],"TeamLevelKPI": self.TKPI[1]])
            
        }
        
        if self.TGoal[2] != "" && self.TKPI[2] != "" && self.TTarget[2] != "" && self.TComment[2] != "" {
            PerformanceEvaFormPC_TeamLevel.append(["TeamLevel": "Prioritie: 3","TeamLevelGoals": self.TGoal[2],"TeamLevelTarget": self.TTarget[2],"TeamLevelComment": self.TComment[2],"TeamLevelKPI": self.TKPI[2]])
        }
        
        if self.TGoal[3] != "" && self.TKPI[3] != "" && self.TTarget[3] != "" && self.TComment[3] != "" {
            
            PerformanceEvaFormPC_TeamLevel.append(["TeamLevel": "Prioritie: 4","TeamLevelGoals": self.TGoal[3],"TeamLevelTarget": self.TTarget[3],"TeamLevelComment": self.TComment[3],"TeamLevelKPI": self.TKPI[3]])
            
        }
        params["Edu_PerformanceEvaFormPC_TeamLevel"] = PerformanceEvaFormPC_TeamLevel
        
        var PerformanceEvaFormPC_Individual: [Dictionary<String, Any>] = []
        PerformanceEvaFormPC_Individual.append(["IndividualLevel": "Prioritie: 1","IndividualLevelGoals": self.IGoal[0],"IndividualLevelTarget": self.ITarget[0],"IndividualLevelComment": self.IComment[0],"IndividualLevelKPI": self.IKPI[0]])
        
        if self.IGoal[1] != "" && self.IKPI[1] != "" && self.ITarget[1] != "" && self.IComment[1] != "" {
            
            PerformanceEvaFormPC_Individual.append(["IndividualLevel": "Prioritie: 2","IndividualLevelGoals": self.IGoal[1],"IndividualLevelTarget": self.ITarget[1],"IndividualLevelComment": self.IComment[1],"IndividualLevelKPI": self.IKPI[1]])
            
        }
        
        if self.IGoal[2] != "" && self.IKPI[2] != "" && self.ITarget[2] != "" && self.IComment[2] != "" {
            
            PerformanceEvaFormPC_Individual.append(["IndividualLevel": "Prioritie: 3","IndividualLevelGoals": self.IGoal[2],"IndividualLevelTarget": self.ITarget[2],"IndividualLevelComment": self.IComment[2],"IndividualLevelKPI": self.IKPI[2]])
            
        }
        
        if self.IGoal[3] != "" && self.IKPI[3] != "" && self.ITarget[3] != "" && self.IComment[3] != "" {
            PerformanceEvaFormPC_Individual.append(["IndividualLevel": "Prioritie: 4","IndividualLevelGoals": self.IGoal[3],"IndividualLevelTarget": self.ITarget[3],"IndividualLevelComment": self.IComment[3],"IndividualLevelKPI": self.IKPI[3]])
        }
        params["Edu_PerformanceEvaFormPC_IndividualLevel"] = PerformanceEvaFormPC_Individual
        
        Alamofire.request(Constants.CallPCApi, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
            .responseString(completionHandler: {(response) in
                // On Response
                self.activitiyViewController.dismiss(animated: true, completion: {() in
                    
                    //On Dialog Close
                    if (response.error != nil) {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (response.error?.localizedDescription)!)
                        return
                    }
                    let PCModel = Mapper<PerformanceEvaluationPCModel>().map(JSONString: response.value!) //JSON to model
                    
                    if PCModel != nil {
                        
                        if PCModel?.success == true {
                            
                            if PCModel?.result == 1 {
                                CommonUtils.showMsgDialogWithOk(showingPopupOn: self, withTitle: "Novo", withMessage: "Form Submit Successfully", onOkClicked:{()
                                    
                                    self.dismiss(animated: true, completion: nil)
                                })
                            }
                        }
                        
                    }else {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "eDetailer", withMessage: response.value!)
                    }
                })
            })
    }
}


