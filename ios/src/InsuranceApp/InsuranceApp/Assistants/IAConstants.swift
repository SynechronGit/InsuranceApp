//
//  IAConstants.swift
//  InsuranceApp
//
//  Created by rupendra on 5/24/16.
//  Copyright © 2016 com. All rights reserved.
//

import UIKit

class IAConstants: NSObject {
    static let dataManagerResponseDelayInSeconds :Double = 1.0
    static var dataManagerSqliteFilePath :String {
        get {
            let aReturnVal = String(format: "%@/AppDatabase.sqlite", IAConstants.documentDirectoryPath)
            print("sqlite directory path: \(IAConstants.documentDirectoryPath)")
            
            do {
                // If database is not available then create it. This code is written here so that all the other objects need not implement the database availability logic.
                if NSFileManager.defaultManager().fileExistsAtPath(aReturnVal) != true {
                    try NSFileManager.defaultManager().copyItemAtPath(NSBundle.mainBundle().pathForResource("AppDatabase", ofType: "sqlite")!, toPath: aReturnVal)
                }
            } catch {
                NSLog("Can not copy app database.")
            }
            
            return aReturnVal
        }
    }
    
    static let dashboardSubviewCornerRadius :CGFloat = 5.0
    
    
    static var documentDirectoryPath :String {
        get {
            return NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        }
    }
    
    
    static var homeController :IAHomeController {
        get {
            var aReturnVal = IAHomeController()
            
            let anAppDelegate = UIApplication.sharedApplication().delegate as! IAAppDelegate
            let aRootController = anAppDelegate.window?.rootViewController as! UINavigationController
            if  aRootController.viewControllers.count >= 2 {
                aReturnVal = aRootController.viewControllers[1] as! IAHomeController
            }
            
            return aReturnVal
        }
    }
    
    static let colorInsuranceTypeAutoCar :UIColor = UIColor(red: 161.0/255.0, green: 91.0/255.0, blue: 186.0/255.0, alpha: 1.0)
    static let colorInsuranceTypeAutoDriver :UIColor = UIColor(red: 161.0/255.0, green: 91.0/255.0, blue: 186.0/255.0, alpha: 1.0)
    static let colorInsuranceTypeHome :UIColor = UIColor(red: 201.0/255.0, green: 171.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    static let colorInsuranceTypeBoat :UIColor = UIColor(red: 0.0/255.0, green: 170.0/255.0, blue: 183.0/255.0, alpha: 1.0)
    static let colorInsuranceTypePet :UIColor = UIColor(red: 0.0/255.0, green: 168.0/255.0, blue: 45.0/255.0, alpha: 1.0)
    
    static let dateFormatAppStandard = "MM - dd - yyyy"
}


class IAGlobalData: NSObject {
    static var __sharedInstance :IAGlobalData!
    static var sharedInstance :IAGlobalData {
        get {
            if __sharedInstance == nil {
                __sharedInstance = IAGlobalData()
            }
            return __sharedInstance
        }
    }
    
    var loggedInCustomer :IACustomer!
}


/**
 * Enum to define different error types.
 */
public enum IAError: ErrorType {
    case Generic(NSError)
}


/**
 * Enum to define different message types.
 */
public enum IAMessageType: Int {
    case Success
    case Error
    case Information
}


/**
 * Enum to define different claim status types.
 */
public enum IAClaimStatus: String {
    case Report = "REPORT"
    case UnderReview = "UNDER_REVIEW"
    case Approved = "APPROVED"
}


/**
 * Enum to define different insurance types.
 */
public enum IAInsuranceType: String {
    case AutoCar = "AUTO_CAR"
    case AutoDriver = "AUTO_DRIVER"
    case Home = "HOME"
    case Boat = "BOAT"
    case Pet = "PET"
}