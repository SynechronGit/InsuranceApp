//
//  NSDateAdditions.swift
//  InsuranceApp
//
//  Created by rupendra on 6/10/16.
//  Copyright © 2016 com. All rights reserved.
//

import UIKit

extension NSDate {
    static func dateFromString(pDateString :String, format pDateFormat :String) -> NSDate! {
        var aReturnVal :NSDate! = nil
        
        let aDateFormatter = NSDateFormatter()
        aDateFormatter.locale = NSLocale(localeIdentifier: "US_en")
        aDateFormatter.dateFormat = pDateFormat
        
        aReturnVal = aDateFormatter.dateFromString(pDateString)
        
        return aReturnVal
    }
    
    
    func stringWithFormat(pDateFormat :String) -> String! {
        var aReturnVal :String! = nil
        
        let aDateFormatter = NSDateFormatter()
        aDateFormatter.locale = NSLocale(localeIdentifier: "US_en")
        aDateFormatter.dateFormat = pDateFormat
        
        aReturnVal = aDateFormatter.stringFromDate(self)
        
        return aReturnVal
    }
    
    
    var year :Int! {
        get {
            var aReturnVal :Int! = nil
            
            let aDateComponents :NSDateComponents = NSCalendar.currentCalendar().components(NSCalendarUnit.Year, fromDate: self)
            aReturnVal = aDateComponents.year
            
            return aReturnVal
        }
    }
}
