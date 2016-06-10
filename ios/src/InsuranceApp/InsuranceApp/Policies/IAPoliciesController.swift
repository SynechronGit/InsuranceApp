//
//  IAPoliciesController.swift
//  InsuranceApp
//
//  Created by rupendra on 6/1/16.
//  Copyright © 2016 com. All rights reserved.
//

import UIKit

class IAPoliciesController: IABaseController {
    @IBOutlet weak var policyListContainerView: UIView!
    var policyArray :Array<IAPolicy>!
    @IBOutlet weak var policyTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Policies"
        
        self.policyListContainerView.layer.cornerRadius = IAConstants.dashboardSubviewCornerRadius
        self.policyListContainerView.layer.masksToBounds = true
        
        self.policyTableView.tableFooterView = UIView()
        
        self.reloadAllData()
    }
    
    
    func reloadAllData() {
        IAAppDelegate.currentAppDelegate.displayLoadingOverlay()
        self.dataManager.listPolicies()
    }
    
    
    func reloadAllView() {
        self.policyTableView.reloadData()
    }
    
    
    // MARK: - UITableView Methods
    
    /**
     * Method that will calculate and return number of rows in given section of table.
     * @return Int. Number of rows in given section
     */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var aReturnVal :Int = 0
        
        if self.policyArray != nil {
            aReturnVal = self.policyArray.count
        }
        
        return aReturnVal
    }
    
    
    /**
     * Method that will init, set and return the cell view.
     * @return UITableViewCell. View of the cell in given table view.
     */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let aReturnVal:IAPolicyListTableCellView = tableView.dequeueReusableCellWithIdentifier("IAPolicyListTableCellViewID") as! IAPolicyListTableCellView
        aReturnVal.backgroundColor = UIColor.clearColor()
        aReturnVal.accessoryType = .DisclosureIndicator
        
        if self.policyArray != nil {
            let aPolicy = self.policyArray[indexPath.row]
            
            aReturnVal.policyNumberLabel.text = aPolicy.policyNumber
            
            aReturnVal.insuranceTypeLabel?.text = aPolicy.insuranceType
            
            aReturnVal.insurerLabel.text = aPolicy.insurer
            
            if aPolicy.insuranceType == "Auto" {
                aReturnVal.colorStripeView.backgroundColor = UIColor(red: 165.0/255.0, green: 103.0/255.0, blue: 187.0/255.0, alpha: 1.0)
                aReturnVal.insuredItemCountTitleLabel.text = "Insured Vehicles:"
                aReturnVal.insuredItemCountLabel?.text = String(format: "%02d", aPolicy.insuredVehicleCount)
            } else if aPolicy.insuranceType == "Home" {
                aReturnVal.colorStripeView.backgroundColor = UIColor(red: 201.0/255.0, green: 174.0/255.0, blue: 37.0/255.0, alpha: 1.0)
                aReturnVal.insuredItemCountTitleLabel.text = "Insured Items:"
                aReturnVal.insuredItemCountLabel?.text = String(format: "%02d", aPolicy.insuredHomeItemCount)
            } else if aPolicy.insuranceType == "Boat" {
                aReturnVal.colorStripeView.backgroundColor = UIColor(red: 27.0/255.0, green: 167.0/255.0, blue: 185.0/255.0, alpha: 1.0)
                aReturnVal.insuredItemCountTitleLabel.text = "Insured Boats:"
                aReturnVal.insuredItemCountLabel?.text = String(format: "%02d", aPolicy.insuredBoatCount)
            } else if aPolicy.insuranceType == "Pets" {
                aReturnVal.colorStripeView.backgroundColor = UIColor(red: 31.0/255.0, green: 170.0/255.0, blue: 67.0/255.0, alpha: 1.0)
                aReturnVal.insuredItemCountTitleLabel.text = "Insured Pets:"
                aReturnVal.insuredItemCountLabel?.text = String(format: "%02d", aPolicy.insuredPetCount)
            }
            
            if aPolicy.insuranceType == "Auto" {
                aReturnVal.insuredDriversCountTitleLabel.hidden = false
                aReturnVal.insuredDriversCountLabel.hidden = false
                aReturnVal.insuredDriversCountLabel?.text = String(format: "%02d", aPolicy.insuredDriverCount)
            } else {
                aReturnVal.insuredDriversCountTitleLabel.hidden = true
                aReturnVal.insuredDriversCountLabel.hidden = true
            }
            
            aReturnVal.coverageLabel?.text = String(format: "$%02d", aPolicy.coverage.integerValue)
            aReturnVal.premiumDueLabel?.text = String(format: "$%02d", aPolicy.premiumDue.integerValue)
            
            aReturnVal.dateLabel.text = "(" + aPolicy.date + ")"
        }
        
        return aReturnVal
    }
    
    
    /**
     * Method that will handle tap on table cell.
     */
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.performSegueWithIdentifier("PolicyListToPolicyDetailsSegueID", sender: self)
    }
    
    
    // MARK: - IADataManagerDelegate Methods
    
    /**
     * IADataManagerDelegate method. It is implemented to handle response sent by IADataManager.
     */
    internal override func aiDataManagerDidSucceed(sender pSender:IADataManager, response pResponse: IADataManagerResponse) {
        IAAppDelegate.currentAppDelegate.hideLoadingOverlay()
        
        if pResponse.error != nil {
            self.displayMessage(message: pResponse.error.localizedDescription, type: IAMessageType.Error)
        } else if pSender.requestType == IARequestType.ListPolicies {
            if pResponse.result != nil {
                self.policyArray = pResponse.result as! Array
            } else {
                self.policyArray = nil
            }
            self.reloadAllView()
        }
    }
    
}
