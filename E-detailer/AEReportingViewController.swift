//
//  AEReportingViewController.swift
//  E-detailer
//
//  Created by macbook on 08/01/2022.
//  Copyright © 2022 Ammad. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import ObjectMapper


class AEReportingViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var lblPlaceHolder : UILabel!
    
    func textViewDidChange(_ textView: UITextView) {
        lblPlaceHolder.isHidden = !textView.text.isEmpty
    }
        
    override func viewDidLoad() {
        
        descriptionTextView.delegate = self
        lblPlaceHolder = UILabel()
        lblPlaceHolder.text = "Enter your Descriptions"
        lblPlaceHolder.font = UIFont.systemFont(ofSize: descriptionTextView.font!.pointSize)
        lblPlaceHolder.sizeToFit()
        descriptionTextView.addSubview(lblPlaceHolder)
        lblPlaceHolder.frame.origin = CGPoint(x: 5, y: (descriptionTextView.font?.pointSize)! / 2)
        lblPlaceHolder.textColor = UIColor.lightGray
        lblPlaceHolder.isHidden = !descriptionTextView.text.isEmpty

        self.descriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
        self.descriptionTextView.layer.borderWidth = 1.0
        self.descriptionTextView.layer.cornerRadius = 8
    }
    
    func textView(_ tsextView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (descriptionTextView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        return numberOfChars < 500    // 10 Limit Value
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        return false
    }
    
    @IBAction func onBackClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSaveClicked(_ sender: Any) {
        
        let screen = CommonUtils.getJsonFromUserDefaults(forKey: Constants.screen1)
        
        if screen == "1" {
            
            self.dismiss(animated: true, completion: nil)
        }else {
            
            self.performSegue(withIdentifier: "SendNonConformityScreen", sender: self)
            
        }
    }
}

