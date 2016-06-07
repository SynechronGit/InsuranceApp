//
//  IAVehicle.swift
//  InsuranceApp
//

import UIKit

class IAVehicle: NSObject {
    var photoOne :UIImage!
    var photoTwo :UIImage!
    var photoThree :UIImage!
    
    var year :String!
    var company :String!
    var modelNumber :String!
    var bodyStyle :String!
    var vin :String!
    var vehicleDescription :String!
    var comprehensiveCoverage :String!
    var collisionCoverage :String!
    var vehicleName : String!
    
    
    var title :String! {
        get {
            return self.company + " " + self.modelNumber
        }
    }
}
