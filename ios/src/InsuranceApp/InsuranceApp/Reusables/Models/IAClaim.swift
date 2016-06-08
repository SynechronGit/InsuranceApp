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
    var statusDisplayText:String! {
        get {
            var aReturnVal :String!
            
            if self.status != nil {
                if self.status == "UNDER_REVIEW" {
                    aReturnVal = "Under Review"
                } else if self.status == "REPORT" {
                    aReturnVal = "Report"
                } else if self.status == "APPROVED" {
                    aReturnVal = "Approved"
                }
            }
            
            return aReturnVal
        }
    }
}
