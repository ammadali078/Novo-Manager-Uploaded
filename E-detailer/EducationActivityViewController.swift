//
//  EducationActivityViewController.swift
//  E-detailer
//
//  Created by macbook on 08/02/2022.
//  Copyright © 2022 Ammad. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import ObjectMapper

class EducationActivityViewController: UIViewController,UITextViewDelegate,UITextFieldDelegate  {
    
    @IBOutlet weak var hcpNameTextField: UITextField!
    @IBOutlet weak var clinicNameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var imageViewOutlet: UIImageView!
    @IBOutlet weak var imageView2Outlet: UIImageView!
    
    var imagePicker: UIImagePickerController!
    var imagePickerRequestFor: String? = ""
    var patientConsentUrl: String? = ""
    var prescribtionUrl: String? = ""
    var indicator: UIActivityIndicatorView!
    var activitiyViewController: ActivityViewController!
    var Educalls: [MslActivityList] = []
    var EduAttach: [MSLActivityAttachments] = []
//    var images: [String] = []
    var Attachment = ["Yes", "No"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activitiyViewController = ActivityViewController(message: "Loading....")
        loadImagePicker()
        
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.EduPostData, withJson: "[]")
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.ATPostData, withJson: "[]")
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        let result = formatter.string(from: date)
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.eduStr, withJson: result)
        
    }
    
    @IBAction func onPictureClick(_ sender: Any) {
        imagePickerRequestFor = "PatientImage"
        showImagePicker()
    }
    
    @IBAction func onPicture2Click(_ sender: Any) {
        imagePickerRequestFor = "Prescribtion"
        showImagePicker()
    }
    
    @IBAction func submitBtn(_ sender: Any) {
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        let Endresult = formatter.string(from: date)
       
        
        let activityType = CommonUtils.getJsonFromUserDefaults(forKey: Constants.activity)
        
        if hcpNameTextField.text == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please enter HCP Name")
            return
        }
        if clinicNameTextField.text == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please enter HCP Name")
            return
        }
        if addressTextField.text == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please enter HCP Name")
            return
        }
      
        var Edata = CommonUtils.getJsonFromUserDefaults(forKey: Constants.EduPostData)
        if (Edata == "") {Edata = "[]"}
        
        var EduLists:[MslActivityList] = Mapper<MslActivityList>().mapArray(JSONString: Edata)!
        
        var EduList = MslActivityList(map: Map(mappingType: .fromJSON, JSON: [:]))
        
        EduList?.noOfHcp = hcpNameTextField.text
        EduList?.clinic = clinicNameTextField.text
        EduList?.empId = CommonUtils.getJsonFromUserDefaults(forKey: Constants.EMP_ID)
        EduList?.address = addressTextField.text
        EduList?.activityType = activityType
        EduList?.startTime = CommonUtils.getJsonFromUserDefaults(forKey: Constants.eduStr)
        EduList?.endTime = Endresult
        EduList?.startLat = CommonUtils.getJsonFromUserDefaults(forKey: Constants.LatitudeKey)
        EduList?.startLng = CommonUtils.getJsonFromUserDefaults(forKey: Constants.LongitudeKey)
        EduList?.endLat = CommonUtils.getJsonFromUserDefaults(forKey: Constants.LatitudeKey)
        EduList?.endLng = CommonUtils.getJsonFromUserDefaults(forKey: Constants.LongitudeKey)
        EduList?.Image1 = self.patientConsentUrl
        EduList?.Image2 = self.prescribtionUrl
        
        EduLists.append(EduList!)
        
        let dualJsonString = Mapper().toJSONString(EduLists)!
        
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.EduPostData, withJson: dualJsonString)
        
        let Eudata = CommonUtils.getJsonFromUserDefaults(forKey: Constants.EduPostData)
        
        if Eudata == "" || Eudata == "[]" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "No Data available to preview")
            return
        }
        
        Educalls = Mapper<MslActivityList>().mapArray(JSONString: Eudata)!
        
        //Image Work
        
        var ATdata = CommonUtils.getJsonFromUserDefaults(forKey: Constants.ATPostData)
        if (ATdata == "") {ATdata = "[]"}
        
        var ATLists:[MSLActivityAttachments] = Mapper<MSLActivityAttachments>().mapArray(JSONString: Edata)!
        
        var ATList = MSLActivityAttachments(map: Map(mappingType: .fromJSON, JSON: [:]))
        for i in 0..<2{
            if i == 0{
                ATList?.fileUrl = self.patientConsentUrl
            }else{
                ATList?.fileUrl = self.prescribtionUrl
            }
            
            ATLists.append(ATList!)
        }
        
        
//        ATLists.append(ATList!)
       
        let triJsonString = Mapper().toJSONString(ATLists)!
        
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.ATPostData, withJson: triJsonString)
        
        let Imdata = CommonUtils.getJsonFromUserDefaults(forKey: Constants.ATPostData)
        
        if Imdata == "" || Imdata == "[]" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "No Data available to preview")
            return
        }
        
        EduAttach = Mapper<MSLActivityAttachments>().mapArray(JSONString: Imdata)!
        
        var req = MSLActivityModel(map: Map(mappingType: .fromJSON, JSON: [:]))
        
        req?.mslActivityList = Educalls
        req?.mslActivityList?[0].mSLActivityAttachments = EduAttach
        
        activitiyViewController.show(existingUiViewController: self)
        
        let a = req?.toJSON()
        
//        let b = req?.mslActivityList?[0].mSLActivityAttachments?.toJSON()
        
            // a?.merging(bgg) { (current, _) in current }
//        MSLActivityApi
        
        
        Alamofire.request(Constants.MSLActivityApi, method: .post, parameters: a, encoding: JSONEncoding.default, headers: nil)
            .responseString(completionHandler: {(response) in
                // On Response
                self.activitiyViewController.dismiss(animated: false, completion: {() in
                    
                    //On Dialog Close
                    if (response.error != nil) {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (response.error?.localizedDescription)!)
                        return
                    }
                    
                    let loginModel = Mapper<DualVisitModel>().map(JSONString: response.value!) //JSON to model
                    
                    if (loginModel?.result == "") {
                    
                        CommonUtils.showMsgDialogWithOk(showingPopupOn: self, withTitle: "Novo", withMessage: "Activity Synced Successfully", onOkClicked: {()
                            
                            CommonUtils.saveJsonToUserDefaults(forKey: Constants.EduPostData, withJson: "[]")
                            
                            CommonUtils.saveJsonToUserDefaults(forKey: Constants.ATPostData, withJson: "[]")
                            self.dismiss(animated: false, completion: nil)
                            
                        })
                      
                    } else {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: response.value!)
                    }
                })
            })
    }
}

extension EducationActivityViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func loadImagePicker()  {
        imagePicker = UIImagePickerController()
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
                self.imageViewOutlet.image = image
            } else {
                self.imageView2Outlet.image = image
            }
            self.uploadImage(image: image)
        })
    }
    
    func uploadImage(image: UIImage?) {
        activitiyViewController.show(existingUiViewController: self)
        
        let imageData = image!.jpegData(compressionQuality: 0.2)!
        Alamofire.upload(multipartFormData: { (form) in
            let uuid = UUID().uuidString
            form.append(imageData, withName: "file", fileName: "\(uuid).jpg", mimeType: "image/jpg")
        }, to: Constants.FileUploadApi, encodingCompletion: { result in
            switch result {
            case .success(let upload, _, _):
                upload.responseString { response in
                    self.activitiyViewController.dismiss()
                    if (response.error != nil) {
                        return
                    }
                    //On Dialog Close
                    let imageUploadModel = Mapper<ImageUploadModel>().map(JSONString: response.value!) //JSON to model
                    if (imageUploadModel?.success!)! && (imageUploadModel?.result!.count)! > 0 {
                        if (self.imagePickerRequestFor == "PatientImage") {
                            self.patientConsentUrl = imageUploadModel?.result![0]
//                            self.Attachment[0] = imageUploadModel?.result![0] ?? ""
                        } else {
                            self.prescribtionUrl = imageUploadModel?.result![0]
//                            self.Attachment[1] = imageUploadModel?.result![0] ?? ""
                        }
                    } else {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "The Internet connection appers to be offline.")
                    }
                }
            case .failure(let encodingError):
                print(encodingError)
            }
        })
        
    }
}
