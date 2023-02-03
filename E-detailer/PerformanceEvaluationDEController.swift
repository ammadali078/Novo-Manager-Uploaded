//
//  PerformanceEvaluationDEController.swift
//  E-detailer
//
//  Created by macbook on 10/01/2022.
//  Copyright © 2022 Ammad. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import ObjectMapper

class PerformanceEvaluationDEController: UIViewController, UITextFieldDelegate, UITextViewDelegate,UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var overAllCommectsLabelView: UITextView!
    @IBOutlet weak var DENameTextField: UITextField!
    @IBOutlet weak var target1Textfield: UITextField!
    @IBOutlet weak var target2Textfield: UITextField!
    @IBOutlet weak var target3Textfield: UITextField!
    @IBOutlet weak var target4Textfield: UITextField!
    @IBOutlet weak var achievement1Textfield: UITextField!
    @IBOutlet weak var achievement2Textfield: UITextField!
    @IBOutlet weak var achievement3Textfield: UITextField!
    @IBOutlet weak var achievement4Textfield: UITextField!
    @IBOutlet weak var comments1Textfield: UITextField!
    @IBOutlet weak var comments2Textfield: UITextField!
    @IBOutlet weak var comments3Textfield: UITextField!
    @IBOutlet weak var comments4Textfield: UITextField!
    @IBOutlet weak var qualitativeTarget1: UITextField!
    @IBOutlet weak var qualitativeTarget2: UITextField!
    @IBOutlet weak var qualitativeTarget3: UITextField!
    @IBOutlet weak var qualitativeTarget4: UITextField!
    @IBOutlet weak var qualitativeTarget5: UITextField!
    @IBOutlet weak var qualitativeAchievement1: UITextField!
    @IBOutlet weak var qualitativeAchievement2: UITextField!
    @IBOutlet weak var qualitativeAchievement3: UITextField!
    @IBOutlet weak var qualitativeAchievement4: UITextField!
    @IBOutlet weak var qualitativeAchievement5: UITextField!
    @IBOutlet weak var qualitativeComment1: UITextField!
    @IBOutlet weak var qualitativeComment2: UITextField!
    @IBOutlet weak var qualitativeComment3: UITextField!
    @IBOutlet weak var qualitativeComment4: UITextField!
    @IBOutlet weak var qualitativeComment5: UITextField!
    @IBOutlet weak var CommentsTextField1: UILabel!
    @IBOutlet weak var descriptionTextField1: UILabel!
    @IBOutlet weak var AETextField1: UITextField!
    @IBOutlet weak var METextField1: UITextField!
    @IBOutlet weak var EETextField1: UITextField!
    @IBOutlet weak var OTextField1: UITextField!
    @IBOutlet weak var CommentsTextField2: UILabel!
    @IBOutlet weak var descriptionTextField2: UILabel!
    @IBOutlet weak var AETextField2: UITextField!
    @IBOutlet weak var METextField2: UITextField!
    @IBOutlet weak var EETextField2: UITextField!
    @IBOutlet weak var OTextField2: UITextField!
    @IBOutlet weak var CommentsTextField3: UILabel!
    @IBOutlet weak var CommentsTextField4: UILabel!
    @IBOutlet weak var CommentsTextField5: UILabel!
    @IBOutlet weak var CommentsTextField6: UILabel!
    @IBOutlet weak var CommentsTextField7: UILabel!
    @IBOutlet weak var CommentsTextField8: UILabel!
    @IBOutlet weak var CommentsTextField9: UILabel!
    @IBOutlet weak var CommentsTextField10: UILabel!
    @IBOutlet weak var descriptionTextField3: UILabel!
    @IBOutlet weak var descriptionTextField4: UILabel!
    @IBOutlet weak var descriptionTextField5: UILabel!
    @IBOutlet weak var descriptionTextField6: UILabel!
    @IBOutlet weak var descriptionTextField7: UILabel!
    @IBOutlet weak var descriptionTextField8: UILabel!
    @IBOutlet weak var descriptionTextField9: UILabel!
    @IBOutlet weak var descriptionTextField10: UILabel!
    @IBOutlet weak var AETextField3: UITextField!
    @IBOutlet weak var AETextField4: UITextField!
    @IBOutlet weak var AETextField5: UITextField!
    @IBOutlet weak var AETextField6: UITextField!
    @IBOutlet weak var AETextField7: UITextField!
    @IBOutlet weak var AETextField8: UITextField!
    @IBOutlet weak var AETextField9: UITextField!
    @IBOutlet weak var AETextField10: UITextField!
    @IBOutlet weak var METextField10: UITextField!
    @IBOutlet weak var METextField9: UITextField!
    @IBOutlet weak var METextField8: UITextField!
    @IBOutlet weak var METextField7: UITextField!
    @IBOutlet weak var METextField6: UITextField!
    @IBOutlet weak var METextField5: UITextField!
    @IBOutlet weak var METextField4: UITextField!
    @IBOutlet weak var METextField3: UITextField!
    @IBOutlet weak var EETextField3: UITextField!
    @IBOutlet weak var EETextField4: UITextField!
    @IBOutlet weak var EETextField10: UITextField!
    @IBOutlet weak var EETextField9: UITextField!
    @IBOutlet weak var EETextField8: UITextField!
    @IBOutlet weak var EETextField7: UITextField!
    @IBOutlet weak var EETextField6: UITextField!
    @IBOutlet weak var EETextField5: UITextField!
    @IBOutlet weak var OTextField10: UITextField!
    @IBOutlet weak var OTextField9: UITextField!
    @IBOutlet weak var OTextField8: UITextField!
    @IBOutlet weak var OTextField3: UITextField!
    @IBOutlet weak var OTextField4: UITextField!
    @IBOutlet weak var OTextField5: UITextField!
    @IBOutlet weak var OTextField6: UITextField!
    @IBOutlet weak var OTextField7: UITextField!
    @IBOutlet weak var baseTownTextField: UITextField!
    @IBOutlet weak var designationTextField: UITextField!
    
    var quantitativeTarget: [String] = ["","","",""]
    var quantitativeAchievement: [String] = ["","","",""]
    var quantitativeComment: [String] = ["","","",""]
    var qualitativeTarget: [String] = ["","","","",""]
    var qualitativeAchievement: [String] = ["","","","",""]
    var qualitativeComment: [String] = ["","","","",""]
    var ratingComment: [String] = ["","","","","","","","","",""]
    var ratingDescription: [String] = ["","","","","","","","","",""]
    var ratingAE: [String] = ["","","","","","","","","",""]
    var ratingME: [String] = ["","","","","","","","","",""]
    var ratingEE: [String] = ["","","","","","","","","",""]
    var ratingO: [String] = ["","","","","","","","","",""]
    weak var pickerView: UIPickerView?
    var pcName : [PlannedResult] = []
    var pcID: String?
    var startTime: String?
    var maxLength : Int?
    
    var indicator: UIActivityIndicatorView!
    var activitiyViewController: ActivityViewController!
    
    var lblPlaceHolder : UILabel!
    
    func textViewDidChange(_ textView: UITextView) {
        lblPlaceHolder.isHidden = !textView.text.isEmpty
    }
    
    override func viewDidLoad() {
        
        self.target1Textfield.delegate = self
        self.target2Textfield.delegate = self
        self.target3Textfield.delegate = self
        self.target4Textfield.delegate = self
        self.achievement1Textfield.delegate = self
        self.achievement2Textfield.delegate = self
        self.achievement3Textfield.delegate = self
        self.achievement4Textfield.delegate = self
        self.comments1Textfield.delegate = self
        self.comments2Textfield.delegate = self
        self.comments3Textfield.delegate = self
        self.comments4Textfield.delegate = self
        self.qualitativeTarget1.delegate = self
        self.qualitativeTarget2.delegate = self
        self.qualitativeTarget3.delegate = self
        self.qualitativeTarget4.delegate = self
        self.qualitativeTarget5.delegate = self
        self.qualitativeAchievement1.delegate = self
        self.qualitativeAchievement2.delegate = self
        self.qualitativeAchievement3.delegate = self
        self.qualitativeAchievement4.delegate = self
        self.qualitativeAchievement5.delegate = self
        self.qualitativeComment1.delegate = self
        self.qualitativeComment2.delegate = self
        self.qualitativeComment3.delegate = self
        self.qualitativeComment4.delegate = self
        self.qualitativeComment5.delegate = self
        self.AETextField1.delegate = self
        self.METextField1.delegate = self
        self.EETextField1.delegate = self
        self.OTextField1.delegate = self
        self.AETextField2.delegate = self
        self.METextField2.delegate = self
        self.EETextField2.delegate = self
        self.OTextField2.delegate = self
        self.AETextField3.delegate = self
        self.AETextField4.delegate = self
        self.AETextField5.delegate = self
        self.AETextField6.delegate = self
        self.AETextField7.delegate = self
        self.AETextField8.delegate = self
        self.AETextField9.delegate = self
        self.AETextField10.delegate = self
        self.METextField10.delegate = self
        self.METextField9.delegate = self
        self.METextField8.delegate = self
        self.METextField7.delegate = self
        self.METextField6.delegate = self
        self.METextField5.delegate = self
        self.METextField4.delegate = self
        self.METextField3.delegate = self
        self.EETextField3.delegate = self
        self.EETextField4.delegate = self
        self.EETextField10.delegate = self
        self.EETextField9.delegate = self
        self.EETextField8.delegate = self
        self.EETextField7.delegate = self
        self.EETextField6.delegate = self
        self.EETextField5.delegate = self
        self.OTextField10.delegate = self
        self.OTextField9.delegate = self
        self.OTextField8.delegate = self
        self.OTextField3.delegate = self
        self.OTextField4.delegate = self
        self.OTextField5.delegate = self
        self.OTextField6.delegate = self
        self.OTextField7.delegate = self
        
        activitiyViewController = ActivityViewController(message: "Loading...")
        overAllCommectsLabelView.delegate = self
        lblPlaceHolder = UILabel()
        lblPlaceHolder.text = "Enter your conversation with patient"
        lblPlaceHolder.font = UIFont.systemFont(ofSize: overAllCommectsLabelView.font!.pointSize)
        lblPlaceHolder.sizeToFit()
        overAllCommectsLabelView.addSubview(lblPlaceHolder)
        lblPlaceHolder.frame.origin = CGPoint(x: 5, y: (overAllCommectsLabelView.font?.pointSize)! / 2)
        lblPlaceHolder.textColor = UIColor.lightGray
        lblPlaceHolder.isHidden = !overAllCommectsLabelView.text.isEmpty
        
        startTime = String(CommonUtils.getCurrentTime())
        
        self.overAllCommectsLabelView.layer.borderColor = UIColor.lightGray.cgColor
        self.overAllCommectsLabelView.layer.borderWidth = 1.0
        self.overAllCommectsLabelView.layer.cornerRadius = 8
        
        self.CallApi()
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        
        self.DENameTextField.delegate = self
        DENameTextField.inputView = pickerView
        
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
        
        DENameTextField.inputAccessoryView = toolBar
        self.pickerView = pickerView
        
    }
    
    @objc func donePicker(){
        self.DENameTextField.resignFirstResponder()
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if DENameTextField.isFirstResponder{
            return self.pcName.count ?? 0
        }
        
        return 0
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if DENameTextField.isFirstResponder{
            return pcName[row].empName
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if DENameTextField.isFirstResponder{
            let itemselected = self.pcName[row].empName
            DENameTextField.text = itemselected
            self.pcID = self.pcName[row].empId
            self.designationTextField.text = "Diabeties Educator"
        }
    }
    
    func textView(_ tsextView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (overAllCommectsLabelView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        return numberOfChars < 500    // 10 Limit Value
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == target1Textfield{
            maxLength = 50
        }else if textField == achievement1Textfield{
            maxLength = 50
        }else if textField == comments1Textfield{
            maxLength = 50
        }else if textField == target2Textfield{
            maxLength = 50
        }else if textField == achievement2Textfield{
            maxLength = 50
        }else if textField == comments2Textfield{
            maxLength = 50
        }else if textField == target3Textfield{
            maxLength = 50
        }else if textField == achievement3Textfield{
            maxLength = 50
        }else if textField == comments3Textfield{
            maxLength = 50
        }else if textField == target4Textfield{
            maxLength = 50
        }else if textField == achievement4Textfield{
            maxLength = 50
        }else if textField == comments4Textfield{
            maxLength = 50
        }else if textField == qualitativeTarget1{
            maxLength = 50
        }else if textField == qualitativeAchievement1{
            maxLength = 50
        }else if textField == qualitativeComment1{
            maxLength = 50
        }else if textField == qualitativeTarget2{
            maxLength = 50
        }else if textField == qualitativeAchievement2{
            maxLength = 50
        }else if textField == qualitativeComment2{
            maxLength = 50
        }else if textField == qualitativeTarget3{
            maxLength = 50
        }else if textField == qualitativeAchievement3{
            maxLength = 50
        }else if textField == qualitativeComment3{
            maxLength = 50
        }else if textField == qualitativeTarget4{
            maxLength = 50
        }else if textField == qualitativeAchievement4{
            maxLength = 50
        }else if textField == qualitativeComment4{
            maxLength = 50
        }else if textField == AETextField1{
            maxLength = 50
        }else if textField == METextField1{
            maxLength = 50
        }else if textField == EETextField1{
            maxLength = 50
        }else if textField == OTextField1{
            maxLength = 50
        }else if textField == AETextField2{
            maxLength = 50
        }else if textField == METextField2{
            maxLength = 50
        }else if textField == EETextField2{
            maxLength = 50
        }else if textField == OTextField2{
            maxLength = 50
        }else if textField == AETextField3{
            maxLength = 50
        }else if textField == METextField3{
            maxLength = 50
        }else if textField == EETextField3{
            maxLength = 50
        }else if textField == OTextField3{
            maxLength = 50
        }else if textField == AETextField4{
            maxLength = 50
        }else if textField == METextField4{
            maxLength = 50
        }else if textField == EETextField4{
            maxLength = 50
        }else if textField == OTextField4{
            maxLength = 50
        }else if textField == AETextField5{
            maxLength = 50
        }else if textField == METextField5{
            maxLength = 50
        }else if textField == EETextField5{
            maxLength = 50
        }else if textField == OTextField5{
            maxLength = 50
        }else if textField == AETextField6{
            maxLength = 50
        }else if textField == METextField6{
            maxLength = 50
        }else if textField == EETextField6{
            maxLength = 50
        }else if textField == OTextField6{
            maxLength = 50
        }else if textField == AETextField7{
            maxLength = 50
        }else if textField == METextField7{
            maxLength = 50
        }else if textField == EETextField7{
            maxLength = 50
        }else if textField == OTextField7{
            maxLength = 50
        }else if textField == AETextField8{
            maxLength = 50
        }else if textField == METextField8{
            maxLength = 50
        }else if textField == EETextField8{
            maxLength = 50
        }else if textField == OTextField8{
            maxLength = 50
        }else if textField == AETextField9{
            maxLength = 50
        }else if textField == METextField9{
            maxLength = 50
        }else if textField == EETextField9{
            maxLength = 50
        }else if textField == OTextField9{
            maxLength = 50
        }else if textField == AETextField10{
            maxLength = 50
        }else if textField == METextField10{
            maxLength = 50
        }else if textField == EETextField10{
            maxLength = 50
        }else if textField == OTextField10{
            maxLength = 50
        }
        
        let currentString: NSString = textField.text! as NSString
        
        let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength ?? 0
        
    }
    
    
    @IBAction func onBackClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSaveClicked(_ sender: Any) {
        self.callDEApi()
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
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please check your internet connection")
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
    
    func callDEApi() {
        
        self.quantitativeTarget[0] = target1Textfield.text ?? ""
        self.quantitativeTarget[1] = target2Textfield.text ?? ""
        self.quantitativeTarget[2] = target3Textfield.text ?? ""
        self.quantitativeTarget[3] = target4Textfield.text ?? ""
        self.quantitativeAchievement[0] = achievement1Textfield.text ?? ""
        self.quantitativeAchievement[1] = achievement2Textfield.text ?? ""
        self.quantitativeAchievement[2] = achievement3Textfield.text ?? ""
        self.quantitativeAchievement[3] = achievement4Textfield.text ?? ""
        self.quantitativeComment[0] = comments1Textfield.text ?? ""
        self.quantitativeComment[1] = comments2Textfield.text ?? ""
        self.quantitativeComment[2] = comments3Textfield.text ?? ""
        self.quantitativeComment[3] = comments4Textfield.text ?? ""
        self.qualitativeTarget[0] = qualitativeTarget1.text ?? ""
        self.qualitativeTarget[1] = qualitativeTarget2.text ?? ""
        self.qualitativeTarget[2] = qualitativeTarget3.text ?? ""
        self.qualitativeTarget[3] = qualitativeTarget4.text ?? ""
        self.qualitativeTarget[4] = qualitativeTarget5.text ?? ""
        self.qualitativeAchievement[0] = qualitativeAchievement1.text ?? ""
        self.qualitativeAchievement[1] = qualitativeAchievement2.text ?? ""
        self.qualitativeAchievement[2] = qualitativeAchievement3.text ?? ""
        self.qualitativeAchievement[3] = qualitativeAchievement4.text ?? ""
        self.qualitativeAchievement[4] = qualitativeAchievement5.text ?? ""
        self.qualitativeComment[0] = qualitativeComment1.text ?? ""
        self.qualitativeComment[1] = qualitativeComment2.text ?? ""
        self.qualitativeComment[2] = qualitativeComment3.text ?? ""
        self.qualitativeComment[3] = qualitativeComment4.text ?? ""
        self.qualitativeComment[4] = qualitativeComment5.text ?? ""
        self.ratingComment[0] = CommentsTextField1.text ?? ""
        self.ratingComment[1] = CommentsTextField2.text ?? ""
        self.ratingComment[2] = CommentsTextField3.text ?? ""
        self.ratingComment[3] = CommentsTextField4.text ?? ""
        self.ratingComment[4] = CommentsTextField5.text ?? ""
        self.ratingComment[5] = CommentsTextField6.text ?? ""
        self.ratingComment[6] = CommentsTextField7.text ?? ""
        self.ratingComment[7] = CommentsTextField8.text ?? ""
        self.ratingComment[8] = CommentsTextField9.text ?? ""
        self.ratingComment[9] = CommentsTextField10.text ?? ""
        self.ratingDescription[0] = descriptionTextField1.text ?? ""
        self.ratingDescription[1] = descriptionTextField2.text ?? ""
        self.ratingDescription[2] = descriptionTextField3.text ?? ""
        self.ratingDescription[3] = descriptionTextField4.text ?? ""
        self.ratingDescription[4] = descriptionTextField5.text ?? ""
        self.ratingDescription[5] = descriptionTextField6.text ?? ""
        self.ratingDescription[6] = descriptionTextField7.text ?? ""
        self.ratingDescription[7] = descriptionTextField8.text ?? ""
        self.ratingDescription[8] = descriptionTextField9.text ?? ""
        self.ratingDescription[9] = descriptionTextField10.text ?? ""
        self.ratingAE[0] = AETextField1.text ?? ""
        self.ratingAE[1] = AETextField2.text ?? ""
        self.ratingAE[2] = AETextField3.text ?? ""
        self.ratingAE[3] = AETextField4.text ?? ""
        self.ratingAE[4] = AETextField5.text ?? ""
        self.ratingAE[5] = AETextField6.text ?? ""
        self.ratingAE[6] = AETextField7.text ?? ""
        self.ratingAE[7] = AETextField8.text ?? ""
        self.ratingAE[8] = AETextField9.text ?? ""
        self.ratingAE[9] = AETextField10.text ?? ""
        self.ratingME[0] = METextField1.text ?? ""
        self.ratingME[1] = METextField2.text ?? ""
        self.ratingME[2] = METextField3.text ?? ""
        self.ratingME[3] = METextField4.text ?? ""
        self.ratingME[4] = METextField5.text ?? ""
        self.ratingME[5] = METextField6.text ?? ""
        self.ratingME[6] = METextField7.text ?? ""
        self.ratingME[7] = METextField8.text ?? ""
        self.ratingME[8] = METextField9.text ?? ""
        self.ratingME[9] = METextField10.text ?? ""
        self.ratingEE[0] = EETextField1.text ?? ""
        self.ratingEE[1] = EETextField2.text ?? ""
        self.ratingEE[2] = EETextField3.text ?? ""
        self.ratingEE[3] = EETextField4.text ?? ""
        self.ratingEE[4] = EETextField5.text ?? ""
        self.ratingEE[5] = EETextField6.text ?? ""
        self.ratingEE[6] = EETextField7.text ?? ""
        self.ratingEE[7] = EETextField8.text ?? ""
        self.ratingEE[8] = EETextField9.text ?? ""
        self.ratingEE[9] = EETextField10.text ?? ""
        self.ratingO[0] = OTextField1.text ?? ""
        self.ratingO[1] = OTextField2.text ?? ""
        self.ratingO[2] = OTextField3.text ?? ""
        self.ratingO[3] = OTextField4.text ?? ""
        self.ratingO[4] = OTextField5.text ?? ""
        self.ratingO[5] = OTextField6.text ?? ""
        self.ratingO[6] = OTextField7.text ?? ""
        self.ratingO[7] = OTextField8.text ?? ""
        self.ratingO[8] = OTextField9.text ?? ""
        self.ratingO[9] = OTextField10.text ?? ""
        
        if self.DENameTextField.text == ""{
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter De name")
            return
        }
        if self.baseTownTextField.text == ""{
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter Base Town")
            return
        }
        if self.designationTextField.text == ""{
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter Designation")
            return
        }
        
        if self.target1Textfield.text == ""{
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter Target 1")
            return
        }
        
        if self.achievement1Textfield.text == ""{
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter acheivement 1")
            return
        }
        
        if self.comments1Textfield.text == ""{
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter comments 1")
            return
        }
        
        if self.target2Textfield.text == ""{
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter Target 2")
            return
        }
        
        if self.achievement2Textfield.text == ""{
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter acheivement 2")
            return
        }
        
        if self.comments2Textfield.text == ""{
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter comments 1")
            return
        }
        
        if self.target3Textfield.text == ""{
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter Target 3")
            return
        }
        
        if self.achievement3Textfield.text == ""{
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter acheivement 3")
            return
        }
        
        if self.comments3Textfield.text == ""{
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter comments 3")
            return
        }
        
        if self.target4Textfield.text == ""{
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter Target 4")
            return
        }
        
        if self.achievement4Textfield.text == ""{
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter acheivement 4")
            return
        }
        
        if self.comments4Textfield.text == ""{
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter comments 4")
            return
        }
        
        if self.qualitativeTarget1.text == ""{
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter qualitative Target 1")
            return
        }
        
        if self.qualitativeAchievement1.text == ""{
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter qualitative acheivement 1")
            return
        }
        
        if self.qualitativeComment1.text == ""{
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter qualitative comments 1")
            return
        }
        
        if self.qualitativeTarget2.text == ""{
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter qualitative Target 2")
            return
        }
        
        if self.qualitativeAchievement2.text == ""{
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter qualitative acheivement 2")
            return
        }
        
        if self.qualitativeComment2.text == ""{
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter qualitative comments 2")
            return
        }
        
        if self.qualitativeTarget3.text == ""{
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter qualitative Target 3")
            return
        }
        
        if self.qualitativeAchievement3.text == ""{
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter qualitative acheivement 3")
            return
        }
        
        if self.qualitativeComment3.text == ""{
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter qualitative comments 3")
            return
        }
        
        if self.qualitativeTarget4.text == ""{
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter qualitative Target 4")
            return
        }
        
        if self.qualitativeAchievement4.text == ""{
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter qualitative acheivement 4")
            return
        }
        
        if self.qualitativeComment4.text == ""{
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter qualitative comments 4")
            return
        }
        if self.qualitativeTarget5.text == ""{
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter qualitative Target 5")
            return
        }
        
        if self.qualitativeAchievement5.text == ""{
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter qualitative acheivement 5")
            return
        }
        
        if self.qualitativeComment5.text == ""{
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter qualitative comments 5")
            return
        }
        
        if self.AETextField1.text == ""{
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter AE 1")
            return
        }
        
        //        if self.EETextField1.text == ""{
        //            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter EE 1")
        //            return
        //        }
        //        if self.METextField1.text == ""{
        //            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter ME 1")
        //            return
        //        }
        //        if self.OTextField1.text == ""{
        //            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter O 1")
        //            return
        //        }
        if self.AETextField2.text == ""{
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter AE 2")
            return
        }
        
        //        if self.EETextField2.text == ""{
        //            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter EE 2")
        //            return
        //        }
        //        if self.METextField2.text == ""{
        //            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter ME 2")
        //            return
        //        }
        //        if self.OTextField2.text == ""{
        //            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter O 2")
        //            return
        //        }
        if self.AETextField3.text == ""{
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter AE 3")
            return
        }
        
        //        if self.EETextField3.text == ""{
        //            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter EE 3")
        //            return
        //
        //        }
        //        if self.METextField3.text == ""{
        //            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter ME 3")
        //            return
        //        }
        //        if self.OTextField3.text == ""{
        //            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter O 3")
        //            return
        //        }
        if self.AETextField4.text == ""{
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter AE 4")
            return
        }
        
        //        if self.EETextField4.text == ""{
        //            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter EE 4")
        //            return
        //
        //        }
        //        if self.METextField4.text == ""{
        //            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter ME 4")
        //            return
        //        }
        //        if self.OTextField4.text == ""{
        //            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter O 4")
        //            return
        //        }
        if self.AETextField5.text == ""{
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter AE 5")
            return
        }
        
        //        if self.EETextField5.text == ""{
        //            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter EE 5")
        //            return
        //        }
        //        if self.METextField5.text == ""{
        //            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter ME 5")
        //            return
        //        }
        //        if self.OTextField5.text == ""{
        //            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter O 5")
        //            return
        //        }
        if self.AETextField6.text == ""{
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter AE 6")
            return
        }
        
        //        if self.EETextField6.text == ""{
        //            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter EE 6")
        //            return
        //        }
        //        if self.METextField6.text == ""{
        //            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter ME 6")
        //            return
        //        }
        //        if self.OTextField6.text == ""{
        //            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter O 6")
        //            return
        //        }
        if self.AETextField7.text == ""{
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter AE 7")
            return
        }
        
        //        if self.EETextField7.text == ""{
        //            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter EE 7")
        //            return
        //        }
        //        if self.METextField7.text == ""{
        //            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter ME 7")
        //            return
        //        }
        //        if self.OTextField7.text == ""{
        //            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter O 7")
        //            return
        //        }
        if self.AETextField8.text == ""{
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter AE 8")
            return
        }
        
        //        if self.EETextField8.text == ""{
        //            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter EE 8")
        //            return
        //        }
        //        if self.METextField8.text == ""{
        //            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter ME 8")
        //            return
        //        }
        //        if self.OTextField8.text == ""{
        //            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter O 8")
        //            return
        //        }
        if self.AETextField9.text == ""{
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter AE 9")
            return
        }
        
        //        if self.EETextField9.text == ""{
        //            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter EE 9")
        //            return
        //        }
        //        if self.METextField9.text == ""{
        //            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter ME 9")
        //            return
        //        }
        //        if self.OTextField9.text == ""{
        //            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter O 9")
        //            return
        //        }
        if self.AETextField10.text == ""{
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter AE 10")
            return
        }
        
        //        if self.EETextField10.text == ""{
        //            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter EE 10")
        //            return
        //        }
        //        if self.METextField10.text == ""{
        //            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter ME 10")
        //            return
        //        }
        //        if self.OTextField10.text == ""{
        //            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter O 10")
        //            return
        //        }
        if self.overAllCommectsLabelView.text == ""{
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo-Manager", withMessage: "Please enter Comments")
            return
        }
        
        activitiyViewController.show(existingUiViewController: self)
        
        let userId = CommonUtils.getJsonFromUserDefaults(forKey: Constants.EMP_ID)
        
        var params = Dictionary<String, Any>()
        params["DE_ExertnalId"] = self.pcID
        params["Employee_ExternalId"] = userId
        params["Comments"] = overAllCommectsLabelView.text
        params["Latitude"] = CommonUtils.getJsonFromUserDefaults(forKey: Constants.LatitudeKey)
        params["Longitude"] = CommonUtils.getJsonFromUserDefaults(forKey: Constants.LongitudeKey)
        params["DStartTime"] = Double(startTime ?? "")
        params["DEndTime"] = CommonUtils.getCurrentTime()
        var QuantitativePerformance: [Dictionary<String, Any>] = []
        QuantitativePerformance.append(["QuantitativePerformance": "No. of activities conducted: 1","QuantitativePerf_TargetOrKPI": self.quantitativeTarget[0],"QuantitativePerf_Achievement": self.quantitativeAchievement[0], "QuantitativePerf_Comments": self.quantitativeComment[0]])
        
        QuantitativePerformance.append(["QuantitativePerformance": "No. of patients educated","QuantitativePerf_TargetOrKPI": self.quantitativeTarget[1],"QuantitativePerf_Achievement": self.quantitativeAchievement[1], "QuantitativePerf_Comments": self.quantitativeComment[1]])
        
        QuantitativePerformance.append(["QuantitativePerformance": "Reporting timelines and compliance","QuantitativePerf_TargetOrKPI": self.quantitativeTarget[2],"QuantitativePerf_Achievement": self.quantitativeAchievement[2], "QuantitativePerf_Comments": self.quantitativeComment[2]])
        
        QuantitativePerformance.append(["QuantitativePerformance": "Product and disease knowledge (quiz scores)","QuantitativePerf_TargetOrKPI": self.quantitativeTarget[3],"QuantitativePerf_Achievement": self.quantitativeAchievement[3], "QuantitativePerf_Comments": self.quantitativeComment[3]])
        
        params["Edu_PerformanceEvaFormDE_QuantitativePerformance"] = QuantitativePerformance
        
        var QualitativePerformance: [Dictionary<String, Any>] = []
        QualitativePerformance.append(["QualitativePerformance": "Quality of education and counselling (patient satisfaction level and HCPs feedback)","QualitativePerf_TargetOrKPI": self.qualitativeTarget[0],"QualitativePerf_Achievement": self.qualitativeAchievement[0],"QualitativePerf_Comments": self.qualitativeComment[0]])
        
        QualitativePerformance.append(["QualitativePerformance": "Punctuality","QualitativePerf_TargetOrKPI": self.qualitativeTarget[1],"QualitativePerf_Achievement": self.qualitativeAchievement[1],"QualitativePerf_Comments": self.qualitativeComment[1]])
        
        QualitativePerformance.append(["QualitativePerformance": "Attitude (towards company's objectives, motivation to learn and openness of feedback)","QualitativePerf_TargetOrKPI": self.qualitativeTarget[2],"QualitativePerf_Achievement": self.qualitativeAchievement[2],"QualitativePerf_Comments": self.qualitativeComment[2]])
        
        QualitativePerformance.append(["QualitativePerformance": "Interpersonal skills (relationship with peers, supervisors and subordinates)","QualitativePerf_TargetOrKPI": self.qualitativeTarget[3],"QualitativePerf_Achievement": self.qualitativeAchievement[3],"QualitativePerf_Comments": self.qualitativeComment[3]])
        
        QualitativePerformance.append(["QualitativePerformance": "Communication skills (ability to converse fluently and explicitly)","QualitativePerf_TargetOrKPI": self.qualitativeTarget[4],"QualitativePerf_Achievement": self.qualitativeAchievement[4],"QualitativePerf_Comments": self.qualitativeComment[4]])
        params["Edu_PerformanceEvaFormDE_QualitativePerformance"] = QualitativePerformance
        
        var PerformanceEvaFormDE_RatingScale: [Dictionary<String, Any>] = []
        PerformanceEvaFormDE_RatingScale.append(["Competencies": self.ratingComment[0],"Description": self.ratingDescription[0],"RatingScale_AE": self.ratingAE[0],"RatingScale_ME": self.ratingME[0],"RatingScale_EE": self.ratingEE[0],"RatingScale_O": self.ratingO[0]])
        
        PerformanceEvaFormDE_RatingScale.append(["Competencies": self.ratingComment[1],"Description": self.ratingDescription[1],"RatingScale_AE": self.ratingAE[1],"RatingScale_ME": self.ratingME[1],"RatingScale_EE": self.ratingEE[1],"RatingScale_O": self.ratingO[1]])
        
        PerformanceEvaFormDE_RatingScale.append(["Competencies": self.ratingComment[2],"Description": self.ratingDescription[2],"RatingScale_AE": self.ratingAE[2],"RatingScale_ME": self.ratingME[2],"RatingScale_EE": self.ratingEE[2],"RatingScale_O": self.ratingO[2]])
        
        PerformanceEvaFormDE_RatingScale.append(["Competencies": self.ratingComment[3],"Description": self.ratingDescription[3],"RatingScale_AE": self.ratingAE[3],"RatingScale_ME": self.ratingME[3],"RatingScale_EE": self.ratingEE[3],"RatingScale_O": self.ratingO[3]])
        
        PerformanceEvaFormDE_RatingScale.append(["Competencies": self.ratingComment[4],"Description": self.ratingDescription[4],"RatingScale_AE": self.ratingAE[4],"RatingScale_ME": self.ratingME[4],"RatingScale_EE": self.ratingEE[4],"RatingScale_O": self.ratingO[4]])
        
        PerformanceEvaFormDE_RatingScale.append(["Competencies": self.ratingComment[5],"Description": self.ratingDescription[5],"RatingScale_AE": self.ratingAE[5],"RatingScale_ME": self.ratingME[5],"RatingScale_EE": self.ratingEE[5],"RatingScale_O": self.ratingO[5]])
        
        PerformanceEvaFormDE_RatingScale.append(["Competencies": self.ratingComment[6],"Description": self.ratingDescription[6],"RatingScale_AE": self.ratingAE[6],"RatingScale_ME": self.ratingME[6],"RatingScale_EE": self.ratingEE[6],"RatingScale_O": self.ratingO[6]])
        
        PerformanceEvaFormDE_RatingScale.append(["Competencies": self.ratingComment[7],"Description": self.ratingDescription[7],"RatingScale_AE": self.ratingAE[7],"RatingScale_ME": self.ratingME[7],"RatingScale_EE": self.ratingEE[7],"RatingScale_O": self.ratingO[7]])
        
        PerformanceEvaFormDE_RatingScale.append(["Competencies": self.ratingComment[8],"Description": self.ratingDescription[8],"RatingScale_AE": self.ratingAE[8],"RatingScale_ME": self.ratingME[8],"RatingScale_EE": self.ratingEE[8],"RatingScale_O": self.ratingO[8]])
        
        PerformanceEvaFormDE_RatingScale.append(["Competencies": self.ratingComment[9],"Description": self.ratingDescription[9],"RatingScale_AE": self.ratingAE[9],"RatingScale_ME": self.ratingME[9],"RatingScale_EE": self.ratingEE[9],"RatingScale_O": self.ratingO[9]])
        params["Edu_PerformanceEvaFormDE_RatingScale"] = PerformanceEvaFormDE_RatingScale
        
        Alamofire.request(Constants.CallDEApi, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
            .responseString(completionHandler: {(response) in
                // On Response
                self.activitiyViewController.dismiss(animated: true, completion: {() in
                    
                    //On Dialog Close
                    if (response.error != nil) {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (response.error?.localizedDescription)!)
                        return
                    }
                    
                    let DEModel = Mapper<PerformanceEvaluationPCModel>().map(JSONString: response.value!) //JSON to model
                    
                    if DEModel != nil {
                        
                        if DEModel?.success == true {
                            
                            if DEModel?.result == 1 {
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
