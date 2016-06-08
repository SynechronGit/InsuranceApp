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
    var claimArray :Array<IAPolicy>!
    @IBOutlet weak var claimTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reloadAllData()
    }
    
    
    func reloadAllData() {
        //IAAppDelegate.currentAppDelegate.displayLoadingOverlay()
        //self.dataManager.listClaims()
    }
    
    
    func reloadAllView() {
        self.claimTableView.reloadData()
    }
    
}
