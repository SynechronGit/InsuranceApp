//
//  IAPolicyListTableCellView.swift
//  InsuranceApp
//
//  Created by rupendra on 6/7/16.
//  Copyright © 2016 com. All rights reserved.
//

import UIKit

class IAPolicyListTableCellView: UITableViewCell {
    @IBOutlet weak var colorStripeView: UIView!
    @IBOutlet weak var insuranceTypeLabel: UILabel!
    @IBOutlet weak var insuredItemCountTitleLabel: UILabel!
    @IBOutlet weak var insuredItemCountLabel: UILabel!
    @IBOutlet weak var insuredDriversCountTitleLabel: UILabel!
    @IBOutlet weak var insuredDriversCountLabel: UILabel!
    @IBOutlet weak var coverageLabel: UILabel!
    @IBOutlet weak var premiumDueLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
