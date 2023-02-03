//
//  VisitViewController.swift
//  E-detailer
//
//  Created by Macbook Air on 10/11/2021.
//  Copyright © 2021 Ammad. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import ObjectMapper

class VisitViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var patientConsentTextfield: UITextField!
    @IBOutlet weak var prescriptionTextfield: UITextField!
    @IBOutlet weak var visitObjectiveTextfield: UITextField!
    @IBOutlet weak var productNN1textfield: UITextField!
    @IBOutlet weak var productNN2Textfield: UITextField!
    @IBOutlet weak var productNN3Textfield: UITextField!
    @IBOutlet weak var productConcomitant1Textfield: UITextField!
    @IBOutlet weak var productConcomitant2Textfield: UITextField!
    @IBOutlet weak var productConcomitant3Textfield: UITextField!
    @IBOutlet weak var previousNN1Textfield: UITextField!
    @IBOutlet weak var previousNN2Textfield: UITextField!
    @IBOutlet weak var previousOtherProductTextfield: UITextField!
    @IBOutlet weak var infoNNProductTextfield: UITextField!
    @IBOutlet weak var deviceDemostrationTextfield: UITextField!
    @IBOutlet weak var readingBGSTextfield: UITextField!
    @IBOutlet weak var readingWeightTextfield: UITextField!
    @IBOutlet weak var readingBPTextfield: UITextField!
    @IBOutlet weak var educationProvideLayout: UIView!
    @IBOutlet weak var educationProvideCollectionView: UICollectionView!
    @IBOutlet weak var patientConstantView: UIView!
    @IBOutlet weak var prescriptionMainView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var patientConstantImageView: UIImageView!
    @IBOutlet weak var prescribtionImageView: UIImageView!
    @IBOutlet weak var safetyEventLabelView: UITextField!
    @IBOutlet weak var saftyFeildView: UIView!
    @IBOutlet weak var drugEventTextField: UITextField!
    @IBOutlet weak var tecnicalIssueField: UITextField!
    @IBOutlet weak var gDMTextField: UITextField!
    @IBOutlet weak var overDoseAndMisuseTextField: UITextField!
    @IBOutlet weak var hospitilaizationTextField: UITextField!
    @IBOutlet weak var reasonTextField: UITextField!
    @IBOutlet weak var offLabelTextfield: UITextField!
    @IBOutlet var mainViewOutlet: UIView!
    
    @IBOutlet weak var whiteViewOutlet: UIView!
    
    @IBOutlet weak var lastView: UIButton!
    @IBOutlet weak var firstView: UIView!
    var safetyEvent : Bool?
    var drugEvents : Bool?
    var technicalIssueEvent : Bool?
    var gDMEvent : Bool?
    var overDoseEvent : Bool?
    var hospitilaizationEvent : Bool?
    var reasonEvent : Bool?
    var offLabelEvent : Bool?
    var homeActivityDiscussionTopic: Dictionary<String, Any> = [:]
    var dropDownInfo: PatientResult?
    weak var pickerView: UIPickerView?
    var previousNN: [String] = ["", "" , ""]
    var productConcomitant: [String] = ["", "" , ""]
    var productNN: [String] = ["", "" , ""]
    var patientConsent = ["No", "Yes"]
    var visitObject = ["Device Demo", "Injecting Techiniques"]
    var sampleArray = ["a","b","c"]
    var educationProvideDataSource: HomeEducationListCell!
    var selectedPatient: Patients? = nil
    var startTime: String?
    var activitiyViewController: ActivityViewController!
    var imagePicker: UIImagePickerController!
    var imagePickerRequestFor: String? = ""
    var patientConsentUrl: String? = ""
    var prescribtionUrl: String? = ""
    var maxLength : Int?
    
    override func viewDidLoad() {
        
        readingBPTextfield.delegate = self
        readingWeightTextfield.delegate = self
        readingBGSTextfield.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboarddisAppear), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        activitiyViewController = ActivityViewController(message: "Loading...")
        loadImagePicker()
        startTime = String(CommonUtils.getCurrentTime())
        
        //!--- Get dropdown data
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.callProductApi()
        }
        
        self.scrollView.isScrollEnabled = false
        
        
        //        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        educationProvideDataSource = HomeEducationListCell()
        educationProvideDataSource.onSelect = { (topic, isExplained, isHardCopy) in
            self.homeActivityDiscussionTopic[String(describing: topic.id)] = [
                "Explained" : isExplained,
                "DiscussionTopicId" : topic.id ?? 0,
                "HardCopyProvided" : isHardCopy
            ]
            
            CommonUtils.saveJsonToUserDefaults(forKey: Constants.ishardCopy, withJson: String(isHardCopy))
            CommonUtils.saveJsonToUserDefaults(forKey: Constants.isexplained, withJson: String(isExplained))
        }
        educationProvideCollectionView.dataSource = educationProvideDataSource
        
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        
        patientConsentTextfield.delegate = self
        patientConsentTextfield.inputView = pickerView
        
        drugEventTextField.delegate = self
        drugEventTextField.inputView = pickerView
        
        tecnicalIssueField.delegate = self
        tecnicalIssueField.inputView = pickerView
        
        gDMTextField.delegate = self
        gDMTextField.inputView = pickerView
        
        overDoseAndMisuseTextField.delegate = self
        overDoseAndMisuseTextField.inputView = pickerView
        
        hospitilaizationTextField.delegate = self
        hospitilaizationTextField.inputView = pickerView
        
        reasonTextField.delegate = self
        reasonTextField.inputView = pickerView
        
        offLabelTextfield.delegate = self
        offLabelTextfield.inputView = pickerView
        
        safetyEventLabelView.delegate = self
        safetyEventLabelView.inputView = pickerView
        
        prescriptionTextfield.delegate = self
        prescriptionTextfield.inputView = pickerView
        
        infoNNProductTextfield.delegate = self
        infoNNProductTextfield.inputView = pickerView
        
        deviceDemostrationTextfield.delegate = self
        deviceDemostrationTextfield.inputView = pickerView
        
        visitObjectiveTextfield.delegate = self
        visitObjectiveTextfield.inputView = pickerView
        
        previousNN1Textfield.delegate = self
        previousNN1Textfield.inputView = pickerView
        
        previousNN2Textfield.delegate = self
        previousNN2Textfield.inputView = pickerView
        
        previousOtherProductTextfield.delegate = self
        previousOtherProductTextfield.inputView = pickerView
        
        productNN1textfield.delegate = self
        productNN1textfield.inputView = pickerView
        
        productNN2Textfield.delegate = self
        productNN2Textfield.inputView = pickerView
        
        productNN3Textfield.delegate = self
        productNN3Textfield.inputView = pickerView
        
        productConcomitant1Textfield.delegate = self
        productConcomitant1Textfield.inputView = pickerView
        
        productConcomitant2Textfield.delegate = self
        productConcomitant2Textfield.inputView = pickerView
        
        productConcomitant3Textfield.delegate = self
        productConcomitant3Textfield.inputView = pickerView
        
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
        
        drugEventTextField.inputAccessoryView = toolBar
        tecnicalIssueField.inputAccessoryView = toolBar
        gDMTextField.inputAccessoryView = toolBar
        overDoseAndMisuseTextField.inputAccessoryView = toolBar
        hospitilaizationTextField.inputAccessoryView = toolBar
        reasonTextField.inputAccessoryView = toolBar
        offLabelTextfield.inputAccessoryView = toolBar
        patientConsentTextfield.inputAccessoryView = toolBar
        safetyEventLabelView.inputAccessoryView = toolBar
        prescriptionTextfield.inputAccessoryView = toolBar
        infoNNProductTextfield.inputAccessoryView = toolBar
        deviceDemostrationTextfield.inputAccessoryView = toolBar
        visitObjectiveTextfield.inputAccessoryView = toolBar
        previousNN1Textfield.inputAccessoryView = toolBar
        previousNN2Textfield.inputAccessoryView = toolBar
        previousOtherProductTextfield.inputAccessoryView = toolBar
        productNN1textfield.inputAccessoryView = toolBar
        productNN2Textfield.inputAccessoryView = toolBar
        productNN3Textfield.inputAccessoryView = toolBar
        productConcomitant1Textfield.inputAccessoryView = toolBar
        productConcomitant2Textfield.inputAccessoryView = toolBar
        productConcomitant3Textfield.inputAccessoryView = toolBar
        
        self.pickerView = pickerView
        
        if safetyEventLabelView.text == "NO" || safetyEventLabelView.text == "" {
            saftyFeildView.isHidden = true
        }
        
    }
    var isExpand : Bool = false
    
    @objc func keyboardAppear() {
        if !isExpand {
            
            self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.scrollView.frame.height + 2450 )
            isExpand = true
        }
        
        
    }
    
    @objc func keyboarddisAppear() {
        
        if !isExpand {
            
            self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.scrollView.frame.height - 2450 )
            isExpand = false
        }
        
    }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == readingBGSTextfield{
            maxLength = 9
        }else if textField == readingBPTextfield{
            maxLength = 9
        } else if textField == readingWeightTextfield{
            maxLength = 9
        }
        
        let currentString: NSString = textField.text! as NSString
        
        let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength ?? 0
    }
    
    func callProductApi() {
        activitiyViewController.show(existingUiViewController: self)
        CallApi().getAllPatient(url: Constants.GetPatientDataApi, completionHandler: {(getPatientDataModel: GetPatientDataModel?, error: String?) in
            self.activitiyViewController.dismiss(animated: false, completion: {
                if (error != nil) {
                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: error!)
                    return
                }
                
                //temp variable
                let getPatientDataModelCopy =  getPatientDataModel
                
                //On Dialog Close
                if getPatientDataModelCopy != nil {
                    if (getPatientDataModelCopy?.success)! {
                        self.dropDownInfo = getPatientDataModel?.result
                        self.educationProvideDataSource.setItems(items: getPatientDataModel?.result?.educationalActivityViewModel?.educationalActivityDiscussionTopic)
                        self.educationProvideCollectionView.reloadData()
                    } else {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (getPatientDataModel?.error!)!)
                    }
                } else {
                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: "Empty Response is coming from server")
                }
            })
        })
    }
    
    @objc func donePicker(){
        
        self.drugEventTextField.resignFirstResponder()
        self.tecnicalIssueField.resignFirstResponder()
        self.gDMTextField.resignFirstResponder()
        self.overDoseAndMisuseTextField.resignFirstResponder()
        self.hospitilaizationTextField.resignFirstResponder()
        self.reasonTextField.resignFirstResponder()
        self.offLabelTextfield.resignFirstResponder()
        self.patientConsentTextfield.resignFirstResponder()
        self.safetyEventLabelView.resignFirstResponder()
        self.infoNNProductTextfield.resignFirstResponder()
        self.prescriptionTextfield.resignFirstResponder()
        self.deviceDemostrationTextfield.resignFirstResponder()
        self.visitObjectiveTextfield.resignFirstResponder()
        self.previousNN1Textfield.resignFirstResponder()
        self.previousNN2Textfield.resignFirstResponder()
        self.previousOtherProductTextfield.resignFirstResponder()
        self.productNN1textfield.resignFirstResponder()
        self.productNN2Textfield.resignFirstResponder()
        self.productNN3Textfield.resignFirstResponder()
        self.productConcomitant1Textfield.resignFirstResponder()
        self.productConcomitant2Textfield.resignFirstResponder()
        self.productConcomitant3Textfield.resignFirstResponder()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.pickerView?.reloadAllComponents()
        self.pickerView?.selectedRow(inComponent: 0)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if patientConsentTextfield.isFirstResponder{
            return (self.patientConsent.count)
        }else if drugEventTextField.isFirstResponder{
            return (self.patientConsent.count)
        } else if tecnicalIssueField.isFirstResponder{
            return (self.patientConsent.count)
        } else if gDMTextField.isFirstResponder{
            return (self.patientConsent.count)
        } else if overDoseAndMisuseTextField.isFirstResponder{
            return (self.patientConsent.count)
        } else if hospitilaizationTextField.isFirstResponder{
            return (self.patientConsent.count)
        } else if reasonTextField.isFirstResponder{
            return (self.patientConsent.count)
        } else if offLabelTextfield.isFirstResponder{
            return (self.patientConsent.count)
        }  else if safetyEventLabelView.isFirstResponder{
            return (self.patientConsent.count)
        } else if prescriptionTextfield.isFirstResponder{
            return (self.patientConsent.count)
        }else if infoNNProductTextfield.isFirstResponder{
            return (self.patientConsent.count)
        }else if deviceDemostrationTextfield.isFirstResponder{
            return (self.patientConsent.count)
        }else if visitObjectiveTextfield.isFirstResponder{
            return (self.visitObject.count)
        }else if previousOtherProductTextfield.isFirstResponder{
            return (self.dropDownInfo?.educationalActivityViewModel?.educationalActivityOtherProduct?.count ?? 0)
        }else if productNN1textfield.isFirstResponder || productNN2Textfield.isFirstResponder || productNN3Textfield.isFirstResponder || productConcomitant1Textfield.isFirstResponder || productConcomitant2Textfield.isFirstResponder || productConcomitant3Textfield.isFirstResponder || previousNN2Textfield.isFirstResponder || previousNN1Textfield.isFirstResponder{
            return (self.dropDownInfo?.educationalActivityViewModel?.educationalActivityProduct?.count ?? 0)
        }
        return 0
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if patientConsentTextfield.isFirstResponder{
            return self.patientConsent[row]
        }
        else if drugEventTextField.isFirstResponder{
            return self.patientConsent[row]
        }
        else if tecnicalIssueField.isFirstResponder{
            return self.patientConsent[row]
        }
        else if gDMTextField.isFirstResponder{
            return self.patientConsent[row]
        }
        else if overDoseAndMisuseTextField.isFirstResponder{
            return self.patientConsent[row]
        }
        else if hospitilaizationTextField.isFirstResponder{
            return self.patientConsent[row]
        }
        else if reasonTextField.isFirstResponder{
            return self.patientConsent[row]
        }else if offLabelTextfield.isFirstResponder{
            return self.patientConsent[row]
        }else if safetyEventLabelView.isFirstResponder{
            return self.patientConsent[row]
        }else if prescriptionTextfield.isFirstResponder{
            return self.patientConsent[row]
        }else if infoNNProductTextfield.isFirstResponder{
            return self.patientConsent[row]
        }else if deviceDemostrationTextfield.isFirstResponder{
            return self.patientConsent[row]
        }else if visitObjectiveTextfield.isFirstResponder{
            return self.visitObject[row]
        } else if previousOtherProductTextfield.isFirstResponder{
            return self.dropDownInfo?.educationalActivityViewModel?.educationalActivityOtherProduct?[row].name ?? ""
        } else if productNN1textfield.isFirstResponder || productNN2Textfield.isFirstResponder || productNN3Textfield.isFirstResponder || productConcomitant1Textfield.isFirstResponder || productConcomitant2Textfield.isFirstResponder || productConcomitant3Textfield.isFirstResponder || previousNN1Textfield.isFirstResponder || previousNN2Textfield.isFirstResponder {
            return self.dropDownInfo?.educationalActivityViewModel?.educationalActivityProduct?[row].name ?? ""
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if patientConsentTextfield.isFirstResponder{
            let itemselected = self.patientConsent[row]
            patientConsentTextfield.text = itemselected
            
            if (itemselected.lowercased().elementsEqual("yes")) {
                patientConstantView.isHidden = false
                self.scrollView.isScrollEnabled = true
                
                self.whiteViewOutlet.isHidden = true
            } else {
                patientConstantView.isHidden = true
                self.scrollView.isScrollEnabled = false
                
                self.whiteViewOutlet.isHidden = false
            }
        }else if prescriptionTextfield.isFirstResponder{
            let itemselected = self.patientConsent[row]
            prescriptionTextfield.text = itemselected
            if (itemselected.lowercased().elementsEqual("yes")) {
                prescriptionMainView.isHidden = false
            } else {
                prescriptionMainView.isHidden = true
            }
        }
        
        
        //    var safetyEvent : Bool?
        //    var drugEvent : Bool?
        //    var technicalIssueEvent : Bool?
        //    var gDMEvent : Bool?
        //    var overDoseEvent : Bool?
        //    var hospitilaizationEvent : Bool?
        //    var reasonEvent : Bool?
        //    var offLabelEvent : Bool?
        else if safetyEventLabelView.isFirstResponder{
            let itemselected = self.patientConsent[row]
            safetyEventLabelView.text = itemselected
            if (itemselected.lowercased().elementsEqual("yes")) {
                saftyFeildView.isHidden = false
                self.safetyEvent = true
            } else {
                saftyFeildView.isHidden = true
                self.safetyEvent = false
            }
        }else if drugEventTextField.isFirstResponder{
            let itemselected = self.patientConsent[row]
            drugEventTextField.text = itemselected
            if (itemselected.lowercased().elementsEqual("yes")) {
                self.drugEvents = true
            } else {
                self.drugEvents = false
            }
        }else if tecnicalIssueField.isFirstResponder{
            let itemselected = self.patientConsent[row]
            tecnicalIssueField.text = itemselected
            if (itemselected.lowercased().elementsEqual("yes")) {
                self.technicalIssueEvent = true
            } else {
                self.technicalIssueEvent = false
            }
        }else if gDMTextField.isFirstResponder{
            let itemselected = self.patientConsent[row]
            gDMTextField.text = itemselected
            if (itemselected.lowercased().elementsEqual("yes")) {
                self.gDMEvent = true
            } else {
                self.gDMEvent = false
            }
        }else if overDoseAndMisuseTextField.isFirstResponder{
            let itemselected = self.patientConsent[row]
            overDoseAndMisuseTextField.text = itemselected
            if (itemselected.lowercased().elementsEqual("yes")) {
                self.overDoseEvent = true
            } else {
                self.overDoseEvent = false
            }
        }else if hospitilaizationTextField.isFirstResponder{
            let itemselected = self.patientConsent[row]
            hospitilaizationTextField.text = itemselected
            if (itemselected.lowercased().elementsEqual("yes")) {
                self.hospitilaizationEvent = true
            } else {
                self.hospitilaizationEvent = false
            }
        }else if reasonTextField.isFirstResponder{
            let itemselected = self.patientConsent[row]
            reasonTextField.text = itemselected
            if (itemselected.lowercased().elementsEqual("yes")) {
                self.reasonEvent = true
            } else {
                self.reasonEvent = false
            }
        }else if offLabelTextfield.isFirstResponder{
            let itemselected = self.patientConsent[row]
            offLabelTextfield.text = itemselected
            if (itemselected.lowercased().elementsEqual("yes")) {
                self.offLabelEvent = true
            } else {
                self.offLabelEvent = false
            }
        }else if infoNNProductTextfield.isFirstResponder{
            let itemselected = self.patientConsent[row]
            infoNNProductTextfield.text = itemselected
        }else if deviceDemostrationTextfield.isFirstResponder{
            let itemselected = self.patientConsent[row]
            deviceDemostrationTextfield.text = itemselected
        }else if visitObjectiveTextfield.isFirstResponder{
            let itemselected = self.visitObject[row]
            visitObjectiveTextfield.text = itemselected
        }else if previousNN1Textfield.isFirstResponder{
            let n = self.dropDownInfo?.educationalActivityViewModel?.educationalActivityProduct?[row]
            previousNN1Textfield.text = n?.name
            previousNN[0] = String(describing: n?.id ?? 0)
        }else if previousNN2Textfield.isFirstResponder{
            let n = self.dropDownInfo?.educationalActivityViewModel?.educationalActivityProduct?[row]
            previousNN2Textfield.text = n?.name
            previousNN[1] = String(describing: n?.id ?? 0)
        }else if previousOtherProductTextfield.isFirstResponder{
            let n = self.dropDownInfo?.educationalActivityViewModel?.educationalActivityOtherProduct?[row]
            previousOtherProductTextfield.text = n?.name
            previousNN[2] = String(describing: n?.id ?? 0)
        }else if productNN1textfield.isFirstResponder{
            let n = self.dropDownInfo?.educationalActivityViewModel?.educationalActivityProduct?[row]
            productNN1textfield.text = n?.name
            productNN[0] = String(describing: n?.id ?? 0)
        }else if productNN2Textfield.isFirstResponder{
            let n = self.dropDownInfo?.educationalActivityViewModel?.educationalActivityProduct?[row]
            productNN2Textfield.text = n?.name
            productNN[1] = String(describing: n?.id ?? 0)
        }else if productNN3Textfield.isFirstResponder{
            let n = self.dropDownInfo?.educationalActivityViewModel?.educationalActivityProduct?[row]
            productNN3Textfield.text = n?.name
            productNN[2] = String(describing: n?.id ?? 0)
        }else if productConcomitant1Textfield.isFirstResponder{
            let n = self.dropDownInfo?.educationalActivityViewModel?.educationalActivityProduct?[row]
            productConcomitant1Textfield.text = n?.name
            productConcomitant[0] = String(describing: n?.id ?? 0)
        }else if productConcomitant2Textfield.isFirstResponder{
            let n = self.dropDownInfo?.educationalActivityViewModel?.educationalActivityProduct?[row]
            productConcomitant2Textfield.text = n?.name
            productConcomitant[1] = String(describing: n?.id ?? 0)
        }else if productConcomitant3Textfield.isFirstResponder{
            let n = self.dropDownInfo?.educationalActivityViewModel?.educationalActivityProduct?[row]
            productConcomitant3Textfield.text = n?.name
            productConcomitant[2] = String(describing: n?.id ?? 0)
        }
    }
    @IBAction func onPrescribtionTaken(_ sender: Any) {
        imagePickerRequestFor = "Prescribtion"
        showImagePicker()
    }
    
    @IBAction func onPatientImageRequested(_ sender: Any) {
        imagePickerRequestFor = "PatientImage"
        showImagePicker()
    }
    
    @IBAction func onSave(_ sender: Any) {
        
        CommonUtils.showQuesBoxWithButtons(title: "Novo", message: "Do you want to submit this form", controller: self, onYesClicked: {()
            self.callVisitApi()
            
        }, onNoClicked: {()
            
            return
            
        })
        
    }
    
    func callVisitApi() {
        
        let objective = visitObjectiveTextfield.text
        let patientConseut = patientConsentTextfield.text
        let prescription = prescriptionTextfield.text
        let productNN1 = productNN1textfield.text
        let productNN2 = productNN2Textfield.text
        let productNN3 = productNN3Textfield.text
        let productConcomitant1 = productConcomitant1Textfield.text
        let productConcomitant2 = productConcomitant2Textfield.text
        let productConcomitant3 = productConcomitant3Textfield.text
        let previousNN1 = previousNN1Textfield.text
        let previousNN2 = previousNN2Textfield.text
        let previousOtherProduct = previousOtherProductTextfield.text
        let infoNNProduct = infoNNProductTextfield.text
        let deviceDemostration = deviceDemostrationTextfield.text
        let readingBGS = readingBGSTextfield.text
        let readingWeight = readingWeightTextfield.text
        let readingBP = readingBPTextfield.text
        let isHardCopy = CommonUtils.getJsonFromUserDefaults(forKey: Constants.ishardCopy)
        let isExplained = CommonUtils.getJsonFromUserDefaults(forKey: Constants.isexplained)
        let drugEvent = drugEventTextField.text
        let technicalIssue = tecnicalIssueField.text
        let prvideGDM = gDMTextField.text
        let overDose = overDoseAndMisuseTextField.text
        let hospitilaization = hospitilaizationTextField.text
        let reason = reasonTextField.text
        let offLabel = offLabelTextfield.text
        
        if patientConseut == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Select the Patient Consent")
            return
        }
        if prescription == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Select the Prescription")
            return
        }
        if objective == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Select the Objective")
            return
        }
        if productNN1 == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the NN Product")
            return
        }
        if productNN2 == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the NN Product 2")
            return
        }
        if productNN3 == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the NN Product 3")
            return
        }
        if productConcomitant1 == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the Concomitant Product 1")
            return
        }
        if productConcomitant2 == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the Concomitant Product 2")
            return
        }
        if productConcomitant3 == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the Concomitant Product 3")
            return
        }
        if previousNN1 == ""  {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the Previous NN Product")
            return
        }
        if previousNN2 == ""  {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the Previous NN2 Product")
            return
        }
        if previousOtherProduct == ""  {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the PreviousOther Product")
            return
        }
        if infoNNProduct == ""  {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the infoNN Product")
            return
        }
        if deviceDemostration == ""  {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the Device Demostration")
            return
        }
        if isHardCopy == "false" && isExplained == "false" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Provide Type Of Education")
            return
        }
        if readingBGS == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the Reading BGS")
            return
        }
        if readingWeight == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the Reading Weight")
            return
        }
        if readingBP == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the Reading BP")
            return
        }
        if safetyEventLabelView.text == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Select Safety event")
            return
        }
        
        if safetyEventLabelView.text == "Yes" {
            
            if drugEvent == "" {
                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Select drug event")
                return
            }
            if technicalIssue == "" {
                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Select technical issue")
                return
            }
            if prvideGDM == "" {
                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Select GDM")
                return
            }
            if overDose == "" {
                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Select overdose or misuse")
                return
            }
            if hospitilaization == "" {
                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Select hospitilaization")
                return
            }
            if reason == "" {
                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Select reason")
                return
            }
            if offLabel == "" {
                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Select Off Label")
                return
            }
            
        }
        
        activitiyViewController.show(existingUiViewController: self)
        
        let userId = CommonUtils.getJsonFromUserDefaults(forKey: Constants.EMP_ID)
        
        var params = Dictionary<String, Any>()
        params["PatientId"] = self.selectedPatient?.patientId
        
        params["Lat"] = CommonUtils.getJsonFromUserDefaults(forKey: Constants.LatitudeKey)
        params["Lng"] = CommonUtils.getJsonFromUserDefaults(forKey: Constants.LongitudeKey)
        params["EmployeeUserId"] = userId
        let startTym = startTime
        if startTym == ""{
            params["StartTime"] = 0.0
        }else{
            params["StartTime"] = Double(startTime ?? "")
        }
        
        params["EndTime"] = CommonUtils.getCurrentTime()
        params["ActivityObjective"] = objective
        params["PatinetConsent"] = patientConseut?.elementsEqual("Yes")
        params["ActivityType"] = "Visit"
        params["PatinetConsentAttachmentUrl"] = self.patientConsentUrl
        params["PrescriptionAvailable"] = prescription?.elementsEqual("Yes")
        params["PrescriptionAttachmentUrl"] = self.prescribtionUrl
        params["InformationAboutProductGiven"] = infoNNProduct
        params["DeviceDemonstrationGiven"] = deviceDemostration
        params["BloodGlucose"] = readingBGS
        params["BloodPressure"] = readingBP
        params["Weight"] = readingWeight
        params["FeedbackStars"] = "5"
        params["SafetyEventReportByPatient"] = self.safetyEvent
        params["AdverseDrugEvent"] = self.drugEvents
        params["TechnicalIssue"] = self.technicalIssueEvent
        params["GDM"] = self.gDMEvent
        params["OffLabel"] = self.offLabelEvent
        params["MedicationErrorOverdoseOrMisuse"] = self.overDoseEvent
        params["Hospitalization"] = self.hospitilaizationEvent
        
        params["HomeActivityConcomitantProduct"] = productConcomitant.map({ id -> Dictionary<String, Any> in
            return ["ProductId": id]
        })
        params["HomeActivityCurrentProduct"] = productNN.map({ id -> Dictionary<String, Any> in
            return ["ProductId": id]
        })
        
        var homeActivityPreviousProduct: [Dictionary<String, Any>] = []
        homeActivityPreviousProduct.append(["ProductId": previousNN[0] ])
        homeActivityPreviousProduct.append(["ProductId": previousNN[1] ])
        params["HomeActivityPreviousProduct"] = homeActivityPreviousProduct
        
        var homeActivityPreviousOtherProduct: [Dictionary<String, Any>] = []
        homeActivityPreviousOtherProduct.append(["OtherProductId": previousNN[0]])
        params["HomeActivityPreviousOtherProduct"] = homeActivityPreviousOtherProduct
        
        var HomeActivityDiscussionTopic: [Dictionary<String, Any>] = []
        for (_, value) in self.homeActivityDiscussionTopic {
            HomeActivityDiscussionTopic.append(value as! Dictionary<String, Any>)
        }
        
        params["HomeActivityDiscussionTopic"] = HomeActivityDiscussionTopic
        
        var HomeActivity: [Dictionary<String, Any>] = []
        HomeActivity.append(params)
        
        Alamofire.request(Constants.SyncHomeActivity, method: .post, parameters: ["HomeActivity": HomeActivity], encoding: JSONEncoding.default, headers: nil)
            .responseString(completionHandler: {(response) in
                // On Response
                self.activitiyViewController.dismiss(animated: true, completion: {() in
                    
                    //On Dialog Close
                    if (response.error != nil) {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (response.error?.localizedDescription)!)
                        return
                    }
                    
                    if (response.value == "1") {
                        
                        CommonUtils.saveJsonToUserDefaults(forKey: Constants.isexplained, withJson: "false")
                        CommonUtils.saveJsonToUserDefaults(forKey: Constants.ishardCopy, withJson: "false")
                        
                        CommonUtils.saveJsonToUserDefaults(forKey: Constants.LastTimeOfUpload, withJson: String(CommonUtils.getCurrentTime()))
                        
                        
                        CommonUtils.saveJsonToUserDefaults(forKey: Constants.CallToUploadKey, withJson: "[]")
                        self.dismiss(animated: false, completion: {
                            self.dismiss(animated: true, completion: nil)
                        })
                    } else {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "eDetailer", withMessage: response.value!)
                    }
                })
            })
    }
    
    
    func callVisit() {
        
        let objective = visitObjectiveTextfield.text
        let patientConseut = patientConsentTextfield.text
        let prescription = prescriptionTextfield.text
        let productNN1 = productNN1textfield.text
        let productNN2 = productNN2Textfield.text
        let productNN3 = productNN3Textfield.text
        let productConcomitant1 = productConcomitant1Textfield.text
        let productConcomitant2 = productConcomitant2Textfield.text
        let productConcomitant3 = productConcomitant3Textfield.text
        let previousNN1 = previousNN1Textfield.text
        let previousNN2 = previousNN2Textfield.text
        let previousOtherProduct = previousOtherProductTextfield.text
        let infoNNProduct = infoNNProductTextfield.text
        let deviceDemostration = deviceDemostrationTextfield.text
        let readingBGS = readingBGSTextfield.text
        let readingWeight = readingWeightTextfield.text
        let readingBP = readingBPTextfield.text
        let isHardCopy = CommonUtils.getJsonFromUserDefaults(forKey: Constants.ishardCopy)
        let isExplained = CommonUtils.getJsonFromUserDefaults(forKey: Constants.isexplained)
        let drugEvent = drugEventTextField.text
        let technicalIssue = tecnicalIssueField.text
        let prvideGDM = gDMTextField.text
        let overDose = overDoseAndMisuseTextField.text
        let hospitilaization = hospitilaizationTextField.text
        let reason = reasonTextField.text
        let offLabel = offLabelTextfield.text
        
        if patientConseut == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Select the Patient Consent")
            return
        }
        
        activitiyViewController.show(existingUiViewController: self)
        
        let userId = CommonUtils.getJsonFromUserDefaults(forKey: Constants.EMP_ID)
        
        var params = Dictionary<String, Any>()
        params["PatientId"] = self.selectedPatient?.patientId
        
        params["Lat"] = CommonUtils.getJsonFromUserDefaults(forKey: Constants.LatitudeKey)
        params["Lng"] = CommonUtils.getJsonFromUserDefaults(forKey: Constants.LongitudeKey)
        params["EmployeeUserId"] = userId
        let startTym = startTime
        if startTym == ""{
            params["StartTime"] = 0.0
        }else{
            params["StartTime"] = Double(startTime ?? "")
        }
        
        params["EndTime"] = CommonUtils.getCurrentTime()
        params["ActivityObjective"] = nil
        params["PatinetConsent"] = "No"
        params["ActivityType"] = "Visit"
        params["PatinetConsentAttachmentUrl"] = nil
        params["PrescriptionAvailable"] = prescription?.elementsEqual("No")
        params["PrescriptionAttachmentUrl"] = nil
        params["InformationAboutProductGiven"] = ""
        params["DeviceDemonstrationGiven"] = ""
        params["BloodGlucose"] = ""
        params["BloodPressure"] = ""
        params["Weight"] = ""
        params["FeedbackStars"] = "5"
        params["SafetyEventReportByPatient"] = false
        params["AdverseDrugEvent"] = false
        params["TechnicalIssue"] = false
        params["GDM"] = false
        params["OffLabel"] = false
        params["MedicationErrorOverdoseOrMisuse"] = false
        params["Hospitalization"] = false
        params["HomeActivityConcomitantProduct"] = []
        params["HomeActivityCurrentProduct"] = []
        params["HomeActivityPreviousProduct"] = []
        params["HomeActivityPreviousOtherProduct"] = []
        params["HomeActivityDiscussionTopic"] = []
        
        var HomeActivity: [Dictionary<String, Any>] = []
        HomeActivity.append(params)
        
        Alamofire.request(Constants.SyncHomeActivity, method: .post, parameters: ["HomeActivity": HomeActivity], encoding: JSONEncoding.default, headers: nil)
            .responseString(completionHandler: {(response) in
                // On Response
                self.activitiyViewController.dismiss(animated: true, completion: {() in
                    
                    //On Dialog Close
                    if (response.error != nil) {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (response.error?.localizedDescription)!)
                        return
                    }
                    
                    if (response.value == "1") {
                        
                        CommonUtils.saveJsonToUserDefaults(forKey: Constants.isexplained, withJson: "false")
                        CommonUtils.saveJsonToUserDefaults(forKey: Constants.ishardCopy, withJson: "false")
                        
                        CommonUtils.saveJsonToUserDefaults(forKey: Constants.LastTimeOfUpload, withJson: String(CommonUtils.getCurrentTime()))
                        
                        
                        CommonUtils.saveJsonToUserDefaults(forKey: Constants.CallToUploadKey, withJson: "[]")
                        self.dismiss(animated: false, completion: {
                            self.dismiss(animated: true, completion: nil)
                        })
                    } else {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "eDetailer", withMessage: response.value!)
                    }
                })
            })
        
    }
    
    @IBAction func onSaveClicked(_ sender: Any) {
        
        CommonUtils.showQuesBoxWithButtons(title: "Novo", message: "Do you want to submit this form", controller: self, onYesClicked: {()
            self.callVisit()
            
        }, onNoClicked: {()
            
            return
            
        })
        
    }
    @IBAction func onBackClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension VisitViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func loadImagePicker()  {
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
#if targetEnvironment(simulator)
        imagePicker.sourceType = .photoLibrary
#else
        imagePicker.sourceType = .camera
#endif
    }
    
    //MARK: - Add image to Library
    func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    func showImagePicker() {
        present(imagePicker, animated: true, completion: nil)
    }
    
    //MARK: - Done image capture here
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.dismiss(animated: true, completion: {
            let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            if (self.imagePickerRequestFor == "PatientImage") {
                self.patientConstantImageView.image = image
            } else {
                self.prescribtionImageView.image = image
            }
            self.uploadImage(image: image)
        })
    }
    
    func uploadImage(image: UIImage?) {
//        activitiyViewController.show(existingUiViewController: self)
//
//        let imageData = image!.jpegData(compressionQuality: 0.2)!
//        AF.upload(multipartFormData: { (form) in
//            let uuid = UUID().uuidString
//            form.append(imageData, withName: "file", fileName: "\(uuid).jpg", mimeType: "image/jpg")
//        }, to: Constants.FileUploadApi, encodingCompletion: { result in
//            switch result {
//            case .success(let upload, _, _):
//                upload.responseString { response in
//                    self.activitiyViewController.dismiss()
//                    if (response.error != nil) {
//                        return
//                    }
//                    //On Dialog Close
//                    let imageUploadModel = Mapper<ImageUploadModel>().map(JSONString: response.value!) //JSON to model
//                    if (imageUploadModel?.success!)! && (imageUploadModel?.result!.count)! > 0 {
//                        if (self.imagePickerRequestFor == "PatientImage") {
//                            self.patientConsentUrl = imageUploadModel?.result![0]
//                        } else {
//                            self.prescribtionUrl = imageUploadModel?.result![0]
//                        }
//                    }
//                }
//            case .failure(let encodingError):
//                print(encodingError)
//            }
//        })
        
    }
}
