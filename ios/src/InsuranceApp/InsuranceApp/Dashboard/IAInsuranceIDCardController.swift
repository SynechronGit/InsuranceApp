//
//  IAInsuranceIDCardController.swift
//  InsuranceApp
//
//  Created by rupendra on 6/8/16.
//  Copyright © 2016 com. All rights reserved.
//

import UIKit

class IAInsuranceIDCardController: UIViewController {
    @IBOutlet weak var insuranceIDCardWebView: UIWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reloadAllData()
    }
    
    
    func reloadAllData() {
        self.reloadAllView()
    }
    
    
    func reloadAllView() {
        let aPdfFilePath = NSBundle.mainBundle().pathForResource("InsuranceIDCard", ofType: "pdf")
        if aPdfFilePath != nil {
            let aRequest = NSURLRequest(URL: NSURL(fileURLWithPath: aPdfFilePath!))
            self.insuranceIDCardWebView.loadRequest(aRequest)
        }
    }
    
    
    @IBAction func didSelectCancelButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
