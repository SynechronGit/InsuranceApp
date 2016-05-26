//
//  IADashboardController.swift
//  InsuranceApp
//

import UIKit


/**
 * Controller for Dashboard screen.
 */
class IADashboardController: IABaseController {
    @IBOutlet weak var welcomeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.welcomeLabel.text = String(format: "Welcome %@ %@!", IAGlobalData.sharedInstance.loggedInCustomer.firstName, IAGlobalData.sharedInstance.loggedInCustomer.lastName)
    }
}
