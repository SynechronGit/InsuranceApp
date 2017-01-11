//
//  IAPolicyDetailsController.swift
//  InsuranceApp
//
//  Created by rupendra on 6/7/16.
//  Copyright © 2016 com. All rights reserved.
//

import UIKit

class IAPolicyDetailsController: UIViewController {
    @IBOutlet weak var policyDetailsContainerView: UIView!
    @IBOutlet weak var policyDetailsWebView: UIWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Policies"
        
        self.policyDetailsContainerView.layer.cornerRadius = IAConstants.dashboardSubviewCornerRadius
        self.policyDetailsContainerView.layer.masksToBounds = true
        
        self.reloadAllData()
    }
    
    
    func reloadAllData() {
        self.reloadAllView()
    }
    
    
    func reloadAllView() {
        let aPdfFilePath = Bundle.main.path(forResource: "PolicyGeneral", ofType: "pdf")
        if aPdfFilePath != nil {
            let aRequest = URLRequest(url: URL(fileURLWithPath: aPdfFilePath!))
            self.policyDetailsWebView.loadRequest(aRequest)
        }
    }
    
}
