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
}


/**
 * Enum to define different message types.
 */
public enum IAMessageType: Int {
    case Success
    case Error
    case Information
}
