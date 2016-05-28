//
//  IAAutoInsuranceDetailsController.swift
//  InsuranceApp
//

import UIKit


/**
 * Controller for Auto Insurance Details screen.
 */
class IAAutoInsuranceDetailsController: IABaseController {
    var vehicleArray :Array<IAVehicle>!
    var driverArray :Array<IADriver>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reloadAllData()
    }

    func reloadAllData() {
        IAAppDelegate.currentAppDelegate.displayLoadingOverlay()
        self.dataManager.listVehicles()
    }
    
    
    func reloadAllView() {
        if self.vehicleArray != nil {
            for aVehicle in self.vehicleArray {
                NSLog("licensePlateNumber: %@, state: %@", aVehicle.licensePlateNumber, aVehicle.state)
            }
        }
        
        if self.driverArray != nil {
            for aDriver in self.driverArray {
                NSLog("firstName: %@, lastName: %@", aDriver.firstName, aDriver.lastName)
            }
        }
    }
    
    
    // MARK: - Selector Methods
    
    /**
     * Selector method that will be called when Add Vehicle button is tapped.
     * @return Void
     */
    @IBAction func didSelectAddVehicleButton() {
        self.performSegueWithIdentifier("AutoInsuranceDetailsToAddVehicleSegueID", sender: self)
    }
    
    
    /**
     * Selector method that will be called when Add Driver button is tapped.
     * @return Void
     */
    @IBAction func didSelectAddDriverButton() {
        self.performSegueWithIdentifier("AutoInsuranceDetailsToAddDriverSegueID", sender: self)
    }
    
    
    // MARK: - IADataManagerDelegate Methods
    
    /**
     * IADataManagerDelegate method. It is implemented to handle response sent by IADataManager.
     */
    internal override func aiDataManagerDidSucceed(sender pSender:IADataManager, response pResponse: IADataManagerResponse) {
        IAAppDelegate.currentAppDelegate.hideLoadingOverlay()
        
        if pResponse.error != nil {
            self.displayMessage(message: pResponse.error.localizedDescription, type: IAMessageType.Error)
        } else if pSender.requestType == IARequestType.ListVehicles {
            if pResponse.result != nil {
                self.vehicleArray = pResponse.result as! Array
            } else {
                self.vehicleArray = nil
            }
            self.reloadAllView()
            
            IAAppDelegate.currentAppDelegate.displayLoadingOverlay()
            self.dataManager.listDrivers()
        } else if pSender.requestType == IARequestType.ListDrivers {
            if pResponse.result != nil {
                self.driverArray = pResponse.result as! Array
            } else {
                self.driverArray = nil
            }
            self.reloadAllView()
        }
    }
}
