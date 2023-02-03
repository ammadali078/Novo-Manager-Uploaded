//
//  NonConformityFormViewController.swift
//  E-detailer
//
//  Created by macbook on 10/01/2022.
//  Copyright © 2022 Ammad. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import ObjectMapper

class NonConformityFormViewController: UIViewController, UITextFieldDelegate {
   
    
    override func viewDidLoad() {
   
    }
   
    
    @IBAction func onBackClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSaveClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "MenuController", sender: self)
    }
    
}



