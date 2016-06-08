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
        
        self.reloadAllData()
    }
    
    
    func reloadAllData() {
        //IAAppDelegate.currentAppDelegate.displayLoadingOverlay()
        self.dataManager.listClaims()
    }
    
    
    func reloadAllView() {
       // self.claimTableView.reloadData()
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
