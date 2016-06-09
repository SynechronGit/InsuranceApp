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
    
    var timerDuration  = NSTimer()
    var timerDistance  = NSTimer()
    var aDuration : Int = 45
    var aDistance : Int = 20
    var aScore : Int = 550
    var counterStarted : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.profilePicImageView.layer.cornerRadius = self.profilePicImageView.bounds.width/2
        self.profilePicImageView.layer.masksToBounds = true
        
        self.durationLabel.animatedText = String(format: "%02d", 45)
        self.distanceLabel.animatedText = String(format: "%02d", 20)
        self.scoreLabel.animatedText = String(format: "%02d", 550)
        
        self.upArrowImageView.alpha = 0.2
        self.downArrowImageView.alpha = 0.2
    }
    
    
    @IBAction func didClickCancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func startButtonPressed(sender: AnyObject) {
        if !counterStarted {
            counterStarted = true
            timerDuration = NSTimer.scheduledTimerWithTimeInterval(1.2, target: self, selector: #selector(IAScoreMyDriveController.updateDuration), userInfo: nil, repeats: true)
            
            timerDistance = NSTimer.scheduledTimerWithTimeInterval(1.9, target: self, selector: #selector(IAScoreMyDriveController.updateDistance), userInfo: nil, repeats: true)
        }
      
    }
    @IBAction func stopButtonPressed(sender: AnyObject) {
        if counterStarted {
            counterStarted = false
            timerDuration.invalidate()
            timerDistance.invalidate()
            
            let aRandomNumber = arc4random_uniform(400) + 400;
            self.scoreLabel.alpha = 1.0
            self.scoreLabel.animatedText = String(format: "%02d", aRandomNumber)
            
            if(aRandomNumber > 550){
                self.upArrowImageView.alpha = 1.0
                self.downArrowImageView.alpha = 0.2
            } else {
                self.downArrowImageView.alpha = 1.0
                self.upArrowImageView.alpha = 0.2
            }
        }
        
    }

    @IBAction func reportAccidentPressed(sender: AnyObject) {
        
        let anAlert = UIAlertController(title: "Accident reported successfully.", message: nil, preferredStyle: .Alert)
        anAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler : {(action:UIAlertAction) in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        self.presentViewController(anAlert, animated: true, completion: nil)
        
    }
    
    //update Score method
    func updateDuration(){
        self.scoreLabel.alpha = 0.3
        self.upArrowImageView.alpha = 0.2
         self.downArrowImageView.alpha = 0.2
        aDuration += 1
        self.durationLabel.animatedText = String(format: "%02d", aDuration)
    }
    
    //update Distance method
    func updateDistance(){
        aDistance += 1
        self.distanceLabel.animatedText = String(format: "%02d", aDistance)
    }
}
