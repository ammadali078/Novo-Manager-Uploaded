//
//  CallListenerViewController.swift
//  E-detailer
//
//  Created by Ammad on 8/18/18.
//  Copyright © 2018 Ammad. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper
import Alamofire

class CallListenerViewController: UIViewController {
    
    @IBOutlet weak var onSubmitRadius: UIButton!
    
    @IBOutlet weak var callListnerLayout: UIView!
    @IBOutlet weak var callListenerCollectionView: UICollectionView!
    
    
    var indicator: UIActivityIndicatorView!
    var activitiyViewController: ActivityViewController!
    var callListenerDataSource: CallListenerCell!
    var calls: [DualVisitCallSync] = []
    var selectediIndex: CallModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        onSubmitRadius.layer.cornerRadius = 10
        onSubmitRadius.clipsToBounds = true
        callListenerDataSource = CallListenerCell()
        
        callListenerDataSource.deleteCallback = {index in
            CommonUtils.showQuesBoxWithButtons(title: "Novo", message: "Are you sure you want to delete this form", controller: self, onYesClicked: {() in
                self.deleteItem(index: index)
            }, onNoClicked: {() in
                return
            })
        }
        
        let data = CommonUtils.getJsonFromUserDefaults(forKey: Constants.dualPostData)
        
        if data == "" || data == "[]" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "No Data available to preview")
            return
        }
        calls = Mapper<DualVisitCallSync>().mapArray(JSONString: data)!
        
        callListenerDataSource.setItems(calls: calls)
        callListenerCollectionView.dataSource = callListenerDataSource
        activitiyViewController = ActivityViewController(message: "Loading...")
    }
    
    func reloadData() {
        var data = CommonUtils.getJsonFromUserDefaults(forKey: Constants.dualPostData)
        if data == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "No Data available to preview")
            return
        }
        if (data == "") {data = "[]"}
        self.calls = Mapper<DualVisitCallSync>().mapArray(JSONString: data)!
        callListenerDataSource.List = self.calls
        callListenerCollectionView.reloadData()
        
    }
    
    func deleteItem(index: Int) {
        calls.remove(at: index)
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.dualPostData, withJson: Mapper().toJSONString(calls)!)
        reloadData()
    }
    
    @IBAction func onSubmitPressed(_ sender: Any) {
        
        if calls.count == 0 {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "No Data available to sync")
            return
        }
        
        var req = CallDualModel(map: Map(mappingType: .fromJSON, JSON: [:]))
        
        req?.dualVisitCallSync = calls
        
        activitiyViewController.show(existingUiViewController: self)
        
        let a = req?.toJSON()
        // Api Executed
        Alamofire.request(Constants.CallDualApi, method: .post, parameters: a, encoding: JSONEncoding.default, headers: nil)
            .responseString(completionHandler: {(response) in
                // On Response
                self.activitiyViewController.dismiss(animated: false, completion: {() in
                    
                    //On Dialog Close
                    if (response.error != nil) {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (response.error?.localizedDescription)!)
                        return
                    }
                    
                    let loginModel = Mapper<DualVisitModel>().map(JSONString: response.value!) //JSON to model
                    
                    if (loginModel?.success == true ) {
                        
                        CommonUtils.showMsgDialogWithOk(showingPopupOn: self, withTitle: "Novo", withMessage: "Data Sync Successfully", onOkClicked: {()
                            
                            CommonUtils.saveJsonToUserDefaults(forKey: Constants.LastTimeOfUpload, withJson: String(CommonUtils.getCurrentTime()))
                            
                            CommonUtils.saveJsonToUserDefaults(forKey: Constants.dualPostData, withJson: "[]")
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
