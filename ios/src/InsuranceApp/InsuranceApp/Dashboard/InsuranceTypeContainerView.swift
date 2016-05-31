//
//  InsuranceTypeContainerView.swift
//  InsuranceApp
//
//  Created by rupendra on 5/30/16.
//  Copyright © 2016 com. All rights reserved.
//

import UIKit

class InsuranceTypeContainerView: UIView {
    @IBOutlet weak var firstCounterLabel: IALabel!
    @IBOutlet weak var secondCounterLabel: IALabel!
    @IBOutlet weak var thirdCounterLabel: IALabel!
    @IBOutlet weak var fourthCounterLabel: IALabel!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    
    private func initialize() {
        self.layer.cornerRadius = IAConstants.dashboardSubviewCornerRadius
        self.layer.masksToBounds = true
    }
}
