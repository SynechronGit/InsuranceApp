//
//  IAPayPremiumTableCellView.swift
//  InsuranceApp
//
//  Created by rupendra on 6/9/16.
//  Copyright © 2016 com. All rights reserved.
//

import UIKit

class IAPayPremiumTableCellView: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var policyNumberLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
