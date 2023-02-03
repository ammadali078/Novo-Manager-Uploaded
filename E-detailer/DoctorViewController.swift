//
//  DoctorViewController.swift
//  E-detailer
//
//  Created by Ammad on 12/31/04.
//  Copyright © 2004 Ammad. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import ObjectMapper
import WebKit

class DoctorViewController: UIViewController {
    
    @IBOutlet weak var allPLannedDocBtn: UIButton!
    @IBOutlet weak var allDoctorsBtn: UIButton!
    @IBOutlet weak var DoctorListLayout: UIView!
    @IBOutlet weak var DoctorListCollectionView: UICollectionView!
    @IBOutlet weak var PlannedDoctorListCollectionView: UICollectionView!
    @IBOutlet weak var allDoctorView: UIView!
    @IBOutlet weak var allPatientView: UIView!
    @IBOutlet weak var currentDateLabel: UILabel!
    
    var DoctorListDataSource: DoctorListCell!
    var selectedDoctor: DoctorResult? = nil
    var selectedPlanned: PlannedResult? = nil
    var plannedDoctorListDataSource: PlannedDoctorListCell!
    var indicator: UIActivityIndicatorView!
    var activitiyViewController: ActivityViewController!
    var OpenType = "0"
    var hierarchyLevel = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let result = formatter.string(from: date)
        self.currentDateLabel.text = result
        
        activitiyViewController = ActivityViewController(message: "Loading...")
        DoctorListDataSource = DoctorListCell()
        DoctorListCollectionView.dataSource = DoctorListDataSource
        
        self.allPatientView.isHidden = false
        self.allDoctorView.isHidden = true
        
        self.hierarchyLevel = CommonUtils.getJsonFromUserDefaults(forKey: Constants.territoryCode)
        
        plannedDoctorListDataSource = PlannedDoctorListCell()
        PlannedDoctorListCollectionView.dataSource = plannedDoctorListDataSource
        
        DoctorListDataSource.onStartClick = {DoctorResult in
            self.onStartClick(DoctorResult: DoctorResult)
        }
        plannedDoctorListDataSource.onStartClick = {PlannedResult in
            self.onStartClicked(PlannedResult: PlannedResult)
        }
        
        allDoctorsBtn.layer.cornerRadius = 10
        allDoctorsBtn.clipsToBounds = true
        allPLannedDocBtn.layer.cornerRadius = 10
        allPLannedDocBtn.clipsToBounds = true
        PlannedDoctorListCollectionView.isHidden = true
        self.CallApi()
        self.PlannedApi()
        
    }
    
    func onStartClick(DoctorResult: DoctorResult)  {
        self.selectedDoctor = DoctorResult
        
        let planSelectedId = self.selectedDoctor?.employeeId
        
        let planSelectedName = self.selectedDoctor?.employeeName
        
        let planStatus = self.selectedDoctor?.planStatus
        
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.selectedDoctorId, withJson: planSelectedId ?? "")
        
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.selectedName, withJson: planSelectedName ?? "")
        
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.planStatus, withJson: planStatus ?? "")
        
        if self.hierarchyLevel == "200" {
            
            self.performSegue(withIdentifier: "SendToDualVisitForm", sender: nil)
        }else {
            self.performSegue(withIdentifier: "SendToTripleVisitForm", sender: nil)
        }
    }
    
    
    func onStartClicked(PlannedResult: PlannedResult)  {
        self.selectedPlanned = PlannedResult
        
        let planSelectedId = self.selectedPlanned?.empId
        
        let planSelectedName = self.selectedPlanned?.empName
        
        let planStatus = self.selectedPlanned?.planStatus
        
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.selectedDoctorId, withJson: planSelectedId ?? "")
        
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.selectedName, withJson: planSelectedName ?? "")
        
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.planStatus, withJson: planStatus ?? "")
        
        if self.hierarchyLevel == "200" {
            
            self.performSegue(withIdentifier: "SendToDualVisitForm", sender: nil)
        }else {
            self.performSegue(withIdentifier: "SendToTripleVisitForm", sender: nil)
        }
    }
    
    func CallApi() {
        
        let providedEmpId = CommonUtils.getJsonFromUserDefaults(forKey: Constants.EMP_ID)
        activitiyViewController.show(existingUiViewController: self)
        var params = Dictionary<String, String>()
        params["empId"] = providedEmpId;
        
        Alamofire.request(Constants.getPlanApi, method: .get, parameters: params, encoding: URLEncoding(destination: .queryString), headers: nil)
            .responseString(completionHandler: {(response) in
                
                // On Response
                self.activitiyViewController.dismiss(animated: true, completion: {() in
                    
                    //On Dialog Close
                    if (response.error != nil) {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please check your internet connection")
                        return
                    }
                    
                    let doctorModel = Mapper<DoctorModel>().map(JSONString: response.value!) //JSON to model
                    
                    if doctorModel != nil {
                        
                        if (doctorModel?.success)! {
                            self.DoctorListDataSource.setItems(items: doctorModel?.result)
                            self.DoctorListCollectionView.reloadData()
                            
                        } else {
                            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (doctorModel?.error!)!)
                        }
                    } else {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: "Empty Response is coming from server")
                    }
                })
            })
        
    }
    func PlannedApi() {
        
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
                            self.plannedDoctorListDataSource.setItems(items: plannedDoctorModel?.result)
                            self.PlannedDoctorListCollectionView.reloadData()
                        } else {
                            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (plannedDoctorModel?.error!)!)
                        }
                        
                    } else {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: "Empty Response is coming from server")
                    }
                })
            })
        
    }
    
    
    
    @IBAction func BTN_Update(_ sender: Any) {
        
        self.CallApi()
        
    }
    
    @IBAction func allDoctorBtn(_ sender: Any) {
        
        self.CallApi()
        self.DoctorListCollectionView.isHidden = false
        self.PlannedDoctorListCollectionView.isHidden = true
        self.allPatientView.isHidden = false
        self.allDoctorView.isHidden = true
        self.currentDateLabel.isHidden = false
        
    }
    
    @IBAction func plannedDoctorBtn(_ sender: Any) {
        
        self.PlannedApi()
        self.DoctorListCollectionView.isHidden = true
        self.PlannedDoctorListCollectionView.isHidden = false
        self.allPatientView.isHidden = true
        self.allDoctorView.isHidden = false
        self.currentDateLabel.isHidden = true
        
    }
    
    @IBAction func onBackClick(_ sender: Any) {
        
        CommonUtils.showQuesBoxWithButtons(title: "Novo", message: "Do you want to exit", controller: self, onYesClicked: {()
            self.dismiss(animated: true, completion: nil)
        }, onNoClicked: {()
            return
        })
    }
}
