//
//  IAUtils.swift
//  InsuranceApp
//
//  Created by rupendra on 6/9/16.
//  Copyright © 2016 com. All rights reserved.
//

import UIKit

class IAUtils: NSObject {
    static func doesRegexMatch(pRegexPattern :String, subject pSubject :String) throws -> Bool {
        var aReturnVal :Bool = false
        
        let aRegularExpression = try NSRegularExpression(pattern: pRegexPattern, options: NSRegularExpressionOptions.CaseInsensitive)
        if aRegularExpression.firstMatchInString(pSubject, options: NSMatchingOptions.ReportCompletion, range: NSMakeRange(0, (pSubject.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)))) != nil {
            aReturnVal = true
        }
        
        return aReturnVal
    }
    
    static func convertStringtoInt(aIntString: String) -> Int {
        var convertedInt : Int = Int()
        if let myNumber = NSNumberFormatter().numberFromString(aIntString) {
             convertedInt = myNumber.integerValue
        }
    return convertedInt
    }
}
