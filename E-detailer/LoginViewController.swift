//
//  LoginViewController.swift
//  E-detailer
//
//  Created by Ammad on 8/1/18.
//  Copyright © 2018 Ammad. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    struct RequestBodyFormDatakeyValue {
        var skey : String
        var svalue : String
    }
    
    @IBOutlet weak var passwordViewOutlet: UIView!
    @IBOutlet weak var emailViewOutlet: UIView!
    @IBOutlet weak var signInBtnRadius: UIButton!
    @IBOutlet weak var loginContentLayout: UIView!
    @IBOutlet weak var UserEmail: UITextField!
    @IBOutlet weak var UserPassword: UITextField!
    var indicator: UIActivityIndicatorView!
    var activitiyViewController: ActivityViewController!
    var expCity = [Emp_city]()
    
    var OpenType = "0"
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        
        self.performLogin()
        
        return true
    }
    
    func performLogin() {
        let providedEmailAddress = UserEmail.text
        let providedPassword = UserPassword.text

        print("password1: \(self.UserPassword.text ?? "")")

        if providedEmailAddress == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: "Please Enter the User ID")
            return
        }

        if providedPassword == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: "Please Enter the Password")
            return
        }
        
                activitiyViewController.show(existingUiViewController: self)
                var params = Dictionary<String, String>()
        
                params["Username"] = providedEmailAddress;
                params["Password"] = providedPassword;
        
                // Api Executed
        Alamofire.request(Constants.LoginApi2, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
                    .responseString(completionHandler: {(response) in
                        // On Response
                        self.activitiyViewController.dismiss(animated: true, completion: {() in
        
                            //On Dialog Close
                            if (response.error != nil) {
                                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please check your internet connection")
                                return
                            }
        
                            let loginModel = Mapper<LoginModel>().map(JSONString: response.value!) //JSON to model
        
                            if loginModel != nil {
                                
                                CommonUtils.saveJsonToUserDefaults(forKey: Constants.EMP_ID, withJson: loginModel?.response?.employeeId ?? "")
                                CommonUtils.saveJsonToUserDefaults(forKey: Constants.IsSignInKey, withJson: loginModel?.response?.authToken ?? "")
                                CommonUtils.saveJsonToUserDefaults(forKey: Constants.designation, withJson: loginModel?.response?.designation ?? "")
                                CommonUtils.saveJsonToUserDefaults(forKey: Constants.zone, withJson: loginModel?.response?.zone ?? "")
                                CommonUtils.saveJsonToUserDefaults(forKey: Constants.Emp_Name, withJson: loginModel?.response?.employeeName ?? "")
                                
                                if loginModel?.response?.hierarchyLevel == 200 {
                                    CommonUtils.saveJsonToUserDefaults(forKey: Constants.territoryCode, withJson: "\(loginModel?.response?.hierarchyLevel ?? 0)")
                                    
                                    self.performSegue(withIdentifier: "Sendtomainscreen", sender: nil)
                                    
                                }else if loginModel?.response?.hierarchyLevel == 500 {
                                    
                                    CommonUtils.saveJsonToUserDefaults(forKey: Constants.territoryCode, withJson: "\(loginModel?.response?.hierarchyLevel ?? 0)")
                                    self.performSegue(withIdentifier: "Sendtomainscreen", sender: nil)
                                    
                                }else {
                                    
                                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: "Incorrect user or password")
                                    
                                    return
                                }
                                
                            } else {
                                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: "Empty Response is coming from server")
                            }
                        })
                    })
        
    }
    
    @IBAction func onLogin(_ sender: Any) {
        
        self.performLogin()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let id = segue.identifier
        if (id == "Sendtomainscreen") {
            let dest = segue.destination as! MenuViewController
            dest.loginViewController = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailViewOutlet.layer.cornerRadius = 25
        passwordViewOutlet.layer.cornerRadius = 25
        
        signInBtnRadius.layer.cornerRadius = 25
        signInBtnRadius.clipsToBounds = true
        
        loginContentLayout.layer.cornerRadius = 25
        loginContentLayout.clipsToBounds = true
        
        let a = CommonUtils.getJsonFromUserDefaults(forKey: Constants.IsSignInKey)
        if (a != "") {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) { // change 2 to desired number of seconds
                // Your code with delay
                self.performSegue(withIdentifier: "Sendtomainscreen", sender: nil)
            }
            return
        }
        activitiyViewController = ActivityViewController(message: "Loading...")
        
        
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
protocol DataConvertible {
    init?(data: Data)
    var data: Data { get }
}

extension DataConvertible where Self: ExpressibleByIntegerLiteral{
    
    init?(data: Data) {
        var value: Self = 0
        guard data.count == MemoryLayout.size(ofValue: value) else { return nil }
        _ = withUnsafeMutableBytes(of: &value, { data.copyBytes(to: $0)} )
        self = value
    }
    
    var data: Data {
        return withUnsafeBytes(of: self) { Data($0) }
    }
}

extension Int : DataConvertible { }
extension Float : DataConvertible { }
extension Double : DataConvertible { }
