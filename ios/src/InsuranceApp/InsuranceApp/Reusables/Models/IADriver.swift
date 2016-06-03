//
//  IAAddDriver.swift
//  InsuranceApp
//


import UIKit

class IADriver:NSObject {
    var avatar:UIImage!
    var firstName:String!
    var lastName:String!
    var appointedSince :String!
    var drivingExperience :String!
    var employeeType :String!
    var licenseNumber :String!
    var phoneNumber :String!
    var emailAddress :String!
    var streetAddress :String!
    var city :String!
    var state :String!
    var zip :String!
    var dob :String!
    var status :String!
    
    
    var fullName:String! {
        let aReturnVal = (self.firstName != nil ? self.firstName : "") + " " + (self.lastName != nil ? self.lastName : "")
        return aReturnVal
    }
}

