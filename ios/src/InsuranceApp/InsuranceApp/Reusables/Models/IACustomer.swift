//
//  IACustomer.swift
//  InsuranceApp
//
//  Created by rupendra on 5/24/16.
//  Copyright © 2016 com. All rights reserved.
//

import UIKit

class IACustomer: NSObject {
    var customerID: String!
    var avatar: UIImage!
    var firstName: String!
    var lastName: String!
    var emailAddress: String!
    var password: String!
    
    
    override init() {
        super.init()
    }
    
    
    /**
     * Init method to parse data from server and assign to model object.
     * @param pDictionary:NSDictionary. Server response dictionary.
     * @return DGPeron object.
     */
    init(dictionary pDictionary:NSDictionary) {
        super.init()
        
        if pDictionary.valueForKey("customerID")?.isKindOfClass(NSString) == true {
            self.customerID = pDictionary.valueForKey("customerID") as! String
        }
        if pDictionary.valueForKey("firstName")?.isKindOfClass(NSString) == true {
            self.firstName = pDictionary.valueForKey("firstName") as! String
        }
        if pDictionary.valueForKey("lastName")?.isKindOfClass(NSString) == true {
            self.lastName = pDictionary.valueForKey("lastName") as! String
        }
        if pDictionary.valueForKey("avatarImageName")?.isKindOfClass(NSString) == true {
            self.avatar = UIImage(named: pDictionary.valueForKey("avatarImageName") as! String)
        } else {
            self.avatar = UIImage(named: "DummyIcon")
        }
    }
}
