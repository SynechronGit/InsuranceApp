//
//  IAClaimsController.swift
//  InsuranceApp
//
//  Created by rupendra on 6/1/16.
//  Copyright © 2016 com. All rights reserved.
//

import UIKit

class IAClaimsController: IABaseController {
    @IBOutlet weak var claimListContainerView: UIView!
    var claimArray :Array<IAClaim>!
    @IBOutlet weak var claimTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.claimTableView.tableFooterView = UIView()
        
        self.reloadAllData()
    }
    
    
    func reloadAllData() {
        IAAppDelegate.currentAppDelegate.displayLoadingOverlay()
        self.dataManager.listClaims()
    }
    
    
    func reloadAllView() {
        self.claimTableView.reloadData()
    }
    
    
    // MARK: - UITableView Methods
    
    /**
     * Method that will calculate and return number of rows in given section of table.
     * @return Int. Number of rows in given section
     */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var aReturnVal :Int = 0
        
        if self.claimArray != nil {
            aReturnVal = self.claimArray.count
        }
        
        return aReturnVal
    }
    
    
    /**
     * Method that will init, set and return the cell view.
     * @return UITableViewCell. View of the cell in given table view.
     */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let aReturnVal:IAClaimListTableCellView = tableView.dequeueReusableCellWithIdentifier("IAClaimListTableCellViewID") as! IAClaimListTableCellView
        aReturnVal.backgroundColor = UIColor.clearColor()
        aReturnVal.accessoryType = .DisclosureIndicator
        
        if self.claimArray != nil {
            let aClaim = self.claimArray[indexPath.row]
            
            aReturnVal.colorStripeView.backgroundColor = aClaim.insuranceTypeColor
            aReturnVal.codeLabel?.text = "#" + aClaim.code
            aReturnVal.codeLabel.textColor = aClaim.insuranceTypeColor
            aReturnVal.dateOfClaimLabel?.text = aClaim.dateOfClaim
            aReturnVal.insuranceTypeLabel?.text = aClaim.insuranceTypeDisplayText
            
            if aClaim.insuranceType == IAInsuranceType.AutoCar.rawValue {
                aReturnVal.insuredItemTitleLabel?.text = "Insured Car:"
            } else if aClaim.insuranceType == IAInsuranceType.AutoDriver.rawValue {
                aReturnVal.insuredItemTitleLabel?.text = "Insured Driver:"
            } else if aClaim.insuranceType == IAInsuranceType.Boat.rawValue {
                aReturnVal.insuredItemTitleLabel?.text = "Insured Boat:"
            } else if aClaim.insuranceType == IAInsuranceType.Pet.rawValue {
                aReturnVal.insuredItemTitleLabel?.text = "Insured Pet:"
            }
            aReturnVal.insuredItemValueLabel?.text = aClaim.insuredItemName
            aReturnVal.insurerLabel?.text = aClaim.insurer
            
            let aCurrentStatusColor = UIColor(red: 0.0/255.0, green: 200.0/255.0, blue: 0.0/255.0, alpha: 1.0)
            if aClaim.status == IAClaimStatus.Report.rawValue {
                aReturnVal.statusReportLabel.textColor = aCurrentStatusColor
                aReturnVal.statusUnderReviewLabel.textColor = UIColor.blackColor()
                aReturnVal.statusApprovedLabel.textColor = UIColor.blackColor()
                
                aReturnVal.statusReportDoneImageView.image = UIImage(named: "ClaimStatusRightArrowNormal")
                aReturnVal.statusUnderReviewDoneImageView.image = UIImage(named: "ClaimStatusRightArrowNormal")
            } else if aClaim.status == IAClaimStatus.UnderReview.rawValue {
                aReturnVal.statusReportLabel.textColor = UIColor.blackColor()
                aReturnVal.statusUnderReviewLabel.textColor = aCurrentStatusColor
                aReturnVal.statusApprovedLabel.textColor = UIColor.blackColor()
                
                aReturnVal.statusReportDoneImageView.image = UIImage(named: "ClaimStatusRightArrowDone")
                aReturnVal.statusUnderReviewDoneImageView.image = UIImage(named: "ClaimStatusRightArrowNormal")
            } else if aClaim.status == IAClaimStatus.Approved.rawValue {
                aReturnVal.statusReportLabel.textColor = UIColor.blackColor()
                aReturnVal.statusUnderReviewLabel.textColor = UIColor.blackColor()
                aReturnVal.statusApprovedLabel.textColor = aCurrentStatusColor
                
                aReturnVal.statusReportDoneImageView.image = UIImage(named: "ClaimStatusRightArrowDone")
                aReturnVal.statusUnderReviewDoneImageView.image = UIImage(named: "ClaimStatusRightArrowDone")
            }
        }
        
        return aReturnVal
    }
    
    
    /**
     * Method that will handle tap on table cell.
     */
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.performSegueWithIdentifier("ClaimListToClaimDetailsSegueID", sender: self)
    }
    
    
    // MARK: - IADataManagerDelegate Methods
    
    /**
     * IADataManagerDelegate method. It is implemented to handle response sent by IADataManager.
     */
    internal override func aiDataManagerDidSucceed(sender pSender:IADataManager, response pResponse: IADataManagerResponse) {
        IAAppDelegate.currentAppDelegate.hideLoadingOverlay()
        
        if pResponse.error != nil {
            self.displayMessage(message: pResponse.error.localizedDescription, type: IAMessageType.Error)
        } else if pSender.requestType == IARequestType.ListClaims {
            if pResponse.result != nil {
                self.claimArray = pResponse.result as! Array
            } else {
                self.claimArray = nil
            }
            self.reloadAllView()
        }
    }
    
}
