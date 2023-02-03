//
//  AddPatientViewController.swift
//  E-detailer
//
//  Created by Macbook Air on 07/10/2021.
//  Copyright © 2021 Ammad. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import ObjectMapper
import BEMCheckBox
import Photos

class AddPatientViewController: UIViewController,BEMCheckBoxDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @IBOutlet weak var namefeild: UITextField!
    @IBOutlet weak var contactNumTextField: UITextField!
    @IBOutlet weak var contactNum2TextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var address2TextField: UITextField!
    @IBOutlet weak var iNovoIdTextField: UITextField!
    @IBOutlet weak var educationProvideLayOut: UIView!
    @IBOutlet weak var educationProvideCollectionView: UICollectionView!
    @IBOutlet weak var typePatientTextField: UITextField!
    @IBOutlet weak var imageViewOutlet: UIImageView!
    @IBOutlet weak var CurrentNNProTextField: UITextField!
    @IBOutlet weak var CurrentNNProTextField2: UITextField!
    @IBOutlet weak var CurrentNNPro3TextField: UITextField!
    @IBOutlet weak var deviceDemoTextField: UITextField!
    @IBOutlet weak var deviceDemo2TextFeild: UITextField!
    @IBOutlet weak var deviceDemoTextFeild3: UITextField!
    @IBOutlet weak var concomitantNNproTextFeild: UITextField!
    @IBOutlet weak var concomitantNNPro2TextFeild: UITextField!
    @IBOutlet weak var concomitantNNPro3TextFeild: UITextField!
    @IBOutlet weak var previousNNProTextfeild: UITextField!
    @IBOutlet weak var previousNNPro2Textfeild: UITextField!
    @IBOutlet weak var previousNNPro3Textfeild: UITextField!
    @IBOutlet weak var concomitantOtherproTextFeild: UITextField!
    @IBOutlet weak var concomitantOther2proTextFeild: UITextField!
    @IBOutlet weak var concomitantOther3proTextFeild: UITextField!
    @IBOutlet weak var previousOtherProTextfeild: UITextField!
    @IBOutlet weak var previousOtherPro2Textfeild: UITextField!
    @IBOutlet weak var previousOtherPro3Textfeild: UITextField!
    @IBOutlet weak var BGSreadingTextField: UITextField!
    @IBOutlet weak var BPreadingTextField: UITextField!
    @IBOutlet weak var weightReadingTextField: UITextField!
    @IBOutlet weak var doseTextField1: UITextField!
    @IBOutlet weak var doseTextField2: UITextField!
    @IBOutlet weak var doseTextField3: UITextField!
    @IBOutlet weak var saveBtnOutlet: UIButton!
    @IBOutlet weak var attachmentTextField: UITextField!
    @IBOutlet weak var viewImageOutlet: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var checkBoxBG: BEMCheckBox!
    @IBOutlet weak var frequencyTextField1: UITextField!
    @IBOutlet weak var frequencyTextField2: UITextField!
    @IBOutlet weak var frequencyTextField3: UITextField!
    @IBOutlet weak var whiteViewOutlet: UIView!
    @IBOutlet weak var safetyEventYexyField: UITextField!
    @IBOutlet weak var safetyEventView: UIView!
    @IBOutlet weak var drugEventTextfield: UITextField!
    @IBOutlet weak var technicalIssuetextField: UITextField!
    @IBOutlet weak var gdmTextfield: UITextField!
    @IBOutlet weak var hospitalizationTextField: UITextField!
    @IBOutlet weak var discontinuationTextField: UITextField!
    @IBOutlet weak var offLabelTextField: UITextField!
    @IBOutlet weak var overDoseTextField: UITextField!
    
    var patientResult : PatientResult?
    var selectedImageData: Data?
    var educationProvideDataSource: EducationProvideCell!
    var imagePicker = UIImagePickerController()
    var filePathWithName: URL?
    var fileName: String? = ""
    var currentNNId: Int?
    var concomitantOtherproId: Int?
    var previousNNId: Int?
    var previousOtherId: Int?
    var concomitantProId: Int?
    var deviceDemoId: Int?
    var PatientType = ["New", "Repeat"]
    var Attachment = ["Yes", "No"]
    var freq = ["1", "2", "3", "4", "5"]
    var educational: [EducationalActivityDiscussionTopic] = [];
    var selectedTopic : EducationalActivityDiscussionTopic?
    weak var pickerView: UIPickerView?
    var currentCall: CallModel? = nil
    var onPatientAdded: ((CallModel?) -> Void)? = nil
    var maxLength : Int?
    var groupbx:BEMCheckBoxGroup!
    var safetyEvent: Bool?
    var drugEvent: Bool?
    var technicalIssueEvent: Bool?
    var GDMEvent: Bool?
    var hospitalizationEvent: Bool?
    var offLabelEvent: Bool?
    var overDoseEvent: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboarddisAppear), name: UIResponder.keyboardWillHideNotification, object: nil)
        educationProvideDataSource = EducationProvideCell()
        
        self.scrollView.isScrollEnabled = false
        
        safetyEventView.isHidden = true
        
        educationProvideDataSource.onSelect = {(type: EducationalActivityDiscussionTopic, isExplainedSelected: Bool, isHardCopySelected:Bool) in
            self.selectedTopic = type
            self.selectedTopic?.isExplained = isExplainedSelected
            self.selectedTopic?.isHardcopy = isHardCopySelected
            
            CommonUtils.saveJsonToUserDefaults(forKey: Constants.ishardselect, withJson: String(isExplainedSelected))
            CommonUtils.saveJsonToUserDefaults(forKey: Constants.isexplainedselect, withJson: String(isExplainedSelected))
        }
        
        checkBoxBG.delegate = self
        
        weightReadingTextField.delegate = self
        BGSreadingTextField.delegate = self
        BPreadingTextField.delegate = self
        //self.selectedPlan = planner
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        saveBtnOutlet.layer.cornerRadius = 10.0
        
        educationProvideCollectionView.dataSource = educationProvideDataSource
        imagePicker.delegate = self
        //UIPICKER
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        CurrentNNProTextField.delegate = self
        CurrentNNProTextField2.delegate = self
        CurrentNNPro3TextField.delegate = self
        frequencyTextField1.delegate = self
        frequencyTextField2.delegate = self
        frequencyTextField3.delegate = self
        
        typePatientTextField.delegate = self
        
        attachmentTextField.delegate = self
        
        safetyEventYexyField.delegate = self
        drugEventTextfield.delegate = self
        technicalIssuetextField.delegate = self
        gdmTextfield.delegate = self
        hospitalizationTextField.delegate = self
        discontinuationTextField.delegate = self
        offLabelTextField.delegate = self
        overDoseTextField.delegate = self
        contactNumTextField.delegate = self
        contactNum2TextField.delegate = self
        cityTextField.delegate = self
        addressTextField.delegate = self
        address2TextField.delegate = self
        
        concomitantNNproTextFeild.delegate = self
        concomitantNNPro2TextFeild.delegate = self
        concomitantNNPro3TextFeild.delegate = self
        
        previousNNProTextfeild.delegate = self
        previousNNPro2Textfeild.delegate = self
        previousNNPro3Textfeild.delegate = self
        
        concomitantOtherproTextFeild.delegate = self
        concomitantOther2proTextFeild.delegate = self
        concomitantOther3proTextFeild.delegate = self
        
        previousOtherProTextfeild.delegate = self
        previousOtherPro2Textfeild.delegate = self
        previousOtherPro3Textfeild.delegate = self
        
        deviceDemoTextField.delegate = self
        deviceDemo2TextFeild.delegate = self
        deviceDemoTextFeild3.delegate = self
        
        CurrentNNProTextField.inputView = pickerView
        CurrentNNProTextField2.inputView = pickerView
        CurrentNNPro3TextField.inputView = pickerView
        
        typePatientTextField.inputView = pickerView
        attachmentTextField.inputView = pickerView
        safetyEventYexyField.inputView = pickerView
        frequencyTextField1.inputView = pickerView
        frequencyTextField2.inputView = pickerView
        frequencyTextField3.inputView = pickerView
        
        drugEventTextfield.inputView = pickerView
        technicalIssuetextField.inputView = pickerView
        gdmTextfield.inputView = pickerView
        hospitalizationTextField.inputView = pickerView
        discontinuationTextField.inputView = pickerView
        offLabelTextField.inputView = pickerView
        overDoseTextField.inputView = pickerView
        
        concomitantNNproTextFeild.inputView = pickerView
        concomitantNNPro2TextFeild.inputView = pickerView
        concomitantNNPro3TextFeild.inputView = pickerView
        
        previousNNProTextfeild.inputView = pickerView
        previousNNPro2Textfeild.inputView = pickerView
        previousNNPro3Textfeild.inputView = pickerView
        
        concomitantOtherproTextFeild.inputView = pickerView
        concomitantOther2proTextFeild.inputView = pickerView
        concomitantOther3proTextFeild.inputView = pickerView
        
        previousOtherProTextfeild.inputView = pickerView
        previousOtherPro2Textfeild.inputView = pickerView
        previousOtherPro3Textfeild.inputView = pickerView
        
        deviceDemoTextField.inputView = pickerView
        deviceDemo2TextFeild.inputView = pickerView
        deviceDemoTextFeild3.inputView = pickerView
        
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
        CurrentNNProTextField.inputAccessoryView = toolBar
        CurrentNNProTextField2.inputAccessoryView = toolBar
        CurrentNNPro3TextField.inputAccessoryView = toolBar
        
        safetyEventYexyField.inputAccessoryView = toolBar
        drugEventTextfield.inputAccessoryView = toolBar
        technicalIssuetextField.inputAccessoryView = toolBar
        gdmTextfield.inputAccessoryView = toolBar
        hospitalizationTextField.inputAccessoryView = toolBar
        discontinuationTextField.inputAccessoryView = toolBar
        offLabelTextField.inputAccessoryView = toolBar
        overDoseTextField.inputAccessoryView = toolBar
        
        concomitantNNproTextFeild.inputAccessoryView = toolBar
        concomitantNNPro2TextFeild.inputAccessoryView = toolBar
        concomitantNNPro3TextFeild.inputAccessoryView = toolBar
        
        previousNNProTextfeild.inputAccessoryView = toolBar
        previousNNPro2Textfeild.inputAccessoryView = toolBar
        previousNNPro3Textfeild.inputAccessoryView = toolBar
        
        concomitantOtherproTextFeild.inputAccessoryView = toolBar
        concomitantOther2proTextFeild.inputAccessoryView = toolBar
        concomitantOther3proTextFeild.inputAccessoryView = toolBar
        
        previousOtherProTextfeild.inputAccessoryView = toolBar
        previousOtherPro2Textfeild.inputAccessoryView = toolBar
        previousOtherPro3Textfeild.inputAccessoryView = toolBar
        
        deviceDemoTextField.inputAccessoryView = toolBar
        deviceDemo2TextFeild.inputAccessoryView = toolBar
        deviceDemoTextFeild3.inputAccessoryView = toolBar
        
        typePatientTextField.inputAccessoryView = toolBar
        attachmentTextField.inputAccessoryView = toolBar
        frequencyTextField1.inputAccessoryView = toolBar
        frequencyTextField2.inputAccessoryView = toolBar
        frequencyTextField3.inputAccessoryView = toolBar
        
        //It is important that goes after de inputView assignation
        self.pickerView = pickerView
        let callApi = CallApi()
        callApi.getAllPatient(url: Constants.GetPatientDataApi, completionHandler: {(getPatientDataModel: GetPatientDataModel?, error: String?) in
            
            if (error != nil) {
                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: error!)
                return
            }
            // On Response
            
            //temp variable
            let getPatientDataModelCopy =  getPatientDataModel
            
            //On Dialog Close
            if getPatientDataModelCopy != nil {
                
                if (getPatientDataModelCopy?.success)! {
                    
                    self.educationProvideDataSource.setItems(items: getPatientDataModelCopy?.result?.educationalActivityViewModel?.educationalActivityDiscussionTopic)
                    self.educationProvideCollectionView.reloadData()
                    self.patientResult = getPatientDataModelCopy?.result
                    
                } else {
                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (getPatientDataModel?.error!)!)
                }
            } else {
                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: "Empty Response is coming from server")
            }
        })
    }
    
    var isExpand : Bool = false
    
    @objc func keyboardAppear() {
        if !isExpand {
            
            self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.scrollView.frame.height + 2900 )
            isExpand = true
        }
        
    }
    
    @objc func keyboarddisAppear() {
        
        if !isExpand {
            
            self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.scrollView.frame.height - 2900 )
            isExpand = false
        }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == namefeild{
            maxLength = 25
        }else if textField == contactNumTextField{
            maxLength = 25
        }else if textField == contactNum2TextField{
            maxLength = 25
        }else if textField == cityTextField{
            maxLength = 25
        }else if textField == addressTextField{
            maxLength = 40
        }else if textField == address2TextField{
            maxLength = 60
        }else if textField == weightReadingTextField{
            maxLength = 9
        }else if textField == BGSreadingTextField{
            maxLength = 9
        } else if textField == BPreadingTextField{
            maxLength = 9
        }
        if textField == contactNumTextField {
            let allowedCharacters = CharacterSet(charactersIn:"+0123456789 ")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }else  if textField == contactNum2TextField {
            let allowedCharacters = CharacterSet(charactersIn:"+0123456789 ")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        
        let currentString: NSString = textField.text! as NSString
        
        let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength ?? 0
        
    }
    
    @IBAction func onPictureClicked(_ sender: Any) {
        self.imagePicker.sourceType = .camera
        self.imagePicker.allowsEditing = true
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            
            self.imageViewOutlet.image = image
            self.selectedImageData = image.jpegData(compressionQuality: 0.7)
            
            guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
                return
            }
            
            do {
                self.fileName = "\(String(NSDate().timeIntervalSince1970)).jpg"
                self.filePathWithName = directory.appendingPathComponent(self.fileName!)
                try self.selectedImageData!.write(to: self.filePathWithName!)
                
                let imageUrl = self.filePathWithName
                
                CommonUtils.saveJsonToUserDefaults(forKey: Constants.imgUrl, withJson: imageUrl!.absoluteString)
                
            } catch {
                print(error.localizedDescription)
                return
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
        print("picker cancel.")
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.pickerView?.reloadAllComponents()
    }
    
    @objc func donePicker(){
        self.CurrentNNProTextField.resignFirstResponder()
        self.CurrentNNProTextField2.resignFirstResponder()
        self.CurrentNNPro3TextField.resignFirstResponder()
        
        self.concomitantNNproTextFeild.resignFirstResponder()
        self.concomitantNNPro2TextFeild.resignFirstResponder()
        self.concomitantNNPro3TextFeild.resignFirstResponder()
        
        self.previousNNProTextfeild.resignFirstResponder()
        self.previousNNPro2Textfeild.resignFirstResponder()
        self.previousNNPro3Textfeild.resignFirstResponder()
        
        self.safetyEventYexyField.resignFirstResponder()
        self.drugEventTextfield.resignFirstResponder()
        self.technicalIssuetextField.resignFirstResponder()
        self.gdmTextfield.resignFirstResponder()
        self.hospitalizationTextField.resignFirstResponder()
        self.discontinuationTextField.resignFirstResponder()
        self.offLabelTextField.resignFirstResponder()
        self.overDoseTextField.resignFirstResponder()
        
        self.concomitantOtherproTextFeild.resignFirstResponder()
        self.concomitantOther2proTextFeild.resignFirstResponder()
        self.concomitantOther3proTextFeild.resignFirstResponder()
        
        self.previousOtherProTextfeild.resignFirstResponder()
        self.previousOtherPro2Textfeild.resignFirstResponder()
        self.previousOtherPro3Textfeild.resignFirstResponder()
        
        self.deviceDemoTextField.resignFirstResponder()
        self.deviceDemo2TextFeild.resignFirstResponder()
        self.deviceDemoTextFeild3.resignFirstResponder()
        
        self.typePatientTextField.resignFirstResponder()
        self.attachmentTextField.resignFirstResponder()
        self.frequencyTextField1.resignFirstResponder()
        self.frequencyTextField2.resignFirstResponder()
        self.frequencyTextField3.resignFirstResponder()
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if CurrentNNProTextField.isFirstResponder{
            return (self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?.count)!
        }else if CurrentNNProTextField2.isFirstResponder{
            return (self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?.count)!
        }else if CurrentNNPro3TextField.isFirstResponder{
            return (self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?.count)!
        }
        else if concomitantNNproTextFeild.isFirstResponder{
            return (self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?.count)!
        }
        else if concomitantNNPro2TextFeild.isFirstResponder{
            return (self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?.count)!
        }
        else if concomitantNNPro3TextFeild.isFirstResponder{
            return (self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?.count)!
        }else if previousNNProTextfeild.isFirstResponder{
            return (self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?.count)!
        }
        else if previousNNPro2Textfeild.isFirstResponder{
            return (self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?.count)!
        }
        else if previousNNPro3Textfeild.isFirstResponder{
            return (self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?.count)!
        }else if concomitantOtherproTextFeild.isFirstResponder{
            return (self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?.count)!
        }
        else if concomitantOther2proTextFeild.isFirstResponder{
            return (self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?.count)!
        }else if concomitantOther3proTextFeild.isFirstResponder{
            return (self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?.count)!
        }else if previousOtherProTextfeild.isFirstResponder{
            return (self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?.count)!
        }
        else if previousOtherPro2Textfeild.isFirstResponder{
            return (self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?.count)!
        }
        else if previousOtherPro3Textfeild.isFirstResponder{
            return (self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?.count)!
        }else if deviceDemoTextField.isFirstResponder{
            return (self.patientResult?.educationalActivityViewModel?.educationalActivityDevice?.count)!
        }
        else if deviceDemo2TextFeild.isFirstResponder{
            return (self.patientResult?.educationalActivityViewModel?.educationalActivityDevice?.count)!
        }
        else if deviceDemoTextFeild3.isFirstResponder{
            return (self.patientResult?.educationalActivityViewModel?.educationalActivityDevice?.count)!
        }else if typePatientTextField.isFirstResponder{
            return (self.PatientType.count)
        }else if frequencyTextField1.isFirstResponder{
            return (self.freq.count)
        }else if frequencyTextField2.isFirstResponder{
            return (self.freq.count)
        }else if frequencyTextField3.isFirstResponder{
            return (self.freq.count)
        }else if attachmentTextField.isFirstResponder{
            return (self.Attachment.count)
        }else if safetyEventYexyField.isFirstResponder{
            return (self.Attachment.count)
        }else if drugEventTextfield.isFirstResponder{
            return (self.Attachment.count)
        }else if technicalIssuetextField.isFirstResponder{
            return (self.Attachment.count)
        }else if gdmTextfield.isFirstResponder{
            return (self.Attachment.count)
        }else if hospitalizationTextField.isFirstResponder{
            return (self.Attachment.count)
        }else if discontinuationTextField.isFirstResponder{
            return (self.Attachment.count)
        }else if offLabelTextField.isFirstResponder{
            return (self.Attachment.count)
        }else if overDoseTextField.isFirstResponder{
            return (self.Attachment.count)
        }
        
        return 0
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if CurrentNNProTextField.isFirstResponder{
            return self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?[row].name
        }else if CurrentNNProTextField2.isFirstResponder{
            return self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?[row].name
        }else if CurrentNNPro3TextField.isFirstResponder{
            return self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?[row].name
        }else if concomitantNNproTextFeild.isFirstResponder{
            return self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?[row].name
        }else if concomitantNNPro2TextFeild.isFirstResponder{
            return self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?[row].name
        }else if concomitantNNPro3TextFeild.isFirstResponder{
            return self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?[row].name
        }else if previousNNProTextfeild.isFirstResponder{
            return self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?[row].name
        }else if previousNNPro2Textfeild.isFirstResponder{
            return self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?[row].name
        }else if previousNNPro3Textfeild.isFirstResponder{
            return self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?[row].name
        }else if concomitantOtherproTextFeild.isFirstResponder{
            return self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?[row].name
        }else if concomitantOther2proTextFeild.isFirstResponder{
            return self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?[row].name
        }else if concomitantOther3proTextFeild.isFirstResponder{
            return self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?[row].name
        }else if concomitantOtherproTextFeild.isFirstResponder{
            return self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?[row].name
        }else if concomitantOther2proTextFeild.isFirstResponder{
            return self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?[row].name
        }else if concomitantOther3proTextFeild.isFirstResponder{
            return self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?[row].name
        }else if previousOtherProTextfeild.isFirstResponder{
            return self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?[row].name
        }else if previousOtherPro2Textfeild.isFirstResponder{
            return self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?[row].name
        }else if previousOtherPro3Textfeild.isFirstResponder{
            return self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?[row].name
        }else if deviceDemoTextField.isFirstResponder{
            return self.patientResult?.educationalActivityViewModel?.educationalActivityDevice?[row].name
        }else if deviceDemo2TextFeild.isFirstResponder{
            return self.patientResult?.educationalActivityViewModel?.educationalActivityDevice?[row].name
        }else if deviceDemoTextFeild3.isFirstResponder{
            return self.patientResult?.educationalActivityViewModel?.educationalActivityDevice?[row].name
        }else if typePatientTextField.isFirstResponder{
            return self.PatientType[row]
        }else if frequencyTextField1.isFirstResponder{
            return self.freq[row]
        }else if frequencyTextField2.isFirstResponder{
            return self.freq[row]
        }else if frequencyTextField3.isFirstResponder{
            return self.freq[row]
        }else if attachmentTextField.isFirstResponder{
            return self.Attachment[row]
        }else if safetyEventYexyField.isFirstResponder{
            return self.Attachment[row]
        }else if drugEventTextfield.isFirstResponder{
            return self.Attachment[row]
        }else if technicalIssuetextField.isFirstResponder{
            return self.Attachment[row]
        }else if gdmTextfield.isFirstResponder{
            return self.Attachment[row]
        }else if hospitalizationTextField.isFirstResponder{
            return self.Attachment[row]
        }else if discontinuationTextField.isFirstResponder{
            return self.Attachment[row]
        }else if offLabelTextField.isFirstResponder{
            return self.Attachment[row]
        }else if overDoseTextField.isFirstResponder{
            return self.Attachment[row]
        }
        
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if CurrentNNProTextField.isFirstResponder{
            let itemselected = self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?[row].name
            CurrentNNProTextField.text = itemselected
            self.currentNNId = self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?[row].id
        }else if CurrentNNProTextField2.isFirstResponder{
            let itemselected = self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?[row].name
            CurrentNNProTextField2.text = itemselected
        }else if CurrentNNPro3TextField.isFirstResponder{
            let itemselected = self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?[row].name
            CurrentNNPro3TextField.text = itemselected
        }else if concomitantNNproTextFeild.isFirstResponder{
            let itemselected = self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?[row].name
            concomitantNNproTextFeild.text = itemselected
            self.concomitantProId = self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?[row].id
        }else if concomitantNNPro2TextFeild.isFirstResponder{
            let itemselected = self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?[row].name
            concomitantNNPro2TextFeild.text = itemselected
        }else if concomitantNNPro3TextFeild.isFirstResponder{
            let itemselected = self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?[row].name
            concomitantNNPro3TextFeild.text = itemselected
        }else if previousNNProTextfeild.isFirstResponder{
            let itemselected = self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?[row].name
            previousNNProTextfeild.text = itemselected
            self.previousNNId = self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?[row].id
        }else if previousNNPro2Textfeild.isFirstResponder{
            let itemselected = self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?[row].name
            previousNNPro2Textfeild.text = itemselected
        }else if previousNNPro3Textfeild.isFirstResponder{
            let itemselected = self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?[row].name
            previousNNPro3Textfeild.text = itemselected
        }else if concomitantOtherproTextFeild.isFirstResponder{
            let itemselected = self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?[row].name
            concomitantOtherproTextFeild.text = itemselected
            self.concomitantOtherproId = self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?[row].id
        }else if concomitantOther2proTextFeild.isFirstResponder{
            let itemselected = self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?[row].name
            concomitantOther2proTextFeild.text = itemselected
        }else if concomitantOther3proTextFeild.isFirstResponder{
            let itemselected = self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?[row].name
            concomitantOther3proTextFeild.text = itemselected
        }else if previousOtherProTextfeild.isFirstResponder{
            let itemselected = self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?[row].name
            previousOtherProTextfeild.text = itemselected
            self.previousOtherId = self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?[row].id
        }else if previousOtherPro2Textfeild.isFirstResponder{
            let itemselected = self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?[row].name
            previousOtherPro2Textfeild.text = itemselected
        }else if previousOtherPro3Textfeild.isFirstResponder{
            let itemselected = self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?[row].name
            previousOtherPro3Textfeild.text = itemselected
        }
        else if deviceDemoTextField.isFirstResponder{
            let itemselected = self.patientResult?.educationalActivityViewModel?.educationalActivityDevice?[row].name
            deviceDemoTextField.text = itemselected
            self.deviceDemoId = self.patientResult?.educationalActivityViewModel?.educationalActivityDevice?[row].id
        }else if deviceDemo2TextFeild.isFirstResponder{
            let itemselected = self.patientResult?.educationalActivityViewModel?.educationalActivityDevice?[row].name
            deviceDemo2TextFeild.text = itemselected
        }else if deviceDemoTextFeild3.isFirstResponder{
            let itemselected = self.patientResult?.educationalActivityViewModel?.educationalActivityDevice?[row].name
            deviceDemoTextFeild3.text = itemselected
        }else if typePatientTextField.isFirstResponder{
            let itemselected = self.PatientType[row]
            typePatientTextField.text = itemselected
        }else if frequencyTextField1.isFirstResponder{
            let itemselected = self.freq[row]
            frequencyTextField1.text = itemselected
        }else if frequencyTextField2.isFirstResponder{
            let itemselected = self.freq[row]
            frequencyTextField2.text = itemselected
        }else if frequencyTextField3.isFirstResponder{
            let itemselected = self.freq[row]
            frequencyTextField3.text = itemselected
        }else if attachmentTextField.isFirstResponder{
            let itemselected = self.Attachment[row]
            attachmentTextField.text = itemselected
        }else if safetyEventYexyField.isFirstResponder{
            let itemselected = self.Attachment[row]
            safetyEventYexyField.text = itemselected
        }else if drugEventTextfield.isFirstResponder{
            let itemselected = self.Attachment[row]
            drugEventTextfield.text = itemselected
        }else if technicalIssuetextField.isFirstResponder{
            let itemselected = self.Attachment[row]
            technicalIssuetextField.text = itemselected
        }else if gdmTextfield.isFirstResponder{
            let itemselected = self.Attachment[row]
            gdmTextfield.text = itemselected
        }else if hospitalizationTextField.isFirstResponder{
            let itemselected = self.Attachment[row]
            hospitalizationTextField.text = itemselected
        }else if discontinuationTextField.isFirstResponder{
            let itemselected = self.Attachment[row]
            discontinuationTextField.text = itemselected
        }else if offLabelTextField.isFirstResponder{
            let itemselected = self.Attachment[row]
            offLabelTextField.text = itemselected
        }else if overDoseTextField.isFirstResponder{
            let itemselected = self.Attachment[row]
            overDoseTextField.text = itemselected
        }
        
        if drugEventTextfield.text == "Yes" {
            self.drugEvent = true
        } else if drugEventTextfield.text == "No" {
            self.drugEvent = false
        }
        if technicalIssuetextField.text == "Yes" {
            self.technicalIssueEvent = true
        } else if technicalIssuetextField.text == "No" {
            self.technicalIssueEvent = false
        }
        if gdmTextfield.text == "Yes" {
            self.GDMEvent = true
        } else if gdmTextfield.text == "No" {
            self.GDMEvent = false
        }
        if hospitalizationTextField.text == "Yes" {
            self.hospitalizationEvent = true
        } else if hospitalizationTextField.text == "No" {
            self.hospitalizationEvent = false
        }
        if offLabelTextField.text == "Yes" {
            self.offLabelEvent = true
        } else if offLabelTextField.text == "No" {
            self.offLabelEvent = false
        }
        if overDoseTextField.text == "Yes" {
            self.overDoseEvent = true
        } else if overDoseTextField.text == "No" {
            self.overDoseEvent = false
        }
        if safetyEventYexyField.text == "Yes" {
            self.safetyEvent = true
            safetyEventView.isHidden = false
        } else if safetyEventYexyField.text == "No" {
            self.safetyEvent = false
            safetyEventView.isHidden = true
            
        }
        
        if attachmentTextField.text == "Yes" {
            
            viewImageOutlet.isHidden = false
            whiteViewOutlet.isHidden = true
            self.scrollView.isScrollEnabled = true
        } else if attachmentTextField.text == "No" {
            
            viewImageOutlet.isHidden = true
            self.scrollView.isScrollEnabled = false
            whiteViewOutlet.isHidden = false
        }
        
    }
    
    func addPatientActivity() {
        
        let providedPatientName = namefeild.text
        let providedContact = contactNumTextField.text
        let providedContact2 = contactNum2TextField.text
        let providedCity = cityTextField.text
        let providedAddress = addressTextField.text
        let providedAddress2 = address2TextField.text
        let providediNovoId = iNovoIdTextField.text
        let providedPatientType = typePatientTextField.text
        let providedCurrentNN = CurrentNNProTextField.text
        let providedCurrentNN2 = CurrentNNProTextField2.text
        let providedCurrentNN3 = CurrentNNPro3TextField.text
        let providedDeviceDemo = deviceDemoTextField.text
        let providedDeviceDemo2 = deviceDemo2TextFeild.text
        let providedDeviceDemo3 = deviceDemoTextFeild3.text
        let providedConcomitantNN = concomitantNNproTextFeild.text
        let providedConcomitantNN2 = concomitantNNPro2TextFeild.text
        let providedConcomitantNN3 = concomitantNNPro3TextFeild.text
        let providedPreviousNN = previousNNProTextfeild.text
        let providedPreviousNN2 = previousNNPro2Textfeild.text
        let providedPreviousNN3 = previousNNPro3Textfeild.text
        let providedPreviousOther = previousOtherProTextfeild.text
        let providedPreviousOther2 = previousOtherPro2Textfeild.text
        let providedPreviousOther3 = previousOtherPro3Textfeild.text
        let providedBGSReading = BGSreadingTextField.text
        let providedBPReading = BPreadingTextField.text
        let providedWeight = weightReadingTextField.text
        let providedConcomitantOther =  concomitantOtherproTextFeild.text
        let providedConcomitantOther2 =  concomitantOther2proTextFeild.text
        let providedConcomitantOther3 =  concomitantOther3proTextFeild.text
        let providedDose = doseTextField1.text
        let providedDose2 = doseTextField2.text
        let providedDose3 = doseTextField3.text
        let provideAttachment = attachmentTextField.text
        let isHardCopy = CommonUtils.getJsonFromUserDefaults(forKey: Constants.ishardselect)
        let isExplained = CommonUtils.getJsonFromUserDefaults(forKey: Constants.isexplainedselect)
        let frequencyProvide1 = frequencyTextField1.text
        let frequencyProvide2 = frequencyTextField2.text
        let frequencyProvide3 = frequencyTextField3.text
        let drugs = drugEventTextfield.text
        let technicalIssue = technicalIssuetextField.text
        let gdm = gdmTextfield.text
        let hospitalization = hospitalizationTextField.text
        let discontinuation = discontinuationTextField.text
        let offLabel = offLabelTextField.text
        let overDose = overDoseTextField.text
        let Safety = safetyEventYexyField.text
        
        if provideAttachment == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Select Patient Consent")
            return
        }
        if provideAttachment == "Yes" {
            if filePathWithName == nil {
                
                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Select Patient Consent Image")
                return
            }
            
        }
        
        if providedPatientName == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the Patient Name")
            return
        }
        
        if providedContact == nil || providedContact == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the Contact Number 1")
            return
        }
        if providedContact2 == nil || providedContact2 == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the Contact Number 2")
            return
        }
        if providedCity == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the City")
            return
        }
        if providedAddress == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the Address 1")
            return
        }
        if providedAddress2 == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the Address 2")
            return
        }
        if providediNovoId == "" || providediNovoId == nil {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the iNovo ID")
            return
        }
        if providedPatientType == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the Patient Type")
            return
        }
        if providedCurrentNN == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the CurrentNN 1")
            return
        }
        if providedCurrentNN2 == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the CurrentNN 2")
            return
        }
        if providedCurrentNN3 == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the CurrentNN 3")
            return
        }
        if providedDose == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the Dose 1")
            return
        }
        if providedDose2 == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the Dose 2")
            return
        }
        if providedDose3 == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the Dose 3")
            return
        }
        if frequencyProvide1 == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the Frequency 1")
            return
        }
        if frequencyProvide2 == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the Frequency 2")
            return
        }
        if frequencyProvide3 == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the Frequency 3")
            return
        }
        if providedDeviceDemo == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the Device Demo 1")
            return
        }
        if providedDeviceDemo2 == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the Device Demo 2")
            return
        }
        if providedDeviceDemo3 == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the Device Demo 3")
            return
        }
        if providedConcomitantNN == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the ConcomitantNN Product 1")
            return
        }
        if providedConcomitantNN2 == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the ConcomitantNN Product2")
            return
        }
        if providedConcomitantNN3 == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the ConcomitantNN Product3")
            return
        }
        if providedPreviousNN == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the PreviousNN Product 1")
            return
        }
        if providedPreviousNN2 == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the PreviousNN Product2")
            return
        }
        if providedPreviousNN3 == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the PreviousNN Product3")
            return
        }
        if providedConcomitantOther == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the Concomitant Other Product 1")
            return
        }
        if providedConcomitantOther2 == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the Concomitant Other Product 2")
            return
        }
        if providedConcomitantOther3 == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the Concomitant Other Product 3")
            return
        }
        if providedPreviousOther == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the Previous Other Product 1")
            return
        }
        if providedPreviousOther2 == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the Previous Other Product2")
            return
        }
        if providedPreviousOther3 == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the Previous Other Product3")
            return
        }
        if isHardCopy == "false" && isExplained == "false" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Provide Type Of Education")
            return
        }
        if providedBGSReading == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the Blood Sugar Screening")
            return
        }
        if providedWeight == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the Weight Screening")
            return
        }
        if providedBPReading == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the BP Screening")
            return
        }
        if Safety == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Select Safety Event")
            return
        }
        if Safety == "Yes" {
            
            if drugs == "" {
                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Select Drug Event")
                return
            }else if technicalIssue == "" {
                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Select Technical Issue")
                return
            }else if gdm == "" {
                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Select GDM")
                return
            }else if hospitalization == "" {
                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Select Hospitalization")
                return
            }else if offLabel == "" {
                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Select offLabel")
                return
            }else if overDose == "" {
                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Select overDose and Missuse")
                return
            }
            
        }
        
        let patientfield = providedPatientName
        
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.validate, withJson: patientfield ?? "")
        
        let imagePath = CommonUtils.getJsonFromUserDefaults(forKey: Constants.imgURL)
        
        if (self.currentCall?.clinicActivity == nil) { self.currentCall?.clinicActivity = [] }
        
        self.currentCall?.clinicActivity?.append(ClinicActivity(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        let index = (self.currentCall?.clinicActivity?.count ?? 0) - 1
        currentCall?.clinicActivity![index].patientName = providedPatientName
        currentCall?.clinicActivity![index].patientType = providedPatientType
        currentCall?.clinicActivity![index].address1 = providedAddress
        currentCall?.clinicActivity![index].address2 = providedAddress2
        currentCall?.clinicActivity![index].contactNumber1 = providedContact
        currentCall?.clinicActivity![index].contactNumber2 = providedContact2
        currentCall?.clinicActivity![index].patientConsentAttachmentUrl = imagePath
        currentCall?.clinicActivity![index].patientConsent = true
        currentCall?.clinicActivity![index].bloodGlucose = providedBGSReading
        currentCall?.clinicActivity![index].bloodPressure = providedBPReading
        currentCall?.clinicActivity![index].weight = providedWeight
        currentCall?.clinicActivity![index].city = providedCity
        currentCall?.clinicActivity![index].iNovoId = providediNovoId
        currentCall?.clinicActivity![index].SafetyEventReportByPatient = self.safetyEvent
        
        currentCall?.clinicActivity![index].AdverseDrugEvent = drugEvent
        currentCall?.clinicActivity![index].TechnicalIssue = technicalIssueEvent
        currentCall?.clinicActivity![index].GDM = GDMEvent
        currentCall?.clinicActivity![index].Hospitalization = hospitalizationEvent
        currentCall?.clinicActivity![index].OffLabel = offLabelEvent
        currentCall?.clinicActivity![index].MedicationErrorOverdoseOrMisuse = overDoseEvent
        
        self.currentCall?.clinicActivity![index].currentProductList = []
        
        self.currentCall?.clinicActivity![index].currentProductList!.append(CurrentProductList(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        
        currentCall?.clinicActivity![index].currentProductList![0].productId = self.currentNNId
        currentCall?.clinicActivity![index].currentProductList![0].deviceId = self.deviceDemoId
        currentCall?.clinicActivity![index].currentProductList![0].dose = doseTextField1.text
        currentCall?.clinicActivity![index].currentProductList![0].deviceDemo = true
        currentCall?.clinicActivity![index].currentProductList![0].Frequency = self.frequencyTextField1.text
        
        self.currentCall?.clinicActivity![index].concomitantProductList = []
        self.currentCall?.clinicActivity![index].concomitantProductList!.append(ConcomitantProductList(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        
        currentCall?.clinicActivity![index].concomitantProductList![0].productId = self.concomitantProId
        
        self.currentCall?.clinicActivity![index].concomitantOtherProductList = []
        self.currentCall?.clinicActivity![index].concomitantOtherProductList!.append(ConcomitantOtherProductList(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        
        currentCall?.clinicActivity![index].concomitantOtherProductList![0].otherProductId = self.concomitantOtherproId
        
        self.currentCall?.clinicActivity![index].previousProductList = []
        self.currentCall?.clinicActivity![index].previousProductList!.append(PreviousProductList(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        
        currentCall?.clinicActivity![index].previousProductList![0].productId = self.previousNNId
        
        self.currentCall?.clinicActivity![index].previousOtherProductList = []
        self.currentCall?.clinicActivity![index].previousOtherProductList!.append(PreviousOtherProductList(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        
        currentCall?.clinicActivity![index].previousOtherProductList![0].otherProductId = self.previousOtherId
        
        self.currentCall?.clinicActivity![index].discussionTopicList = []
        self.currentCall?.clinicActivity![index].discussionTopicList!.append(DiscussionTopicList(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        
        currentCall?.clinicActivity![index].discussionTopicList![0].discussionTopicId = self.selectedTopic?.id
        currentCall?.clinicActivity![index].discussionTopicList![0].explained = selectedTopic?.isExplained ?? false
        currentCall?.clinicActivity![index].discussionTopicList![0].hardCopyProvided = selectedTopic?.isHardcopy ?? false
        
        self.onPatientAdded?(self.currentCall)
        
        self.dismiss(animated: true, completion: nil)
        
        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage:"successfully submitted")
        
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.isexplainedselect, withJson: "false")
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.ishardselect, withJson: "false")
        
        namefeild.text = ""
        contactNumTextField.text = ""
        contactNum2TextField.text = ""
        cityTextField.text = ""
        addressTextField.text = ""
        address2TextField.text = ""
        iNovoIdTextField.text = ""
        typePatientTextField.text = ""
        CurrentNNProTextField.text = ""
        CurrentNNProTextField2.text = ""
        CurrentNNPro3TextField.text = ""
        deviceDemoTextField.text = ""
        deviceDemo2TextFeild.text = ""
        deviceDemoTextFeild3.text = ""
        concomitantNNproTextFeild.text = ""
        concomitantNNPro2TextFeild.text = ""
        concomitantNNPro3TextFeild.text = ""
        previousNNProTextfeild.text = ""
        previousNNPro2Textfeild.text = ""
        previousNNPro3Textfeild.text = ""
        previousOtherProTextfeild.text = ""
        previousOtherPro2Textfeild.text = ""
        previousOtherPro3Textfeild.text = ""
        BGSreadingTextField.text = ""
        BPreadingTextField.text = ""
        weightReadingTextField.text = ""
        concomitantOtherproTextFeild.text = ""
        concomitantOther2proTextFeild.text = ""
        concomitantOther3proTextFeild.text = ""
        doseTextField1.text = ""
        doseTextField2.text = ""
        doseTextField3.text = ""
        self.selectedTopic?.isExplained = false
        self.selectedTopic?.isHardcopy = false
        
    }
    
    @IBAction func onSaveBtnClicked(_ sender: Any) {
        
        let provideAttachment2 = attachmentTextField.text
        
        if provideAttachment2 == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Select Patient Consent")
            return
        }
        
        if (self.currentCall?.clinicActivity == nil) { self.currentCall?.clinicActivity = [] }
        
        self.currentCall?.clinicActivity?.append(ClinicActivity(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        let index = (self.currentCall?.clinicActivity?.count ?? 0) - 1
        currentCall?.clinicActivity![index].patientName = ""
        currentCall?.clinicActivity![index].patientType = ""
        currentCall?.clinicActivity![index].address1 = ""
        currentCall?.clinicActivity![index].address2 = ""
        currentCall?.clinicActivity![index].contactNumber1 = ""
        currentCall?.clinicActivity![index].contactNumber2 = ""
        currentCall?.clinicActivity![index].patientConsentAttachmentUrl = ""
        currentCall?.clinicActivity![index].patientConsent = false
        currentCall?.clinicActivity![index].bloodGlucose = ""
        currentCall?.clinicActivity![index].bloodPressure = ""
        currentCall?.clinicActivity![index].weight = ""
        currentCall?.clinicActivity![index].city = ""
        currentCall?.clinicActivity![index].iNovoId = ""
        currentCall?.clinicActivity![index].SafetyEventReportByPatient = self.safetyEvent
        
        currentCall?.clinicActivity![index].AdverseDrugEvent = drugEvent
        currentCall?.clinicActivity![index].TechnicalIssue = technicalIssueEvent
        currentCall?.clinicActivity![index].GDM = GDMEvent
        currentCall?.clinicActivity![index].Hospitalization = hospitalizationEvent
        currentCall?.clinicActivity![index].OffLabel = offLabelEvent
        currentCall?.clinicActivity![index].MedicationErrorOverdoseOrMisuse = overDoseEvent
        
        self.currentCall?.clinicActivity![index].currentProductList = []
        
        self.currentCall?.clinicActivity![index].currentProductList!.append(CurrentProductList(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        
        currentCall?.clinicActivity![index].currentProductList![0].productId = self.currentNNId
        currentCall?.clinicActivity![index].currentProductList![0].deviceId = self.deviceDemoId
        currentCall?.clinicActivity![index].currentProductList![0].dose = doseTextField1.text
        currentCall?.clinicActivity![index].currentProductList![0].deviceDemo = false
        currentCall?.clinicActivity![index].currentProductList![0].Frequency = self.frequencyTextField1.text
        
        self.currentCall?.clinicActivity![index].concomitantProductList = []
        self.currentCall?.clinicActivity![index].concomitantProductList!.append(ConcomitantProductList(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        
        currentCall?.clinicActivity![index].concomitantProductList![0].productId = self.concomitantProId
        
        self.currentCall?.clinicActivity![index].concomitantOtherProductList = []
        self.currentCall?.clinicActivity![index].concomitantOtherProductList!.append(ConcomitantOtherProductList(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        
        currentCall?.clinicActivity![index].concomitantOtherProductList![0].otherProductId = self.concomitantOtherproId
        
        self.currentCall?.clinicActivity![index].previousProductList = []
        self.currentCall?.clinicActivity![index].previousProductList!.append(PreviousProductList(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        
        currentCall?.clinicActivity![index].previousProductList![0].productId = self.previousNNId
        
        self.currentCall?.clinicActivity![index].previousOtherProductList = []
        self.currentCall?.clinicActivity![index].previousOtherProductList!.append(PreviousOtherProductList(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        
        currentCall?.clinicActivity![index].previousOtherProductList![0].otherProductId = self.previousOtherId
        
        self.currentCall?.clinicActivity![index].discussionTopicList = []
        self.currentCall?.clinicActivity![index].discussionTopicList!.append(DiscussionTopicList(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        
        currentCall?.clinicActivity![index].discussionTopicList![0].discussionTopicId = self.selectedTopic?.id
        currentCall?.clinicActivity![index].discussionTopicList![0].explained = selectedTopic?.isExplained ?? false
        currentCall?.clinicActivity![index].discussionTopicList![0].hardCopyProvided = selectedTopic?.isHardcopy ?? false
        
        self.onPatientAdded?(self.currentCall)
        
        self.dismiss(animated: true, completion: nil)
        
        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage:"successfully submitted")
        
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.isexplainedselect, withJson: "false")
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.ishardselect, withJson: "false")
        
        namefeild.text = ""
        contactNumTextField.text = ""
        contactNum2TextField.text = ""
        cityTextField.text = ""
        addressTextField.text = ""
        address2TextField.text = ""
        iNovoIdTextField.text = ""
        typePatientTextField.text = ""
        CurrentNNProTextField.text = ""
        CurrentNNProTextField2.text = ""
        CurrentNNPro3TextField.text = ""
        deviceDemoTextField.text = ""
        deviceDemo2TextFeild.text = ""
        deviceDemoTextFeild3.text = ""
        concomitantNNproTextFeild.text = ""
        concomitantNNPro2TextFeild.text = ""
        concomitantNNPro3TextFeild.text = ""
        previousNNProTextfeild.text = ""
        previousNNPro2Textfeild.text = ""
        previousNNPro3Textfeild.text = ""
        previousOtherProTextfeild.text = ""
        previousOtherPro2Textfeild.text = ""
        previousOtherPro3Textfeild.text = ""
        BGSreadingTextField.text = ""
        BPreadingTextField.text = ""
        weightReadingTextField.text = ""
        concomitantOtherproTextFeild.text = ""
        concomitantOther2proTextFeild.text = ""
        concomitantOther3proTextFeild.text = ""
        doseTextField1.text = ""
        doseTextField2.text = ""
        doseTextField3.text = ""
        self.selectedTopic?.isExplained = false
        self.selectedTopic?.isHardcopy = false
        
    }
    
    @IBAction func onSubmitClick(_ sender: Any) {
        
        CommonUtils.showQuesBoxWithButtons(title: "Novo", message: "Do you want to submit this form", controller: self, onYesClicked: {()
            self.addPatientActivity()
            
        }, onNoClicked: {()
            
            return
            
        })
        
    }
    
    @IBAction func onBackClicked(_ sender: Any) {
        
        CommonUtils.showQuesBoxWithButtons(title: "Novo", message: "Do you want to end Call with this Patient", controller: self, onYesClicked: {()
            self.dismiss(animated: true, completion: nil)
            
        }, onNoClicked: {()
            return
            
        })
        
    }
    
}
