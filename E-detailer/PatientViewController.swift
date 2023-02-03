//
//  PatientViewController.swift
//  E-detailer
//
//  Created by Macbook Air on 08/11/2021.
//  Copyright © 2021 Ammad. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import ObjectMapper
import RLBAlertsPickers
import ActionSheetPicker_3_0
import DatePickerDialog

class PatientViewController: UIViewController {
    
    @IBOutlet weak var patientListCollectionView: UICollectionView!
    
    var plannedPatientDataSource: PlannedPatientListCell!
    var indicator: UIActivityIndicatorView!
    var activitiyViewController: ActivityViewController!
    var selectedTab: String = "0"
    var allPatients: [Patients]?
    var plannedPatients: [Patients]?
    var selectedPatient: Patients? = nil
    var selectedPlan: Patients?
    @IBOutlet weak var allPatientView: UIView!
    @IBOutlet weak var plannedPatientView: UIView!
    @IBOutlet weak var showDatePlanLabel: UILabel!
    @IBOutlet weak var dropDownImg: UIImageView!
    @IBOutlet weak var plannedBtnOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //getCurrentDate
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let result = formatter.string(from: date)
        self.showDatePlanLabel.text = result
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.selectedDate, withJson: result)
        
        self.showDatePlanLabel.isHidden = true
        self.dropDownImg.isHidden = true
        
        self.plannedBtnOutlet.isUserInteractionEnabled = false
        
        activitiyViewController = ActivityViewController(message: "Loading...")
        
        plannedPatientDataSource = PlannedPatientListCell()
        plannedPatientDataSource.onStartClick = {patient in
            self.onStartClick(patient: patient)
        }
        
        plannedPatientDataSource.onPlanClick = {(planner: Patients) in
            self.selectedPlan = planner
        }
        
        plannedPatientDataSource.onCancelClick = {patient in
            self.onCancelClick(patient: patient)
            
        }
        
        plannedPatientDataSource.onReschuledClick = {sender, patient in
            self.onReschuledClick(sender, patient: patient)
        }
        
        patientListCollectionView.dataSource = plannedPatientDataSource
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.updateInfo()
        }
        //        activitiyViewController.show(existingUiViewController: self)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let result = formatter.string(from: date)
        self.showDatePlanLabel.text = result
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.selectedDate, withJson: result)
    }
    
    func updateInfo()  {
        
        let userId = CommonUtils.getJsonFromUserDefaults(forKey: Constants.EMP_ID)
        let date = CommonUtils.getJsonFromUserDefaults(forKey: Constants.selectedDate)
        switch selectedTab {
        case "0":
            if (allPatients == nil) {
                updatePatients(apiName: String(format: Constants.AllPatientsApi, userId))
            } else {
                plannedPatientDataSource.setItems(items: allPatients, type: selectedTab)
                patientListCollectionView.reloadData()
            }
            break
            
        case "1":
            if (plannedPatients == nil) {
                updatePatients(apiName: String(format: Constants.PlannedPatientsApi, userId, date))
            } else if (plannedPatients != nil) {
                updatePatients(apiName: String(format: Constants.PlannedPatientsApi, userId, date))
            }
            break
            
        default:
            print("no case found")
        }
    }
    
    @objc func onReschuledDateSelected(_ date: Date) {
        activitiyViewController.show(existingUiViewController: self)
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        var params = Dictionary<String, Any>()
        
        params["HomeActivityPlanId"] = selectedPatient?.id;
        params["RescheduleTo"] = dateFormatterGet.string(from: date);
        params["RescheduleReason"] = "true";
        
        // Api Executed
        Alamofire.request(Constants.PatientReschuledApi, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
            .responseString(completionHandler: {(response) in
                // On Response
                self.activitiyViewController.dismiss(animated: false, completion: {() in
                    //On Dialog Close
                    if (response.error != nil) {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (response.error?.localizedDescription)!)
                        return
                    }
                    
                    let loginModel = Mapper<LoginModel>().map(JSONString: response.value!) //JSON to model
                    
                    if loginModel != nil {
                        
                        //                        if (loginModel?.success)! {
                        //                            CommonUtils.showToast(controller: self, message: "Rescheduled successful", seconds: 2)
                        //                        } else {
                        //                            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (loginModel?.error!)!)
                        //                        }
                    } else {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: "Empty Response is coming from server")
                    }
                })
            })
    }
    
    func onReschuledClick(_ sender: UIButton, patient: Patients)  {
        selectedPatient = patient
        let datePicker = ActionSheetDatePicker(title: "Rescheduled date",
                                               datePickerMode: UIDatePicker.Mode.date,
                                               selectedDate: Date(),
                                               target: self,
                                               action: #selector(onReschuledDateSelected(_:)),
                                               origin: sender)
        datePicker?.minuteInterval = 20
        if #available(iOS 13.4, *) {
            datePicker?.datePickerStyle = .automatic
        }
        
        datePicker?.show()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let id = segue.identifier else { return }
        if (id == "OnSiteSegue") {
            let visitController: VisitViewController = segue.destination as! VisitViewController
            visitController.selectedPatient = selectedPatient
        }else if id == "DiscussWithPatientSegue"{
            let visitController: DiscussionPatientViewController = segue.destination as! DiscussionPatientViewController
            visitController.selectedPatient = selectedPatient
        }else if (id == "SendToPatientDetailScreen"){
            let destination = segue.destination as! PatientDetailViewController
            destination.selectedPlan = self.selectedPlan
        }
    }
    
    func onStartClick(patient: Patients)  {
        self.selectedPatient = patient
        //        if patient.scheduleType == "Visit" {
        //            self.performSegue(withIdentifier: "DiscussWithPatientSegue", sender: self)
        //        } else {
        //            self.performSegue(withIdentifier: "OnSiteSegue", sender: self)
        //        }
        if patient.scheduleType == "Visit" {
            self.performSegue(withIdentifier: "OnSiteSegue", sender: self)
        } else {
            self.performSegue(withIdentifier: "DiscussWithPatientSegue", sender: self)
        }
    }
    
    func onCancelClick(patient: Patients)  {
        let alert = UIAlertController(style: .alert, title: "Cancel Plan")
        let config: TextField.Config = { textField in
            textField.becomeFirstResponder()
            textField.textColor = .black
            textField.placeholder = "Reason of Cancellation"
            textField.leftViewPadding = 12
            textField.backgroundColor = nil
            textField.keyboardAppearance = .default
            textField.keyboardType = .default
            textField.isSecureTextEntry = false
            textField.returnKeyType = .done
            textField.action { textField in
                // validation and so on
                let reason = textField.text
                var params = Dictionary<String, Any>()
                
                //                if reason == "" {
                //
                //                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "NOVO", withMessage: "Please Enter the  ")
                //                }
                
                params["HomeActivityPlanId"] = patient.id
                params["CancelReason"] = reason
                
                // Api Executed
                Alamofire.request(Constants.PatientCancelApi, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
                    .responseString(completionHandler: {(response) in
                        // On Response
                        self.activitiyViewController.dismiss(animated: false, completion: {() in
                            //On Dialog Close
                            if (response.error != nil) {
                                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (response.error?.localizedDescription)!)
                                return
                            }
                            
                            let loginModel = Mapper<LoginModel>().map(JSONString: response.value!) //JSON to model
                            
                            if loginModel != nil {
                                //                                if (loginModel?.success)! {
                                //
                                //                                    CommonUtils.showToast(controller: self, message: "Cancel Successful", seconds: 2)
                                //
                                //                                } else {
                                //                                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (loginModel?.error!)!)
                                //                                }
                            } else {
                                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: "Empty Response is coming from server")
                            }
                        })
                    })
            }
            
        }
        
        alert.addOneTextField(configuration: config)
        alert.addAction(title: "OK", style: .cancel)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func updatePatients(apiName: String) {
        activitiyViewController.show(existingUiViewController: self)
        Alamofire.request(apiName, method: .get, encoding: JSONEncoding.default, headers: nil)
            .responseString(completionHandler: {(response) in
                // On Response
                self.activitiyViewController.dismiss(animated: false, completion: {() in
                    //On Dialog Close
                    if (response.error != nil) {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (response.error?.localizedDescription)!)
                        return
                    }
                    let contentModel = Mapper<PatientModel>().map(JSONString: response.value!) //JSON to model
                    
                    if contentModel != nil {
                        if (contentModel?.success)! {
                            if (self.selectedTab == "0") {
                                
                                self.plannedBtnOutlet.isUserInteractionEnabled = true
                                self.allPatients = contentModel?.result
                                self.updateInfo()
                            } else {
                                self.plannedBtnOutlet.isUserInteractionEnabled = true
                                self.plannedPatients = contentModel?.result
                                self.plannedPatientDataSource.setItems(items: self.plannedPatients, type: self.selectedTab)
                                self.patientListCollectionView.reloadData()
                                //                                self.updateInfo()
                            }
                        } else {
                            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (contentModel?.error!)!)
                        }
                    } else {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: "Empty Response is coming from server")
                    }
                    
                })
            })
    }
    
    @IBAction func allPatientBtn(_ sender: Any) {
        
        selectedTab = "0"
        updateInfo()
        self.allPatientView.isHidden = false
        self.plannedPatientView.isHidden = true
        self.showDatePlanLabel.isHidden = true
        self.dropDownImg.isHidden = true
        
    }
    
    @IBAction func plannedPatientBtn(_ sender: Any) {
        
        selectedTab = "1"
        updateInfo()
        self.allPatientView.isHidden = true
        self.plannedPatientView.isHidden = false
        self.showDatePlanLabel.isHidden = false
        self.dropDownImg.isHidden = false
        
        showDatePlanLabel.text = CommonUtils.getJsonFromUserDefaults(forKey: Constants.selectedDate)
        
    }
    
    @IBAction func onRefreshClick(_ sender: Any) {
        
        allPatients = nil
        plannedPatients = nil
        updateInfo()
        
    }
    
    @IBAction func onChangeDateClick(_ sender: Any) {
        
        DatePickerDialog().show("Plan Visit", doneButtonTitle: "Search",cancelButtonTitle: "Cancel", minimumDate: Date(), datePickerMode: .date) { date in
            if let dt = date {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                let planPasteDate = formatter.string(from: dt)
                self.showDatePlanLabel.text = planPasteDate
                CommonUtils.saveJsonToUserDefaults(forKey: Constants.selectedDate, withJson: planPasteDate)
                self.updateInfo()
                
            }
        }
    }
    
    @IBAction func onBackClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
