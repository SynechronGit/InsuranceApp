//
//  IADriverDetailsController.swift
//  InsuranceApp
//
//  Created by rupendra on 6/2/16.
//  Copyright © 2016 com. All rights reserved.
//

import UIKit

class IADriverDetailsController: IABaseController {
    var driver: IADriver!
    
    @IBOutlet weak var driverDetailsContainerView: UIView!
    @IBOutlet weak var drivingLicenseNumberContainerView: UIView!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var driverNameValueLabel: UILabel!
    
    @IBOutlet weak var appointedSinceValueLabel: UILabel!
    @IBOutlet weak var drivingExperienceValueLabel: UILabel!
    @IBOutlet weak var employeeTypeValueLabel: UILabel!
    
    @IBOutlet weak var drivingLicenseNumberValueLabel: UILabel!
    
    @IBOutlet weak var phoneNumberValueLabel: UILabel!
    @IBOutlet weak var emailAddressValueLabel: UILabel!
    @IBOutlet weak var streetAddressValueLabel: UILabel!
    @IBOutlet weak var cityValueLabel: UILabel!
    @IBOutlet weak var stateValueLabel: UILabel!
    @IBOutlet weak var zipValueLabel: UILabel!
    @IBOutlet weak var dateOfBirthValueLabel: UILabel!
    
    
    @IBOutlet weak var trafficViolationTableView: UITableView!
    var trafficViolationArray: Array<IATrafficViolation>!
    
    @IBOutlet weak var scoreMyDriveAppContainerView: UIView!
    @IBOutlet weak var registerSafteyDeviceContainerView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Driver Details"
        
        self.driverDetailsContainerView.layer.cornerRadius = IAConstants.dashboardSubviewCornerRadius
        self.driverDetailsContainerView.layer.masksToBounds = true
        
        self.drivingLicenseNumberContainerView.layer.cornerRadius = IAConstants.dashboardSubviewCornerRadius
        self.drivingLicenseNumberContainerView.layer.masksToBounds = true
        
        let aTapGestureRecognizerScore = UITapGestureRecognizer(target: self, action: #selector(IADriverDetailsController.didSelectScoreMyDrive))
        aTapGestureRecognizerScore.cancelsTouchesInView = false
        self.scoreMyDriveAppContainerView.addGestureRecognizer(aTapGestureRecognizerScore)
        self.scoreMyDriveAppContainerView.layer.cornerRadius = IAConstants.dashboardSubviewCornerRadius
        self.scoreMyDriveAppContainerView.layer.masksToBounds = true
        
        let aTapGestureRecognizerSafety = UITapGestureRecognizer(target: self, action: #selector(IADriverDetailsController.didSelectRegisterSafetyDevice))
        aTapGestureRecognizerSafety.cancelsTouchesInView = false
        self.registerSafteyDeviceContainerView.addGestureRecognizer(aTapGestureRecognizerSafety)
        self.registerSafteyDeviceContainerView.layer.cornerRadius = IAConstants.dashboardSubviewCornerRadius
        self.registerSafteyDeviceContainerView.layer.masksToBounds = true
        
        self.reloadAllData()
    }
    
    
    func reloadAllData() {
        self.trafficViolationArray = Array<IATrafficViolation>()
        
        var aTrafficViolation = IATrafficViolation()
        aTrafficViolation.date = "04 - 08 - 2010"
        aTrafficViolation.type = "Accelerating"
        aTrafficViolation.location = "15/S Street"
        self.trafficViolationArray.append(aTrafficViolation)
        
        aTrafficViolation = IATrafficViolation()
        aTrafficViolation.date = "04 - 08 - 2010"
        aTrafficViolation.type = "Accelerating"
        aTrafficViolation.location = "15/S Street"
        self.trafficViolationArray.append(aTrafficViolation)
        
        aTrafficViolation = IATrafficViolation()
        aTrafficViolation.date = "04 - 08 - 2010"
        aTrafficViolation.type = "Stop Signs"
        aTrafficViolation.location = "15/S Street"
        self.trafficViolationArray.append(aTrafficViolation)
        
        aTrafficViolation = IATrafficViolation()
        aTrafficViolation.date = "04 - 08 - 2010"
        aTrafficViolation.type = "Accelerating"
        aTrafficViolation.location = "15/S Street"
        self.trafficViolationArray.append(aTrafficViolation)
        
        aTrafficViolation = IATrafficViolation()
        aTrafficViolation.date = "04 - 08 - 2010"
        aTrafficViolation.type = "Cornering"
        aTrafficViolation.location = "15/S Street"
        self.trafficViolationArray.append(aTrafficViolation)
        
        self.reloadAllView()
    }
    
    
    func reloadAllView() {
        self.avatarImageView.image = self.driver.avatar
        
        self.driverNameValueLabel.text = self.driver.fullName
        self.appointedSinceValueLabel.text = self.driver.appointedSince
        self.drivingExperienceValueLabel.text = self.driver.drivingExperience
        self.employeeTypeValueLabel.text = self.driver.employeeType
        
        self.drivingLicenseNumberValueLabel.text = self.driver.licenseNumber
        
        self.phoneNumberValueLabel.text = self.driver.phoneNumber
        self.emailAddressValueLabel.text = self.driver.emailAddress
        self.streetAddressValueLabel.text = self.driver.streetAddress
        self.cityValueLabel.text = self.driver.city
        self.stateValueLabel.text = self.driver.state
        self.zipValueLabel.text = self.driver.zip
        self.dateOfBirthValueLabel.text = self.driver.dob
        
        self.trafficViolationTableView.reloadData()
    }
    
    
    // MARK: - UITableView Methods
    
    /**
     * Method that will calculate and return number of rows in given section of table.
     * @return Int. Number of rows in given section
     */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var aReturnVal :Int = 0
        
        if self.trafficViolationArray != nil {
            aReturnVal = self.trafficViolationArray.count
        }
        
        return aReturnVal
    }
    
    //Tap Gesture Selector methods
    @IBAction func didSelectScoreMyDrive(){
         self.performSegueWithIdentifier("DriverDetailsToScroreMyDriveSeague", sender: self)
    }
    
    @IBAction func didSelectRegisterSafetyDevice(){
       // self.performSegueWithIdentifier("DriverDetailsToRegisterSafetyDeviceSeague", sender: self)
    }
    
    /**
     * Method that will init, set and return the cell view.
     * @return UITableViewCell. View of the cell in given table view.
     */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let aReturnVal:IATrafficViolationTableCellView = tableView.dequeueReusableCellWithIdentifier("IATrafficViolationTableCellViewID") as! IATrafficViolationTableCellView
        aReturnVal.backgroundColor = UIColor.clearColor()
        
        if self.trafficViolationArray != nil {
            let aTrafficViolation = self.trafficViolationArray[indexPath.row]
            
            aReturnVal.dateLabel?.text = aTrafficViolation.date
            aReturnVal.violationTypeLabel?.text = aTrafficViolation.type
            aReturnVal.locationLabel?.text = aTrafficViolation.location
        }
        
        return aReturnVal
    }
    
}
