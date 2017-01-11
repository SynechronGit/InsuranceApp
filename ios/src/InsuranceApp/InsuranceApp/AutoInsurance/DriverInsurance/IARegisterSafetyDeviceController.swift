//
//  IARegisterSafetyDeviceController.swift
//  InsuranceApp
//
//  Created by nikhil bahalkar on 09/06/16.
//  Copyright © 2016 com. All rights reserved.
//

import UIKit

class IARegisterSafetyDeviceController: UIViewController {
    @IBOutlet weak var deviceTypeTextField: IATextField!
    @IBOutlet weak var serialNumberTextField: IATextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.deviceTypeTextField.shouldDisplayAsDropdown = true
        self.deviceTypeTextField.controller = self
        self.deviceTypeTextField.list = ["Type A", "Type B", "Type C", "Type D"]
    }
    
    
    @IBAction func didSelectRegisterButton(_ sender: AnyObject) {
        self.view.endEditing(true)
        
        let anAlert = UIAlertController(title: "Registration successful.", message: nil, preferredStyle: .alert)
        anAlert.addAction(UIAlertAction(title: "OK", style: .default, handler : {(action:UIAlertAction) in
            self.deviceTypeTextField.text = nil
            self.serialNumberTextField.text = nil
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(anAlert, animated: true, completion: nil)
    }
    
    
    @IBAction func didSelectCloseButton(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
}
