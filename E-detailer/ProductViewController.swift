////
////  ProductViewController.swift
////  E-detailer
////
////  Created by Ammad on 8/6/18.
////  Copyright © 2018 Ammad. All rights reserved.
////
//
//import Foundation
//import UIKit
//import Alamofire
//import ObjectMapper
//import Zip
//import CoreLocation
//
//class ProductViewController:  UIViewController,CLLocationManagerDelegate{
//
//    var productBl: ProductBL = ProductBL()
//    var callList: [CallModel] = []
//    var currentCall: CallModel? = nil
//
//    @IBOutlet weak var mDoctorLabel: UILabel!
//    var locationManager: CLLocationManager? = nil
//    var indicator: UIActivityIndicatorView!
//    var activitiyViewController: ActivityViewController!
//
//    @IBOutlet weak var callStopLabel: UILabel!
//    @IBOutlet weak var callStopImageView: UIImageView!
//    @IBOutlet weak var downloadableContentLayout: UIView!
//    @IBOutlet weak var downloadableCollectionView: UICollectionView!
//    @IBOutlet weak var downloadedProductsCollectionView: UICollectionView!
//    var downloadableContentDataSource: ProductDownloadContentCell!
//    var downloadedProductDataSource: DownloadedProductDataSource!
//    var isCallStarted: Bool = false;
//    var OpenType = "0";
//    @IBOutlet weak var lastSyncLabel: UILabel!
//    @IBOutlet weak var dashboardViewOutlet: UIView!
//
//    @IBOutlet weak var addPatientViewOutlet: UIView!
//    @IBOutlet weak var backBtnOutlet: UIView!
//    @IBOutlet weak var patientAddForHomeActivityView: UIView!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        self.initLocation()
//        self.locationManager?.startUpdatingLocation()
//        self.locationManager?.requestWhenInUseAuthorization()
//        self.locationManager?.requestAlwaysAuthorization()
//
//        if OpenType == "1" {
//
//            self.dashboardViewOutlet.isHidden = true
//            self.addPatientViewOutlet.isHidden = true
//            self.backBtnOutlet.isHidden = false
//            self.patientAddForHomeActivityView.isHidden = false
//        }else {
//            self.dashboardViewOutlet.isHidden = false
//            self.addPatientViewOutlet.isHidden = true
//            self.backBtnOutlet.isHidden = false
//
//        }
//
//        //        initLocation()
//        activitiyViewController = ActivityViewController(message: "Loading...")
//
//        downloadableContentDataSource = ProductDownloadContentCell()
//        downloadableCollectionView.dataSource = downloadableContentDataSource
//
//        downloadableContentDataSource.onClick = {(selectedModel: ContentResult) in
//            self.onDownloadRequest(selectedModel: selectedModel)
//        }
//
//        downloadedProductDataSource = DownloadedProductDataSource()
//        downloadedProductDataSource.onClick = {(selectedModel: ContentResult) in
//
//            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let newViewController = storyBoard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
//            newViewController.contentModel = selectedModel
//            self.present(newViewController, animated: true, completion: nil)
//            newViewController.delegate = {(session: EDASessions) in
//
//                if self.isCallStarted {
//                    self.currentCall?.eDASessions?.append(session)
//                    self.dashboardViewOutlet.isHidden = true
//                    self.addPatientViewOutlet.isHidden = false
//                    self.backBtnOutlet.isHidden = true
//
//                }
//            }
//        }
//
//        downloadedProductsCollectionView.dataSource = downloadedProductDataSource
//        notifyProductsChanged();
//    }
//
//
//
//    func initLocation(){
//        locationManager = CLLocationManager()
//        locationManager?.delegate = self
//        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager?.requestAlwaysAuthorization()
//
//    }
//
//
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//
//        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
//        CommonUtils.saveJsonToUserDefaults(forKey: Constants.LongitudeKey, withJson: "\(locValue.longitude)")
//        CommonUtils.saveJsonToUserDefaults(forKey: Constants.LatitudeKey, withJson: "\(locValue.latitude)")
//        print("locations = \(locValue.latitude) \(locValue.longitude)")
//        self.locationManager!.stopUpdatingLocation()
//
//    }
//
//
//    func notifyProductsChanged() {
//        var products = productBl.getAllProducts()
//        downloadedProductDataSource.setItems(items: products)
//        downloadedProductsCollectionView.reloadData()
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        updateCounter()
//    }
//
//    func updateCounter() {
//
//        var json = CommonUtils.getJsonFromUserDefaults(forKey: Constants.CallToUploadKey)
//        if (json == "") {
//            json = "[]"
//        }
//
//        let calls: [CallModel] = Mapper<CallModel>().mapArray(JSONString: json)!
//        let time = Double(CommonUtils.getJsonFromUserDefaults(forKey: Constants.LastTimeOfUpload))
//        var getData = ""
//        if (time != nil)
//        {
//            getData = CommonUtils.getDateFromTimeStamp(timeStamp: time!)
//        }
//        //let getDataOfTime = CommonUtils.getJsonFromUserDefaults(forKey: Constants.LastTimeOfUpload)
//        lastSyncLabel.text = "(\(calls.count))\nLast Sync:\n\(getData)))"
//    }
//
//    @IBAction func BTNSync(_ sender: Any) {
//        activitiyViewController.show(existingUiViewController: self)
//        // Api Executed
//        AF.request(Constants.ContentApi, method: .get, encoding: JSONEncoding.default, headers: nil)
//            .responseString(completionHandler: {(response) in
//                // On Response
//                self.activitiyViewController.dismiss(animated: false, completion: {() in
//
//                    //On Dialog Close
//                    if (response.error != nil) {
//                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (response.error?.localizedDescription)!)
//                        return
//                    }
//                    let contentModel = Mapper<ContentModel>().map(JSONString: response.value!) //JSON to model
//                    if contentModel != nil {
//                        if (contentModel?.success)! {
//
//                            self.downloadableContentLayout.isHidden = false
//                            self.downloadableContentDataSource.setItems(items: contentModel?.result)
//                            self.downloadableCollectionView.reloadData()
//
//                        } else {
//                            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (contentModel?.error!)!)
//                        }
//                    } else {
//                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: "Empty Response is coming from server")
//                    }
//
//                })
//            })
//
//    }
//
//    func getPatientData() {
//
//        activitiyViewController.show(existingUiViewController: self)
//        // Api Executed
//        AF.request(Constants.GetPatientDataApi, method: .get, encoding: JSONEncoding.default, headers: nil)
//            .responseString(completionHandler: {(response) in
//                // On Response
//                self.activitiyViewController.dismiss(animated: false, completion: {() in
//
//                    //On Dialog Close
//                    if (response.error != nil) {
//                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (response.error?.localizedDescription)!)
//                        return
//                    }
//                    let getPatientModel = Mapper<GetPatientDataModel>().map(JSONString: response.value!) //JSON to model
//                    if getPatientModel != nil {
//                        if (getPatientModel?.success)! {
//
//
//                        } else {
//                            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (getPatientModel?.error!)!)
//                        }
//                    } else {
//                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: "Empty Response is coming from server")
//                    }
//
//                })
//            })
//
//
//
//    }
//
//    func onDownloadRequest(selectedModel: ContentResult) {
////        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
////            let documentsURL = self.productBl.getDownloadFile(fileNameToDownload: selectedModel.product_name!)
////
////            return (URL.init(string: documentsURL)!, [.removePreviousFile, .createIntermediateDirectories])
////        }
////
////        self.activitiyViewController.text(text: "Connecting...");
////        self.activitiyViewController.show(existingUiViewController: self)
////        AF.download(
////            selectedModel.presentation_file_url!,
////            method: .get,
////            to: destination
////        )
////
////            .downloadProgress(closure: {(progress) in
////                let per = Int(progress.fractionCompleted * 100)
////                self.activitiyViewController.text(text: "Progress: \(per)%")
////            })
////
////            .response(completionHandler: {(defaultDownloadResponse) in
////                self.activitiyViewController.text(text: "Unzipping")
////
////                do {
////                    let filePath = defaultDownloadResponse.destinationURL
////                    let unZipLocation = self.productBl.getProductDir()
////
////                    try Zip.unzipFile(filePath!, destination: unZipLocation, overwrite: true, password: nil, progress: { (progress) -> () in
////
////                        //! On complete progress will be 1.0
////                        if progress == 1.0 {
////                            self.activitiyViewController.dismiss()
////
////                            //Performing decryption
////                            let indexPath = unZipLocation.absoluteString + "/" + selectedModel.product_name! + "/index.html"
////                            do {
////                                let url = URL.init(string: indexPath)!;
////                                let savedText = try String(contentsOf: url)
////                                let html = AESCrypt.decrypt(savedText, password: Constants.CryptoKeyPassPhrase)
////                                try html?.write(to: url, atomically: false, encoding: .utf8)
////                            }
////                            catch {
////
////                            }
////                            // refresh collectionView
////                            self.notifyProductsChanged()
////                        }
////                    })
////                }
////                catch {
////                    print("Something went wrong")
////                }
////            })
//    }
//
//    @IBAction func BTNcloseContent(_ sender: Any) {
//        self.downloadableContentLayout.isHidden = true
//    }
//
//    @IBAction func BTNSelectDoctor(_ sender: Any) {
//        self.performSegue(withIdentifier: "SendToDoctorScreen", sender: self)
//    }
//
//    @IBAction func BTNStart(_ sender: Any) {
//
//
//        if isCallStarted {
//
//            CommonUtils.showQuesBoxWithButtons(title: "Novo", message: "Do you want to end this Call", controller: self, onYesClicked: {()
//
//                //                let field = CommonUtils.getJsonFromUserDefaults(forKey: Constants.validate)
//                //
//                //                if  field == "" {
//                //                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "eDetailer", withMessage: "Please add Patient to proceed!")
//                //                    return
//                //                }
//
//                //            if currentCall?.clinicActivity?.count == 0 {
//                //                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "eDetailer", withMessage: "Please add Patient to proceed!")
//                //                return
//                //
//                //            }
//
//                self.currentCall?.endTime = String(CommonUtils.getCurrentTime())
//
//                if let endTime = self.currentCall?.endTime {
//                    if endTime.contains(".") {
//                        self.currentCall?.endTime = String(endTime.split(separator: ".")[0])
//                    }
//                }
//
//
//                var calls = CommonUtils.getJsonFromUserDefaults(forKey: Constants.CallToUploadKey)
//                if calls == "" {
//                    calls = "[]"
//                }
//
//                var callsArray:[CallModel] = Mapper<CallModel>().mapArray(JSONString: calls)!
//                callsArray.append(self.currentCall!)
//
//                let callsJson = Mapper().toJSONString(callsArray)
//
//                CommonUtils.saveJsonToUserDefaults(forKey: Constants.CallToUploadKey, withJson: callsJson!)
//
//                self.callStopLabel.text = "Start Call"
//                self.callStopImageView.image = UIImage(named: "analytic_start")
//                self.isCallStarted = false
//                self.updateCounter()
//                self.addPatientViewOutlet.isHidden = true
//                self.dashboardViewOutlet.isHidden = false
//                self.backBtnOutlet.isHidden = false
//            }, onNoClicked: {()
//                return
//
//            })
//
//
//        } else {
//            if OpenType == "1" {
//
//                self.performSegue(withIdentifier: "SendToPatientScreen", sender: self)
//
//            } else {
//
//                self.performSegue(withIdentifier: "SendToDoctorScreen", sender: self)
//            }
//
//
//        }
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let id = segue.identifier
//        let destination = segue.destination
//        if id == "SendToDoctorScreen" {
//
//
//            if ((destination as! DoctorViewController).delegate == nil) {
//
//                (destination as! DoctorViewController).delegate = ({( doctorList: [DoctorResult]) in
//
//                    self.currentCall = CallModel(map: Map(mappingType: .fromJSON, JSON: [:]))
//                    self.currentCall?.callDoctors = []
//                    self.currentCall?.eDASessions = []
//                    self.currentCall?.mACAddress = "abc123"
//
//                    for doctor in doctorList {
//                        var callDoctors = CallDoctors(map: Map(mappingType: .fromJSON, JSON: [:]))
//                        //                    callDoctors?.doctorId = String(describing: doctor.id).replacingOccurrences(of: "Optional(", with: "").replacingOccurrences(of: ")", with: "")
//                        callDoctors?.doctorId = doctor.id
//                        callDoctors?.docName = doctor.name
//                        self.currentCall?.callDoctors?.append(callDoctors!)
//                    }
//
//
//
//                    self.currentCall?.lat = CommonUtils.getJsonFromUserDefaults(forKey: Constants.LatitudeKey)
//
//                    self.currentCall?.lng = CommonUtils.getJsonFromUserDefaults(forKey: Constants.LongitudeKey)
//
//                    self.currentCall?.startTime = String(CommonUtils.getCurrentTime())
//                    if let startTime = self.currentCall?.startTime {
//                        if startTime.contains(".") {
//                            self.currentCall?.startTime = String(startTime.split(separator: ".")[0])
//                        }
//                    }
//                    self.currentCall?.userId = CommonUtils.getJsonFromUserDefaults(forKey: Constants.EMP_ID)
//
//                    self.addPatientViewOutlet.isHidden = false
//                    self.dashboardViewOutlet.isHidden = true
//                    self.backBtnOutlet.isHidden = true
//                    self.callStopLabel.text = "Stop"
//                    self.callStopImageView.image = UIImage(named: "analytic_stop")
//                    self.isCallStarted = true
//
//                })
//            }
//
//            if ((destination as! DoctorViewController).delegate2 == nil) {
//
//
//                (destination as! DoctorViewController).delegate2 = ({( doctorList: [Msrplan]) in
//
//                    self.currentCall = CallModel(map: Map(mappingType: .fromJSON, JSON: [:]))
//                    self.currentCall?.callDoctors = []
//                    self.currentCall?.eDASessions = []
//                    self.currentCall?.mACAddress = "abc123"
//
//                    for doctor in doctorList {
//                        var callDoctors = CallDoctors(map: Map(mappingType: .fromJSON, JSON: [:]))
//                        //                    callDoctors?.doctorId = String(describing: doctor.id).replacingOccurrences(of: "Optional(", with: "").replacingOccurrences(of: ")", with: "")
//                        callDoctors?.doctorId = doctor.id
//                        callDoctors?.docName = doctor.name
//                        self.currentCall?.callDoctors?.append(callDoctors!)
//                    }
//
//
//
//                    self.currentCall?.lat = CommonUtils.getJsonFromUserDefaults(forKey: Constants.LatitudeKey)
//
//                    self.currentCall?.lng = CommonUtils.getJsonFromUserDefaults(forKey: Constants.LongitudeKey)
//
//                    self.currentCall?.startTime = String(CommonUtils.getCurrentTime())
//                    if let startTime = self.currentCall?.startTime {
//                        if startTime.contains(".") {
//                            self.currentCall?.startTime = String(startTime.split(separator: ".")[0])
//                        }
//                    }
//                    self.currentCall?.userId = CommonUtils.getJsonFromUserDefaults(forKey: Constants.EMP_ID)
//
//                    self.addPatientViewOutlet.isHidden = false
//                    self.dashboardViewOutlet.isHidden = true
//                    self.backBtnOutlet.isHidden = true
//                    self.callStopLabel.text = "Stop"
//                    self.callStopImageView.image = UIImage(named: "analytic_stop")
//                    self.isCallStarted = true
//
//                })
//
//
//            }
//            // Openning Doctor Screen
//
//        } else if  id == "SendToAddPatient"  {
//            let patientController = destination as! AddPatientViewController
//            patientController.currentCall = self.currentCall
//            patientController.onPatientAdded = {(selectedModel: CallModel?) in
//                self.currentCall = selectedModel
//            }
//        }
//    }
//
//
//    @IBAction func onPressedLastSync(_ sender: Any) {
//
//        if isCallStarted {
//            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "eDetailer", withMessage: "Please stop call before continue!")
//
//            return
//
//        }
//
//
//        //        let field = CommonUtils.getJsonFromUserDefaults(forKey: Constants.validate)
//        //
//        //        if  field == "" {
//        //            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "eDetailer", withMessage: "Please add Patient to proceed!")
//        //            return
//        //        }
//
//        //        if  currentCall?.clinicActivity?.count == 0  {
//        //            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "eDetailer", withMessage: "Please add Patient to proceed!")
//        //            return
//        //        }
//
//        //        if currentCall?.clinicActivity?.count == 0 {
//        //            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "eDetailer", withMessage: "Please select one presentation to proceed!")
//        //            return
//        //        }
//
//        self.performSegue(withIdentifier: "SendToCallListenerScreen", sender: self)
//    }
//
//    @IBAction func onBackClick(_ sender: Any) {
//        self.dismiss(animated: true, completion: nil)
//    }
//
//}
//
