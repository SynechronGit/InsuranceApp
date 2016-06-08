//
//  IAClaimDetailsController.swift
//  InsuranceApp
//
//  Created by rupendra on 6/8/16.
//  Copyright © 2016 com. All rights reserved.
//

import UIKit

class IAClaimDetailsController: IABaseController {
    var claim: IAClaim!
    
    @IBOutlet weak var mainBgView: UIView!
    @IBOutlet weak var claimStatusLabel: UILabel!
    @IBOutlet weak var claimNumberLabel: UILabel!
    @IBOutlet weak var dateOfClaimLabel: UILabel!
    @IBOutlet weak var incidentDateLabel: UILabel!
    @IBOutlet weak var incedentTypeLabel: UILabel!
    @IBOutlet weak var insuranceTypeLabel: UILabel!
    @IBOutlet weak var insuredItemHeadingLabel: UILabel!
    @IBOutlet weak var insuredItemLabel: UILabel!
    @IBOutlet weak var insurerCompanyLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    
    @IBOutlet weak var imageOneBgView: UIView!
    @IBOutlet weak var imageOneImageView: UIImageView!
    
    @IBOutlet weak var imageTwoBgView: UIView!
    @IBOutlet weak var imageTwoImageView: UIImageView!
    
    @IBOutlet weak var imageThreeBgView: UIView!
    @IBOutlet weak var imageThreeImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mainBgView.layer.cornerRadius = 10.0
        self.mainBgView.layer.masksToBounds = true
        
        self.imageOneBgView.layer.cornerRadius = IAConstants.dashboardSubviewCornerRadius
        self.imageOneBgView.layer.masksToBounds = true
        
        self.imageTwoBgView.layer.cornerRadius = IAConstants.dashboardSubviewCornerRadius
        self.imageTwoBgView.layer.masksToBounds = true
        
        self.imageThreeBgView.layer.cornerRadius = IAConstants.dashboardSubviewCornerRadius
        self.imageThreeBgView.layer.masksToBounds = true
        
        self.reloadData()
    }
    
    
    func reloadData(){
        self.claimStatusLabel.text = claim.statusDisplayText
        self.claimNumberLabel.text = claim.code
        self.dateOfClaimLabel.text = claim.dateOfClaim
        self.incidentDateLabel.text = claim.dateOfIncident
        self.incedentTypeLabel.text = claim.incedentType
        self.insuranceTypeLabel.text = claim.insuranceTypeDisplayText
        self.insuredItemHeadingLabel.text = "Insured Car: "
        self.insuredItemLabel.text = claim.insuredItemName
        self.insurerCompanyLabel.text = claim.insurer
        self.valueLabel.text = claim.value
        
        
    }
}
