//
//  IARoadsideAssistanceController.swift
//  InsuranceApp
//
//  Created by rupendra on 6/8/16.
//  Copyright © 2016 com. All rights reserved.
//

import UIKit

class IARoadsideAssistanceController: UIViewController {

    @IBOutlet weak var flatTyreView: UIView!
    @IBOutlet weak var towCarView: UIView!
    @IBOutlet weak var batteryView: UIView!
    @IBOutlet weak var rentCarView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reloadUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reloadUI(){
        let aTapGestureRecognizerTyre = UITapGestureRecognizer(target: self, action: #selector(IARoadsideAssistanceController.didSelectCancelButton))
        aTapGestureRecognizerTyre.cancelsTouchesInView = false
        
        let aTapGestureRecognizerTow = UITapGestureRecognizer(target: self, action: #selector(IARoadsideAssistanceController.didSelectCancelButton))
        aTapGestureRecognizerTow.cancelsTouchesInView = false
        
        let aTapGestureRecognizerBattery = UITapGestureRecognizer(target: self, action: #selector(IARoadsideAssistanceController.didSelectCancelButton))
        aTapGestureRecognizerBattery.cancelsTouchesInView = false
        
        let aTapGestureRecognizerRent = UITapGestureRecognizer(target: self, action: #selector(IARoadsideAssistanceController.didSelectCancelButton))
        aTapGestureRecognizerRent.cancelsTouchesInView = false
        
        self.flatTyreView.addGestureRecognizer(aTapGestureRecognizerTyre)
        self.towCarView.addGestureRecognizer(aTapGestureRecognizerTow)
        self.batteryView.addGestureRecognizer(aTapGestureRecognizerBattery)
        self.rentCarView.addGestureRecognizer(aTapGestureRecognizerRent)
        
    }
    
    
    
    @IBAction func didSelectCancelButton(sender: AnyObject) {
         self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
