//
//  CallListenerCell.swift
//  E-detailer
//
//  Created by Ammad on 8/18/18.
//  Copyright © 2018 Ammad. All rights reserved.
//

import Foundation
import UIKit

class CallListenerCell: NSObject, UICollectionViewDataSource {
    
    var List: [DualVisitCallSync] = [];
    var deleteCallback: ((Int) -> Void)? = nil
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CallListenerCell", for: indexPath) as! CallListenerCellView
        
        cell.deleteCallBack = deleteCallback;
        cell.index = indexPath.row;
        
        cell.employeeIDLabel.text = CommonUtils.getJsonFromUserDefaults(forKey: Constants.Emp_Name)
        
        cell.startTimeLabel.text = List[indexPath.item].dE_ExternalId
        cell.endTimeLabel.text = List[indexPath.item].employeeDate

        return cell
    }

    func setItems(calls: [DualVisitCallSync]){
        List = calls;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return List.count;
    }
}

class CallListenerCellView: UICollectionViewCell {
    
    var deleteCallBack: ((Int) -> Void)? = nil
    var index: Int?
    
    @IBOutlet weak var employeeIDLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    
    @IBOutlet weak var endTimeLabel: UILabel!
    
    @IBAction func deleteBtn(_ sender: Any) {
        self.deleteCallBack!(index!)
    }
    
}
