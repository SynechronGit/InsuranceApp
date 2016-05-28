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
    
    
    static var documentDirectoryPath :String {
        get {
            return NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        }
    }
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
