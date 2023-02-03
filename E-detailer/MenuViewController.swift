//
//  MenuViewController.swift
//  E-detailer
//
//  Created by Ammad on 8/4/18.
//  Copyright © 2018 Ammad. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import Alamofire
import ObjectMapper
//SendToSyncExpense

class MenuViewController: UIViewController {
    
    @IBOutlet weak var mEmpIdLabel: UILabel!
    @IBOutlet weak var mEmpNameLabel: UILabel!
    @IBOutlet weak var logOutViewOutlet: UIView!
    @IBOutlet weak var activityNameLabel: UILabel!
    @IBOutlet weak var MenuViewOutlet: UIView!
    @IBOutlet weak var expenseView: UIView!
    @IBOutlet weak var navViewOutlet: UIView!
    var loginViewController: UIViewController? = nil
    var hierarchyLevel = "0"
    var indicator: UIActivityIndicatorView!
    var activitiyViewController: ActivityViewController!
    var expCity = [Emp_city]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        activitiyViewController = ActivityViewController(message: "Loading...")
        logOutViewOutlet.layer.cornerRadius = 15
        logOutViewOutlet.clipsToBounds = true
        MenuViewOutlet.layer.cornerRadius = 15
        MenuViewOutlet.clipsToBounds = true
        expenseView.layer.cornerRadius = 15
        expenseView.clipsToBounds = true
        mEmpIdLabel.text = CommonUtils.getJsonFromUserDefaults(forKey: Constants.EMP_ID)
        mEmpNameLabel.text = CommonUtils.getJsonFromUserDefaults(forKey: Constants.Emp_Name)
        
//        self.CityApi()
        
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // change 2 to desired number of seconds
        //            // Your code with delay
        //            if (self.loginViewController != nil) {
        //                self.loginViewController?.dismiss(animated: false, completion: nil)
        //            }
        // in
        //        }
        self.hierarchyLevel = CommonUtils.getJsonFromUserDefaults(forKey: Constants.territoryCode)
        
        if self.hierarchyLevel == "200" {
            
            self.activityNameLabel.text = "Dual Activity"
        }else {
            
            self.activityNameLabel.text = "Triple Activity"
            
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navViewOutlet.isHidden = true
        
        
    }
    
    @IBAction func sendToProductView(_ sender: Any) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "SendToDoctorScreen") as! DoctorViewController
        
    }
    
    @IBAction func navBtn(_ sender: Any) {
        
        if navViewOutlet.isHidden == false {
            
            navViewOutlet.isHidden = true
            
        }else {
            
            navViewOutlet.isHidden = false
            
        }
        
    }
    
    func CityApi() {
        
        let providedEmailAddress = CommonUtils.getJsonFromUserDefaults(forKey: Constants.EMP_ID)
        
        activitiyViewController.show(existingUiViewController: self)
        var params = Dictionary<String, String>()
        
        params["Username"] = providedEmailAddress;

        // Api Executed
        Alamofire.request(Constants.CityApi, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
            .responseString(completionHandler: {(response) in
                // On Response
                self.activitiyViewController.dismiss(animated: true, completion: {() in

                    //On Dialog Close
                    if (response.error != nil) {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please check your internet connection")
                        return
                    }

                    let cityModel = Mapper<exampleModel>().map(JSONString: response.value!) //JSON to model

                    if cityModel != nil {
                        
                        
                        var callsArray:[Emp_city] = Mapper<Emp_city>().mapArray(JSONString: "[]")!
                        callsArray.append(contentsOf: (cityModel?.result!.emp_city)!)
                        let json = Mapper().toJSONString(callsArray)
                        //                            let defaults = UserDefaults.standard
                        let defaults = UserDefaults.standard
                        defaults.set(json, forKey: Constants.getCity)
                        
                        
                        
                        
                        
                    } else {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: "Empty Response is coming from server")
                    }
                })
            })
        
        
    }
    
    
    @IBAction func expenseBtn(_ sender: Any) {
        
        self.performSegue(withIdentifier: "SendToExpenseScreen", sender: self)
    }
    
    @IBAction func syncExpenseBtn(_ sender: Any) {
        
        self.performSegue(withIdentifier: "SendToSyncExpense", sender: nil)
        
    }
    
    @IBAction func SyncBtn(_ sender: Any) {
        
//        self.performSegue(withIdentifier: "sendToSyncScreen", sender: self)
        
        
        if self.hierarchyLevel == "200" {
            
            self.performSegue(withIdentifier: "sendToSyncScreen", sender: self)
        }else {
            self.performSegue(withIdentifier: "SendToTripleSyncScreen", sender: self)
        }
//        SendToTripleSyncScreen
    }
    
    //
    @IBAction func sendToStatisticsScreen(_ sender: Any) {
        
        CommonUtils.showCallBoxWithButtons(title: "Novo", message: "Choose the Appropriate Time", controller: self, onYesClicked: {()
            let screen = "1"
            CommonUtils.saveJsonToUserDefaults(forKey: Constants.screen1, withJson: screen)
            self.performSegue(withIdentifier: "SendAdverseReportingScreen", sender: self)
            
        }, onNoClicked: {()
            let screen = "0"
            CommonUtils.saveJsonToUserDefaults(forKey: Constants.screen1, withJson: screen)
            self.performSegue(withIdentifier: "SendAdverseReportingScreen", sender: self)
            
        }, onFreeClicked: {()
            return
        }, onCancelClicked: {()
            
            return
        })
    }
    
    
    
    
    @IBAction func otherActivityBtn(_ sender: Any) {
        CommonUtils.showCallBoxWithButtons(title: "Novo", message: "Choose the Activity", controller: self, onYesClicked: {()
            CommonUtils.saveJsonToUserDefaults(forKey: Constants.activity, withJson: "Admin day, meeting, HCP visit other")
            self.performSegue(withIdentifier: "SendToAdminDay", sender: self)
            
        }, onNoClicked: {()
            CommonUtils.saveJsonToUserDefaults(forKey: Constants.activity, withJson: "Educational activity")
            self.performSegue(withIdentifier: "SendToEducationalActivity", sender: self)
            
        }, onFreeClicked: {()
            
            CommonUtils.saveJsonToUserDefaults(forKey: Constants.activity, withJson: "Outstation visit")
            self.performSegue(withIdentifier: "SendToOutStationViewScreen", sender: self)
            
            return
            
        }, onCancelClicked: {()
            
            return
        })
        
        
    }
    
    //
    @IBAction func sendToProductScreen(_ sender: Any) {
        
        if self.hierarchyLevel == "200" {
            
            self.performSegue(withIdentifier: "SendToPerformanceDE", sender: self)
        }else {
            self.performSegue(withIdentifier: "SendToPerformancePC", sender: self)
        }
        
    }
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let id = segue.identifier
        let cont = segue.destination
        
        switch id! {
            
        case "knowlegdeSegue":
//            let cCont = cont as! CategoryViewController
//            cCont.dataIndex = 2
            break
            
        case "teamSegue":
//            let cCont = cont as! CategoryViewController
//            cCont.dataIndex = 1
            break
            
        case "generalSegue":
//            let cCont = cont as! CategoryViewController
//            cCont.dataIndex = 0
            break
            
        case "SendTologinController":
            CommonUtils.saveJsonToUserDefaults(forKey: Constants.IsSignInKey, withJson: "")
            
            break
            
            //        case "SendToProductScreen":
            //            let destination = segue.destination as! ProductViewController
            //            destination.OpenType = "0"
            //            break
            //
            //        case "HomeActivity":
            //            let destination = segue.destination as! ProductViewController
            //            destination.OpenType = "1"
            //            break
            
        default:
            break
            
        }
    }
    
    
    //    @IBAction func sendToStatisticsScreen(_ sender: Any) {
    //        self.performSegue(withIdentifier: "SendToStatisticsScreen", sender: self)
    //    }
    ////    @IBAction func sendToVideoController(_ sender: Any) {
    ////        self.performSegue(withIdentifier: "SendToAVIScreen", sender: self)
    ////    }
    ////    @IBAction func sendToContactController(_ sender: Any) {
    ////        self.performSegue(withIdentifier: "SendToAVIScreen", sender: self)
    ////    }
    //
    //    @IBAction func mExpBtn(_ sender: Any) {
    //
    //        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "eDetailer", withMessage: "Sorry, This Fuctionality is not been set")
    //    }
    
    @IBAction func abcd(_ sender: Any) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "SendToTripleVisitForm") as! TripleVisitViewController
        
        //        self.performSegue(withIdentifier: "AddPatientScreen", sender: self)
        //        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        //        let newViewController = storyBoard.instantiateViewController(withIdentifier: "AddPatientScreen") as! AddPatientViewController
    }
    
    
    
}
