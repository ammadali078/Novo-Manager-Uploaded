//
//  DoctorListCell.swift
//  E-detailer
//
//  Created by Ammad on 8/13/18.
//  Copyright © 2018 Ammad. All rights reserved.
//

import Foundation
import UIKit
import BEMCheckBox

class DoctorListCell: NSObject, UICollectionViewDataSource {
    
    var dataList: [DoctorResult] = [];
    var selectedList : Dictionary<Int, DoctorResult> = Dictionary()
    var type: String = "0";
    var onStartClick: ((DoctorResult) -> Void)? = nil
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let list = collectionView.dequeueReusableCell(withReuseIdentifier: "DoctorListCell", for: indexPath) as! DoctorListCellView
        
        let index = indexPath.row
        let doctor = dataList[index]
        list.DoctorResult = doctor
        list.doctorListLabel.text = doctor.employeeName
        list.onStartClick = onStartClick
        
        if doctor.employeeName == "" {
            
            list.doctorListLabel.text = "No plan found"
            list.startVisitBtn.isHidden = true
            
        }
        
        
        return list;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count;
    }
    
    func setItems (items: [DoctorResult]?, type: String = "0") {
        self.dataList = items ?? []
        self.type = type
    }
}

class DoctorListCellView: UICollectionViewCell, BEMCheckBoxDelegate {
    
    @IBOutlet weak var doctorListLabel: UILabel!
    @IBOutlet weak var startVisitBtn: UIButton!
    var DoctorResult: DoctorResult? = nil
    var onStartClick: ((DoctorResult) -> Void)? = nil
    
    
    @IBAction func onStartClickedBtn(_ sender: Any) {
        onStartClick!(DoctorResult!)
    }
    
}
