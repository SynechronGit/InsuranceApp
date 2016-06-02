//
//  IATrafficViolationTableCellView.swift
//  InsuranceApp
//
//  Created by rupendra on 6/2/16.
//  Copyright © 2016 com. All rights reserved.
//

import UIKit

class IATrafficViolationTableCellView: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var violationTypeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
