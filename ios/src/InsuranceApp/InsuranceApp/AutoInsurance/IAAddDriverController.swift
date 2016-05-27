//
//  IAAddDriverController.swift
//  InsuranceApp
//

import UIKit


/**
 * Controller for Add Driver screen.
 */
class IAAddDriverController: IABaseController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var relationshipTextField: UITextField!
    @IBOutlet weak var dobTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var licenseTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var statusTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func didSelectSubmitButton(sender: AnyObject) {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-mm-yyyy"
        
        let aDriver = IADriver()
        aDriver.firstName = self.firstNameTextField.text!
        aDriver.lastName = self.lastNameTextField.text!
        aDriver.relationship = self.relationshipTextField.text!
        aDriver.dob =  dateFormatter.dateFromString(self.dobTextField.text!)
        aDriver.state = self.stateTextField.text!
        aDriver.license = self.licenseTextField.text!
        aDriver.type = self.typeTextField.text!
        aDriver.status = self.statusTextField.text!
        
       self.dataManager.addDriver(aDriver)
        
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
