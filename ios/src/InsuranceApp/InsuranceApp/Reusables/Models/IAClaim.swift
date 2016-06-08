//
//  IAClaim.swift
//  InsuranceApp
//
//  Created by rupendra on 6/8/16.
//  Copyright © 2016 com. All rights reserved.
//

import UIKit

class IAClaim: NSObject {
    var code:String!
    var insuranceType:String!
    var insuranceTypeColor:UIColor! {
        get {
            var aReturnVal :UIColor!
            
            if self.insuranceType != nil {
                if self.insuranceType == IAInsuranceType.AutoCar.rawValue || self.insuranceType == IAInsuranceType.AutoDriver.rawValue {
                    aReturnVal = UIColor(red: 165.0/255.0, green: 103.0/255.0, blue: 187.0/255.0, alpha: 1.0)
                } else if self.insuranceType == IAInsuranceType.Home.rawValue {
                    aReturnVal = UIColor(red: 201.0/255.0, green: 174.0/255.0, blue: 37.0/255.0, alpha: 1.0)
                } else if self.insuranceType == IAInsuranceType.Boat.rawValue {
                    aReturnVal = UIColor(red: 27.0/255.0, green: 167.0/255.0, blue: 185.0/255.0, alpha: 1.0)
                } else if self.insuranceType == IAInsuranceType.Pet.rawValue {
                    aReturnVal = UIColor(red: 31.0/255.0, green: 170.0/255.0, blue: 67.0/255.0, alpha: 1.0)
                }
            }
            
            return aReturnVal
        }
    }
    
    var insuranceTypeDisplayText:String! {
        get {
            var aReturnVal :String!
            
            if self.insuranceType != nil {
                if self.insuranceType == "BOAT" {
                    aReturnVal = "Boat"
                } else if self.insuranceType == "AUTO_CAR" || self.status == "AUTO_DRIVER" {
                    aReturnVal = "Auto"
                } else if self.insuranceType == "PET" {
                    aReturnVal = "Pet"
                }
            }
            
            return aReturnVal
        }
    }
    var dateOfClaim:String!
    var insuredItemName:String!
    var insurer:String!
    var status:String!
    var dateOfIncident:String!
    var incedentType:String!
    var value:String!
    var photoOne :UIImage!
    var photoTwo :UIImage!
    var photoThree :UIImage!
    var statusDisplayText:String! {
        get {
            var aReturnVal :String!
            
            if self.status != nil {
                if self.status == IAClaimStatus.UnderReview.rawValue {
                    aReturnVal = "Under Review"
                } else if self.status == IAClaimStatus.Report.rawValue {
                    aReturnVal = "Report"
                } else if self.status == IAClaimStatus.Approved.rawValue {
                    aReturnVal = "Approved"
                }
            }
            
            return aReturnVal
        }
    }
}
