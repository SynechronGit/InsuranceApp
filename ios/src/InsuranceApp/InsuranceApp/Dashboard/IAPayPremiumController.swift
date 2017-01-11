//
//  IAPayPremiumController.swift
//  InsuranceApp
//
//  Created by rupendra on 6/9/16.
//  Copyright © 2016 com. All rights reserved.
//

import UIKit

class IAPayPremiumController: IABaseController {
    var premiumArray :Array<IAPremium>!
    @IBOutlet weak var premiumTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.premiumTableView.tableFooterView = UIView()
        
        self.reloadAllData()
    }
    
    
    func reloadAllData() {
        IAAppDelegate.currentAppDelegate.displayLoadingOverlay()
        self.dataManager.listPremiums()
    }
    
    
    func reloadAllView() {
        self.premiumTableView.reloadData()
    }
    
    
    @IBAction func didSelectCloseButton(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - UITableView Methods
    
    /**
     * Method that will calculate and return number of rows in given section of table.
     * @return Int. Number of rows in given section
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var aReturnVal :Int = 0
        
        if self.premiumArray != nil {
            aReturnVal = self.premiumArray.count
        }
        
        return aReturnVal
    }
    
    
    /**
     * Method that will init, set and return the cell view.
     * @return UITableViewCell. View of the cell in given table view.
     */
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        let aReturnVal:IAPayPremiumTableCellView = tableView.dequeueReusableCell(withIdentifier: "IAPayPremiumTableCellViewID") as! IAPayPremiumTableCellView
        aReturnVal.backgroundColor = UIColor.clear
        
        if self.premiumArray != nil {
            let aPremium = self.premiumArray[indexPath.row]
            
            aReturnVal.dateLabel.text = aPremium.date
            aReturnVal.nameLabel?.text = aPremium.name
            aReturnVal.policyNumberLabel.text = "Policy Number: #" + aPremium.policyNumber
            aReturnVal.amountLabel?.text = "$" + aPremium.amount
            
            if aPremium.insuranceType == IAInsuranceType.AutoCar.rawValue {
                aReturnVal.amountLabel?.textColor = IAConstants.colorInsuranceTypeAutoCar
            } else if aPremium.insuranceType == IAInsuranceType.AutoDriver.rawValue {
                aReturnVal.amountLabel?.textColor = IAConstants.colorInsuranceTypeAutoDriver
            } else if aPremium.insuranceType == IAInsuranceType.Home.rawValue {
                aReturnVal.amountLabel?.textColor = IAConstants.colorInsuranceTypeHome
            } else if aPremium.insuranceType == IAInsuranceType.Boat.rawValue {
                aReturnVal.amountLabel?.textColor = IAConstants.colorInsuranceTypeBoat
            } else if aPremium.insuranceType == IAInsuranceType.Pet.rawValue {
                aReturnVal.amountLabel?.textColor = IAConstants.colorInsuranceTypePet
            }
        }
        
        return aReturnVal
    }
    
    
    /**
     * Method that will handle tap on table cell.
     */
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // MARK: - IADataManagerDelegate Methods
    
    /**
     * IADataManagerDelegate method. It is implemented to handle response sent by IADataManager.
     */
    internal override func aiDataManagerDidSucceed(sender pSender:IADataManager, response pResponse: IADataManagerResponse) {
        IAAppDelegate.currentAppDelegate.hideLoadingOverlay()
        
        if pResponse.error != nil {
            self.displayMessage(message: pResponse.error.localizedDescription, type: IAMessageType.error)
        } else if pSender.requestType == IARequestType.listPremiums {
            if pResponse.result != nil {
                self.premiumArray = pResponse.result as! Array
            } else {
                self.premiumArray = nil
            }
            self.reloadAllView()
        }
    }
}
