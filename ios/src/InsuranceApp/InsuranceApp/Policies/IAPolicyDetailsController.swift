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
        let aPdfFilePath = NSBundle.mainBundle().pathForResource("PolicyGeneral", ofType: "pdf")
        if aPdfFilePath != nil {
            let aRequest = NSURLRequest(URL: NSURL(fileURLWithPath: aPdfFilePath!))
            self.policyDetailsWebView.loadRequest(aRequest)
        }
    }
    
}
