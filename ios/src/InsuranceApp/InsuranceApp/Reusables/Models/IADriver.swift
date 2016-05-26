//
//  IAAddDriver.swift
//  InsuranceApp
//


import Foundation

struct IADriver {
    
    var firstName:String!
    var lastName:String!
    var relationship:String!
    var dob:NSDate!
    var state:String!
    var license:String!
    var type:String!
    var status:String!
    
    
    init() {
    }
    
    
    func dobDisplayText() -> String {
        return "11-22-3333"
    }
}

