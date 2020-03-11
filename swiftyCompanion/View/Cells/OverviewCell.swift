//
//  OverviewCell.swift
//  swiftyCompanion
//
//  Created by Mykyta DANYLCHENKO on 3/8/20.
//  Copyright © 2020 Mykyta DANYLCHENKO. All rights reserved.
//

import UIKit

class OverviewCell: UITableViewCell {
    
    @IBOutlet weak var fieldName: UILabel!
    @IBOutlet weak var fieldValue: UILabel!
    
    func FillMyCell(rowsToDisplay: RowData){
        fieldName.text = rowsToDisplay.fieldName
        fieldValue.text = rowsToDisplay.value
    }
}
