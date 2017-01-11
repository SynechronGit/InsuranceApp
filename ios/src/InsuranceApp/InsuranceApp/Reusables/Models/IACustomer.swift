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
        
        if (pDictionary.value(forKey: "customerID") is NSString) == true {
            self.customerID = pDictionary.value(forKey: "customerID") as! String
        }
        if (pDictionary.value(forKey: "firstName") is NSString) == true {
            self.firstName = pDictionary.value(forKey: "firstName") as! String
        }
        if (pDictionary.value(forKey: "lastName") is NSString) == true {
            self.lastName = pDictionary.value(forKey: "lastName") as! String
        }
        if (pDictionary.value(forKey: "avatarImageName") is NSString) == true {
            self.avatar = UIImage(named: pDictionary.value(forKey: "avatarImageName") as! String)
        } else {
            self.avatar = UIImage(named: "DummyIcon")
        }
    }
}
