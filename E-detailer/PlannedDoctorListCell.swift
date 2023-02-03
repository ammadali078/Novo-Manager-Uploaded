//
//  PlannedDoctorListCell.swift
//  E-detailer
//
//  Created by Macbook Air on 30/11/2021.
//  Copyright © 2021 Ammad. All rights reserved.
//

import Foundation
import UIKit
import BEMCheckBox

class PlannedDoctorListCell: NSObject, UICollectionViewDataSource {
    
    var dataList: [PlannedResult] = [];
    var selectedList : Dictionary<Int, PlannedResult> = Dictionary()
    var onStartClick: ((PlannedResult) -> Void)? = nil
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let list = collectionView.dequeueReusableCell(withReuseIdentifier: "PlannedDoctorListCell", for: indexPath) as! PlannedDoctorListCellView
        
        let index = indexPath.row
        let plannedDoctor = dataList[index]
        list.PlannedResult = plannedDoctor
        list.onStartClick = onStartClick
       
        list.doctorNameLabel.text = plannedDoctor.empName
        
        return list;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count;
    }
    
    func setItems (items: [PlannedResult]?) {
        self.dataList = items ?? []
    }
}

class PlannedDoctorListCellView: UICollectionViewCell, BEMCheckBoxDelegate {
    
    @IBOutlet weak var doctorNameLabel: UILabel!
    var PlannedResult: PlannedResult? = nil
    var onStartClick: ((PlannedResult) -> Void)? = nil
    
    @IBAction func OnStartClicked(_ sender: Any) {
        onStartClick!(PlannedResult!)
    }
    
}
