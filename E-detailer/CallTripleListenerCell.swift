//
//  CallTripleListenerCell.swift
//  E-detailer
//
//  Created by macbook on 20/07/2022.
//  Copyright © 2022 Ammad. All rights reserved.
//

import Foundation
import UIKit

class CallTripleListenerCell: NSObject, UICollectionViewDataSource {
    
    var List: [TripleVisitCallSync] = [];
    var deleteCallback: ((Int) -> Void)? = nil
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CallTripleListenerCell", for: indexPath) as! CallTripleListenerCellView
        
        cell.deleteCallBack = deleteCallback;
        cell.index = indexPath.row;
        
        cell.employeeIDLabel.text = CommonUtils.getJsonFromUserDefaults(forKey: Constants.Emp_Name)
        cell.startTimeLabel.text = List[indexPath.item].pC_ExternalId
        cell.endTimeLabel.text = List[indexPath.item].formSubmitDate
        
        return cell
    }

    func setItems(calls: [TripleVisitCallSync]){
        List = calls;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return List.count;
    }
}

class CallTripleListenerCellView: UICollectionViewCell {
    
    var deleteCallBack: ((Int) -> Void)? = nil
    var index: Int?
    
    @IBOutlet weak var employeeIDLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    
    @IBOutlet weak var endTimeLabel: UILabel!
    
    @IBAction func deleteBtn(_ sender: Any) {
        self.deleteCallBack!(index!)
    }
    
}
