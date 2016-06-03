//
//  IAAddDriverController.swift
//  InsuranceApp
//

import UIKit


/**
 * Controller for Add Driver screen.
 */
class IAAddDriverController: IABaseController {
    @IBOutlet weak var addPhotoContainerView: UIView!
    @IBOutlet weak var takeLicensePhotoContainerView: UIView!
    
    @IBOutlet weak var nameTextField: IATextField!
    @IBOutlet weak var phoneNumberTextField: IATextField!
    @IBOutlet weak var emailAddressTextField: IATextField!
    @IBOutlet weak var streetAddressTextField: IATextField!
    @IBOutlet weak var cityTextField: IATextField!
    @IBOutlet weak var stateTextField: IATextField!
    @IBOutlet weak var zipTextField: IATextField!
    @IBOutlet weak var dobTextField: IATextField!
    @IBOutlet weak var licenseNumberTextField: IATextField!
    @IBOutlet weak var appointedSinceTextField: IATextField!
    @IBOutlet weak var drivingExperienceTextField: IATextField!
    @IBOutlet weak var employeeTypeTextField: IATextField!
    
    @IBOutlet weak var addContainerView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addPhotoContainerView.layer.cornerRadius = IAConstants.dashboardSubviewCornerRadius
        self.addPhotoContainerView.layer.masksToBounds = true
        
        self.takeLicensePhotoContainerView.layer.cornerRadius = IAConstants.dashboardSubviewCornerRadius
        self.takeLicensePhotoContainerView.layer.masksToBounds = true
        
        self.addContainerView.layer.cornerRadius = IAConstants.dashboardSubviewCornerRadius
        self.addContainerView.layer.masksToBounds = true
        
        self.cityTextField.shouldDisplayAsDropdown = true
        self.stateTextField.shouldDisplayAsDropdown = true
        self.drivingExperienceTextField.shouldDisplayAsDropdown = true
        self.employeeTypeTextField.shouldDisplayAsDropdown = true
    }

    
    @IBAction func didSelectSubmitButton(sender: AnyObject) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-mm-yyyy"
        
        let aDriver = IADriver()
        aDriver.firstName = self.nameTextField.text!
        aDriver.lastName = self.nameTextField.text!
        aDriver.phoneNumber = self.phoneNumberTextField.text!
        aDriver.emailAddress =  self.emailAddressTextField.text!
        aDriver.streetAddress = self.streetAddressTextField.text!
        aDriver.city = self.cityTextField.text!
        aDriver.state = self.stateTextField.text!
        aDriver.zip = self.zipTextField.text!
        
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
        } else if pSender.requestType == IARequestType.AddDriver {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }

}
