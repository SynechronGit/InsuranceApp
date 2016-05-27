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
    
    
    // MARK: - Selector Methods
    
    /**
     * Selector method that will be called when Auto Insurance view is tapped.
     * @return Void
     */
    @IBAction func didSelectAutoInsuranceView() {
        self.performSegueWithIdentifier("DashboardToAutoInsuranceDetailsSegueID", sender: self)
    }
}
