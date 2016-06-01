//
//  IAAddDriver.swift
//  InsuranceApp
//


import UIKit

class IADriver:NSObject {
    
    var firstName:String!
    var lastName:String!
    var relationship:String!
    var dob:String!
    var state:String!
    var license:String!
    var type:String!
    var status:String!
    var avatar:UIImage!
    
    
    var fullName:String! {
        let aReturnVal = (self.firstName != nil ? self.firstName : "") + "" + (self.lastName != nil ? self.lastName : "")
        return aReturnVal
    }
}

