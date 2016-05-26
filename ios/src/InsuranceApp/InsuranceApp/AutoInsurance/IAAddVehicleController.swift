//
//  IAAddVehicleController.swift
//  InsuranceApp
//

import UIKit


/**
 * Controller for Add Vehicle screen.
 */
class IAAddVehicleController: IABaseController {
    @IBOutlet weak var licensePlateNumberTextField :UITextField!
    @IBOutlet weak var stateTextField :UITextField!
    @IBOutlet weak var vinTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - Selector Methods
    
    /**
     * Selector method that will be called when submit button is tapped.
     * @return Void
     */
    @IBAction func didSelectSubmitButton() {
        var aVehicle = IAVehicle()
        aVehicle.licensePlateNumber = self.licensePlateNumberTextField.text
        aVehicle.state = self.stateTextField.text
        
        IAAppDelegate.currentAppDelegate.displayLoadingOverlay()
        self.dataManager.addVehicle(aVehicle)
    }
    
    
    // MARK: - IADataManagerDelegate Methods
    
    /**
     * IADataManagerDelegate method. It is implemented to handle response sent by IADataManager.
     */
    internal override func aiDataManagerDidSucceed(sender pSender:IADataManager, response pResponse: IADataManagerResponse) {
        IAAppDelegate.currentAppDelegate.hideLoadingOverlay()
        
        if pResponse.error != nil {
            self.displayMessage(message: pResponse.error.localizedDescription, type: IAMessageType.Error)
        } else if pSender.requestType == IARequestType.AddVehicle {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
}
