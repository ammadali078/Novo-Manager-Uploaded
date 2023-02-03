//
//  SyncExpenseListCell.swift
//  E-detailer
//
//  Created by macbook on 12/01/2023.
//  Copyright © 2023 Ammad. All rights reserved.
//


import Foundation
import UIKit

class SyncExpenseListCell: NSObject, UICollectionViewDataSource{
    var list:[ExpenseModel] = []
    var deleteCallback: ((Int) -> Void)? = nil
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SyncExpenseListCell", for: indexPath) as! SyncExpenseListCellView
        
        let getCode = list[indexPath.item].code
        cell.index = indexPath.row;
        cell.deleteCallback = deleteCallback;
        
        
        if getCode == "OA" {
            cell.AmountLabelView.isHidden = true
            cell.FromLabelView.isHidden = false
            cell.toLabelView.isHidden = false
            cell.FromLabelsView.isHidden = false
            cell.toLabelsViews.isHidden = false
            cell.distanceLabelView.isHidden = true
            
            cell.expTypeLabelView.text = "Expense"
//            cell.AmountLabelView.text = "\(list[indexPath.item].amount ?? 0)"
//            cell.DateLabelView.text = "\(list[indexPath.item].date ?? 0)"
            cell.DateLabelView.text = list[indexPath.item].date
            cell.nameLabelView.text = list[indexPath.item].expenseType
            cell.FromLabelView.text = list[indexPath.item].emp_City
            cell.toLabelView.text = list[indexPath.item].desName
            cell.noteLabelView.text = list[indexPath.item].notes
         
        }else if getCode == "FU" {
            cell.AmountLabelView.isHidden = true
            cell.expTypeLabelView.text = "Expense"
//            cell.AmountLabelView.text = "\(list[indexPath.item].amount ?? 0)"
//            cell.DateLabelView.text = "\(list[indexPath.item].date ?? 0)"
            cell.DateLabelView.text = list[indexPath.item].date
            cell.nameLabelView.text = list[indexPath.item].expenseType
//           cell.FromLabelView.text = list[indexPath.item].emp_City
//           cell.toLabelView.text = list[indexPath.item].desName
            cell.noteLabelView.text = list[indexPath.item].notes
            cell.distanceLabelView.text = "\(list[indexPath.item].distnaceInKM ?? 0)"
           
        }else{
            
            cell.distanceLabelView.isHidden = true
            
            cell.expTypeLabelView.text = "Expense"
            cell.AmountLabelView.text = "\(list[indexPath.item].amount ?? 0)"
//            cell.DateLabelView.text = "\(list[indexPath.item].date ?? 0)"
            cell.DateLabelView.text = list[indexPath.item].date
            cell.nameLabelView.text = list[indexPath.item].expenseType
//           cell.FromLabelView.text = list[indexPath.item].emp_City
//           cell.toLabelView.text = list[indexPath.item].desName
            cell.noteLabelView.text = list[indexPath.item].notes
        }
        
        return cell
    }
}
class SyncExpenseListCellView: UICollectionViewCell {
    
    
    @IBOutlet weak var expTypeLabelView: UILabel!
    @IBOutlet weak var nameLabelView: UILabel!
    @IBOutlet weak var noteLabelView: UILabel!
    @IBOutlet weak var AmountLabelView: UILabel!
    @IBOutlet weak var DateLabelView: UILabel!
    @IBOutlet weak var FromLabelView: UILabel!
    @IBOutlet weak var FromLabelsView: UILabel!
    @IBOutlet weak var toLabelsViews: UILabel!
    @IBOutlet weak var toLabelView: UILabel!
    @IBOutlet weak var distanceLabelView: UILabel!
    
    
    var deleteCallback: ((Int) -> Void)? = nil
    var index: Int?

    @IBAction func DeleteBtnView(_ sender: Any) {
        self.deleteCallback!(index!)
    }
    
}
