//
//  IAScoreMyDriveController.swift
//  InsuranceApp
//
//  Created by nikhil bahalkar on 09/06/16.
//  Copyright © 2016 com. All rights reserved.
//

import UIKit

class IAScoreMyDriveController: UIViewController {
    var driver: IADriver!

    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
   
    @IBOutlet weak var upArrowImageView: UIImageView!
   
    @IBOutlet weak var durationLabel: IALabel!
    @IBOutlet weak var scoreLabel: IALabel!
    @IBOutlet weak var distanceLabel: IALabel!
    @IBOutlet weak var downArrowImageView: UIImageView!
    
    var timerDuration  = Timer()
    var timerDistance  = Timer()
    var aDuration : Int = 45
    var aDistance : Int = 20
    var aScore : Int = 550
    var counterStarted : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.profilePicImageView.layer.cornerRadius = self.profilePicImageView.bounds.width/2
        self.profilePicImageView.layer.masksToBounds = true
        self.profilePicImageView.image = driver.avatar
        
        self.profileNameLabel.text = driver.fullName
        
        self.durationLabel.animatedText = String(format: "%02d", 45)
        self.distanceLabel.animatedText = String(format: "%02d", 20)
        self.scoreLabel.animatedText = String(format: "%02d", 550)
        
        self.upArrowImageView.alpha = 0.2
        self.downArrowImageView.alpha = 0.2
    }
    
    
    @IBAction func didClickCancel(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func startButtonPressed(_ sender: AnyObject) {
        if !counterStarted {
            counterStarted = true
            timerDuration = Timer.scheduledTimer(timeInterval: 1.2, target: self, selector: #selector(IAScoreMyDriveController.updateDuration), userInfo: nil, repeats: true)
            
            timerDistance = Timer.scheduledTimer(timeInterval: 1.9, target: self, selector: #selector(IAScoreMyDriveController.updateDistance), userInfo: nil, repeats: true)
        }
      
    }
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
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

    @IBAction func reportAccidentPressed(_ sender: AnyObject) {
        
        let anAlert = UIAlertController(title: "Accident reported successfully.", message: nil, preferredStyle: .alert)
        anAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler : {(action:UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(anAlert, animated: true, completion: nil)
        
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
