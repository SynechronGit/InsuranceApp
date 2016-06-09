//
//  IAScoreMyDriveController.swift
//  InsuranceApp
//
//  Created by nikhil bahalkar on 09/06/16.
//  Copyright © 2016 com. All rights reserved.
//

import UIKit

class IAScoreMyDriveController: UIViewController {

    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
   
    @IBOutlet weak var upArrowImageView: UIImageView!
   
    @IBOutlet weak var durationLabel: IALabel!
    @IBOutlet weak var scoreLabel: IALabel!
    @IBOutlet weak var distanceLabel: IALabel!
    @IBOutlet weak var downArrowImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.durationLabel.animatedText = "45"//String(format: "%02d", 3)
        self.distanceLabel.animatedText = String(format: "%02d", 45)
        self.scoreLabel.animatedText = String(format: "%02d", 550)
    }
    
    
    @IBAction func didClickCancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func startButtonPressed(sender: AnyObject) {
    }
    @IBAction func stopButtonPressed(sender: AnyObject) {
    }

    @IBAction func reportAccidentPressed(sender: AnyObject) {
    }
}
