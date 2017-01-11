//
//  NSDateAdditions.swift
//  InsuranceApp
//
//  Created by rupendra on 6/10/16.
//  Copyright © 2016 com. All rights reserved.
//

import UIKit

extension Date {
    static func dateFromString(_ pDateString :String, format pDateFormat :String) -> Date! {
        var aReturnVal :Date! = nil
        
        let aDateFormatter = DateFormatter()
        aDateFormatter.locale = Locale(identifier: "US_en")
        aDateFormatter.dateFormat = pDateFormat
        
        aReturnVal = aDateFormatter.date(from: pDateString)
        
        return aReturnVal
    }
    
    
    func stringWithFormat(_ pDateFormat :String) -> String! {
        var aReturnVal :String! = nil
        
        let aDateFormatter = DateFormatter()
        aDateFormatter.locale = Locale(identifier: "US_en")
        aDateFormatter.dateFormat = pDateFormat
        
        aReturnVal = aDateFormatter.string(from: self)
        
        return aReturnVal
    }
    
    
    var year :Int! {
        get {
            var aReturnVal :Int! = nil
            
            let aDateComponents :DateComponents = (Calendar.current as NSCalendar).components(NSCalendar.Unit.year, from: self)
            aReturnVal = aDateComponents.year
            
            return aReturnVal
        }
    }
}
