//
//  CallListenerTripleController.swift
//  E-detailer
//
//  Created by macbook on 20/07/2022.
//  Copyright © 2022 Ammad. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper
import Alamofire


class CallListenerTripleController: UIViewController {
    
    @IBOutlet weak var onSubmitRadius: UIButton!
    
    @IBOutlet weak var callTripleListnerLayout: UIView!
    @IBOutlet weak var callTripleListenerCollectionView: UICollectionView!
    
    
    var indicator: UIActivityIndicatorView!
    var activitiyViewController: ActivityViewController!
    var callTripleListenerDataSource: CallTripleListenerCell!
    var callsTriple: [TripleVisitCallSync] = []
    var selectediIndex: CallModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        onSubmitRadius.layer.cornerRadius = 10
        onSubmitRadius.clipsToBounds = true
        callTripleListenerDataSource = CallTripleListenerCell()
//        callTripleListenerDataSource.deleteCallback = {index in
//            CommonUtils.showCallYesBoxWithButtons(title: "Novo", message: "Are you sure you want to delete this form", controller: self, onYesClicked: {() in
//                self.deleteItem(index: index)
//            })
//        }
        
        callTripleListenerDataSource.deleteCallback = {index in
            CommonUtils.showQuesBoxWithButtons(title: "Novo", message: "Are you sure you want to delete this form", controller: self, onYesClicked: {() in
                self.deleteItem(index: index)
            }, onNoClicked: {() in
                return
            })
        }
        
        let Tdata = CommonUtils.getJsonFromUserDefaults(forKey: Constants.triplePostData)
        
        if Tdata == "" || Tdata == "[]" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "No Data available to preview")
            return
        }
        callsTriple = Mapper<TripleVisitCallSync>().mapArray(JSONString: Tdata)!
        
        
        callTripleListenerDataSource.setItems(calls: callsTriple)
        callTripleListenerCollectionView.dataSource = callTripleListenerDataSource
        activitiyViewController = ActivityViewController(message: "Loading...")
    }
    
    func reloadData() {
        var Tdata = CommonUtils.getJsonFromUserDefaults(forKey: Constants.triplePostData)
        if Tdata == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "No Data available to preview")
            return
        }
        if (Tdata == "") {Tdata = "[]"}
        self.callsTriple = Mapper<TripleVisitCallSync>().mapArray(JSONString: Tdata)!
        callTripleListenerDataSource.List = self.callsTriple
        callTripleListenerCollectionView.reloadData()
        
    }
    
    func deleteItem(index: Int) {
        callsTriple.remove(at: index)
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.triplePostData, withJson: Mapper().toJSONString(callsTriple)!)
        reloadData()
    }
    
    @IBAction func onSubmitPressed(_ sender: Any) {
        
        if callsTriple.count == 0 {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "No Data available to sync")
            return
        }
        
        var req = CallTripleModel(map: Map(mappingType: .fromJSON, JSON: [:]))
        
        req?.tripleVisitCallSync = callsTriple
        
        activitiyViewController.show(existingUiViewController: self)
        
        let a = req?.toJSON()
        // Api Executed
        Alamofire.request(Constants.CallTripleApi, method: .post, parameters: a, encoding: JSONEncoding.default, headers: nil)
            .responseString(completionHandler: {(response) in
                // On Response
                self.activitiyViewController.dismiss(animated: false, completion: {() in
                    
                    //On Dialog Close
                    if (response.error != nil) {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (response.error?.localizedDescription)!)
                        return
                    }
                    
                    let loginModel = Mapper<DualVisitModel>().map(JSONString: response.value!) //JSON to model
                    
                    if (loginModel?.success == true) {
                        
                        CommonUtils.showMsgDialogWithOk(showingPopupOn: self, withTitle: "Novo", withMessage: "Data Sync Successfully", onOkClicked: {()
                            
                            CommonUtils.saveJsonToUserDefaults(forKey: Constants.LastTimeOfUpload, withJson: String(CommonUtils.getCurrentTime()))
                            
                            CommonUtils.saveJsonToUserDefaults(forKey: Constants.triplePostData, withJson: "[]")
                            self.dismiss(animated: false, completion: nil)
                            
                        })
                        
                      
                    } else {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: response.value!)
                    }
                })
            })
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let id = segue.identifier else { return }
        if (id == "SendToCallDetailScreen"){
            let destination = segue.destination as! CallDetailViewController
            destination.selectedIndex = self.selectediIndex
        }
    }
    
    
    @IBAction func onBackClick(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
}
