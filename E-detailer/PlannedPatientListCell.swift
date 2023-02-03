//
//  PlannedPatientListCell.swift
//  E-detailer
//
//  Created by Macbook Air on 08/11/2021.
//  Copyright © 2021 Ammad. All rights reserved.
//

import Foundation
import UIKit

class PlannedPatientListCell: NSObject, UICollectionViewDataSource {
    
    var dataList: [Patients] = [];
    var onStartClick: ((Patients) -> Void)? = nil
    var onPlanClick: ((Patients) -> Void)? = nil
    var onReschuledClick: ((UIButton, Patients) -> Void)? = nil
    var onCancelClick: ((Patients) -> Void)? = nil
    var type: String = "0";
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlannedPatientListCell", for: indexPath) as! PlannedPatientListCellView
        let index = indexPath.row
        
        let patient = dataList[index]
        
        cell.patient = patient
        cell.onStartClick = onStartClick
        cell.onPlanClick = onPlanClick
        cell.onCancelClick = onCancelClick
        cell.onReschuledClick = onReschuledClick
        
        
        if (type == "0") {
            dataList.reverse()
            cell.patientNameLabelView.text = patient.name
            cell.startCallButton.isHidden = true
            cell.rescheduleCallButton.isHidden = true
            cell.cancelCallButton.isHidden = true
            cell.statusTypeLabelView.isHidden = true
            cell.doctorNameLabel.text = patient.allDoctorName
            cell.productNameLabel.text = patient.allProductName
            cell.planDetailBtnOutlet.isHidden = false
        } else {
            
            cell.patientNameLabelView.text = patient.patientName
            cell.statusTypeLabelView.isHidden = false
            cell.startCallButton.isHidden = false
            cell.rescheduleCallButton.isHidden = false
            cell.cancelCallButton.isHidden = false
            cell.statusTypeLabelView.text = patient.scheduleType
            cell.doctorNameLabel.text = patient.doctorName
            cell.productNameLabel.text = patient.productName
            cell.planDetailBtnOutlet.isHidden = true
        }
        
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count;
    }
    
    func setItems (items: [Patients]?, type: String = "0") {
        dataList = items ?? []
        self.type = type
    }
}

public class PlannedPatientListCellView: UICollectionViewCell {
    
    @IBOutlet weak var patientNameLabelView: UILabel!
    @IBOutlet weak var startCallButton: UIButton!
    @IBOutlet weak var cancelCallButton: UIButton!
    @IBOutlet weak var rescheduleCallButton: UIButton!
    @IBOutlet weak var statusTypeLabelView: UILabel!
    @IBOutlet weak var doctorNameLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    
    @IBOutlet weak var planDetailBtnOutlet: UIButton!
    var patient: Patients? = nil
    var onStartClick: ((Patients) -> Void)? = nil
    var onPlanClick: ((Patients) -> Void)? = nil
    var onReschuledClick: ((UIButton,Patients) -> Void)? = nil
    var onCancelClick: ((Patients) -> Void)? = nil
    
    @IBAction func onClickCancel(_ sender: Any) {
        onCancelClick!(patient!)
    }
    @IBAction func onClickStartVisit(_ sender: Any) {
        onStartClick!(patient!)
    }
    @IBAction func onClickReschuledVisit(_ sender: Any) {
        onReschuledClick!(sender as! UIButton, patient!)
    }
    @IBAction func onPlanClicked(_ sender: Any) {
        onPlanClick!(patient!)
    }
    
}
