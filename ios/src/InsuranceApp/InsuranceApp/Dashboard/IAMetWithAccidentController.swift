//
//  IAMetWithAccidentController.swift
//  InsuranceApp
//
//  Created by rupendra on 6/8/16.
//  Copyright © 2016 com. All rights reserved.
//

import UIKit

class IAMetWithAccidentController: UIViewController {

    @IBOutlet weak var callButtonView: UIView!
    @IBOutlet weak var sendLocationView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reloadUI()
        // Do any additional setup after loading the view.
    }
    
    func reloadUI(){
        let aTapGestureRecognizerAccident = UITapGestureRecognizer(target: self, action: #selector(IAMetWithAccidentController.didClickCancel))
        aTapGestureRecognizerAccident.cancelsTouchesInView = false
        
        let aTapGestureRecognizerLocation = UITapGestureRecognizer(target: self, action: #selector(IAMetWithAccidentController.didClickCancel))
        aTapGestureRecognizerLocation.cancelsTouchesInView = false
        
        self.callButtonView.addGestureRecognizer(aTapGestureRecognizerAccident)
        self.sendLocationView.addGestureRecognizer(aTapGestureRecognizerLocation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didClickCancel(_ sender: AnyObject) {
       self.dismiss(animated: true, completion: nil)
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
