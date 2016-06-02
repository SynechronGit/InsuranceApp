//
//  IADriverDetailsController.swift
//  InsuranceApp
//
//  Created by rupendra on 6/2/16.
//  Copyright © 2016 com. All rights reserved.
//

import UIKit

class IADriverDetailsController: IABaseController {
    @IBOutlet weak var driverDetailsContainerView: UIView!
    @IBOutlet weak var drivingLicenseNumberContainerView: UIView!
    
    @IBOutlet weak var appointedSinceLabel: UILabel!
    @IBOutlet weak var drivingExperienceLabel: UILabel!
    @IBOutlet weak var employeeTypeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.driverDetailsContainerView.layer.cornerRadius = IAConstants.dashboardSubviewCornerRadius
        self.driverDetailsContainerView.layer.masksToBounds = true
        
        self.drivingLicenseNumberContainerView.layer.cornerRadius = IAConstants.dashboardSubviewCornerRadius
        self.drivingLicenseNumberContainerView.layer.masksToBounds = true
    }
    
}
