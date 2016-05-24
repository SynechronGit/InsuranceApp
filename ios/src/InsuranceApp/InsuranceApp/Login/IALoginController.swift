//
//  IALoginController.swift
//  InsuranceApp
//

import UIKit


/**
 * Controller for Login screen.
 */
class IALoginController: IABaseController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - Selector Methods
    
    /**
     * Selector method that will be called when loing button is tapped.
     * @return Void
     */
    @IBAction func didSelectLoginButton() {
        self.performSegueWithIdentifier("LoginToDashboardSegueID", sender: self)
    }
    
}
