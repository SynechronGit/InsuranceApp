//
//  IADriverDetailsController.swift
//  InsuranceApp
//
//  Created by rupendra on 6/2/16.
//  Copyright © 2016 com. All rights reserved.
//

import UIKit

class IADriverDetailsController: IABaseController {
    @IBOutlet weak var driverDetailsContainerView: UIView!
    @IBOutlet weak var drivingLicenseNumberContainerView: UIView!
    
    @IBOutlet weak var appointedSinceLabel: UILabel!
    @IBOutlet weak var drivingExperienceLabel: UILabel!
    @IBOutlet weak var employeeTypeLabel: UILabel!
    
    @IBOutlet weak var trafficViolationTableView: UITableView!
    var trafficViolationArray: Array<IATrafficViolation>!
    
    @IBOutlet weak var scoreMyDriveAppContainerView: UIView!
    @IBOutlet weak var registerSafteyDeviceContainerView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.driverDetailsContainerView.layer.cornerRadius = IAConstants.dashboardSubviewCornerRadius
        self.driverDetailsContainerView.layer.masksToBounds = true
        
        self.drivingLicenseNumberContainerView.layer.cornerRadius = IAConstants.dashboardSubviewCornerRadius
        self.drivingLicenseNumberContainerView.layer.masksToBounds = true
        
        self.scoreMyDriveAppContainerView.layer.cornerRadius = IAConstants.dashboardSubviewCornerRadius
        self.scoreMyDriveAppContainerView.layer.masksToBounds = true
        
        //self.registerSafteyDeviceContainerView.layer.cornerRadius = IAConstants.dashboardSubviewCornerRadius
        //self.registerSafteyDeviceContainerView.layer.masksToBounds = true
        
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
    }
    
    
    func reloadAllView() {
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
    
    
    /**
     * Method that will init, set and return the cell view.
     * @return UITableViewCell. View of the cell in given table view.
     */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let aReturnVal:IATrafficViolationTableCellView = tableView.dequeueReusableCellWithIdentifier("IATrafficViolationTableCellViewID") as! IATrafficViolationTableCellView
        
        if self.trafficViolationArray != nil {
            let aTrafficViolation = self.trafficViolationArray[indexPath.row]
            
            aReturnVal.dateLabel?.text = aTrafficViolation.date
            aReturnVal.violationTypeLabel?.text = aTrafficViolation.type
            aReturnVal.locationLabel?.text = aTrafficViolation.location
        }
        
        return aReturnVal
    }
    
}
