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
        let aCustomer = IACustomer()
        aCustomer.emailAddress = ""
        aCustomer.password = ""
        
        IAAppDelegate.currentAppDelegate.displayLoadingOverlay()
        self.dataManager.login(aCustomer)
    }
    
    
    // MARK: - IADataManagerDelegate Methods
    
    /**
     * IADataManagerDelegate method. It is implemented to handle response sent by IADataManager.
     */
    internal override func aiDataManagerDidFail(sender pSender:IADataManager, error pError: NSError) {
        super.aiDataManagerDidFail(sender: pSender, error: pError)
    }
    
    
    /**
     * IADataManagerDelegate method. It is implemented to handle response sent by IADataManager.
     */
    internal override func aiDataManagerDidSucceed(sender pSender:IADataManager, response pResponse: IADataManagerResponse) {
        IAAppDelegate.currentAppDelegate.hideLoadingOverlay()
        if pSender.requestType == IARequestType.Login {
            self.performSegueWithIdentifier("LoginToDashboardSegueID", sender: self)
        }
    }
    
}
