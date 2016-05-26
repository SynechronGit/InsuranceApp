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
            return NSBundle.mainBundle().pathForResource("AppDatabase", ofType: "sqlite")!
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
