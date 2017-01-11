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
        let aPdfFilePath = Bundle.main.path(forResource: "InsuranceIDCard", ofType: "pdf")
        if aPdfFilePath != nil {
            let aRequest = URLRequest(url: URL(fileURLWithPath: aPdfFilePath!))
            self.insuranceIDCardWebView.loadRequest(aRequest)
        }
    }
    
    
    @IBAction func didSelectCancelButton(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
