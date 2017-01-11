//
//  IAClaimListTableCellView.swift
//  InsuranceApp
//
//  Created by rupendra on 6/8/16.
//  Copyright © 2016 com. All rights reserved.
//

import UIKit

class IAClaimListTableCellView: UITableViewCell {
    @IBOutlet weak var colorStripeView: UIView!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var policyNumberLabel: UILabel!
    @IBOutlet weak var dateOfClaimLabel: UILabel!
    @IBOutlet weak var insuranceTypeLabel: UILabel!
    @IBOutlet weak var insuredItemTitleLabel: UILabel!
    @IBOutlet weak var insuredItemValueLabel: UILabel!
    @IBOutlet weak var insurerLabel: UILabel!
    @IBOutlet weak var statusReportLabel: UILabel!
    @IBOutlet weak var statusReportDoneImageView: UIImageView!
    @IBOutlet weak var statusUnderReviewLabel: UILabel!
    @IBOutlet weak var statusUnderReviewDoneImageView: UIImageView!
    @IBOutlet weak var statusApprovedLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
