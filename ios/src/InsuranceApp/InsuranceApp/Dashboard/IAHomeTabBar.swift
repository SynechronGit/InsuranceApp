//
//  IAHomeTabBar.swift
//  InsuranceApp
//
//  Created by rupendra on 5/30/16.
//  Copyright © 2016 com. All rights reserved.
//

import UIKit

class IAHomeTabBar: UITabBar {
    
    override func layoutSubviews() {
        self.backgroundColor = UIColor(red: 11.0/255.0, green: 9.0/255.0, blue: 16.0/255.0, alpha: 1.0)
    }
    
    override func sizeThatFits(size: CGSize) -> CGSize {
        var aReturnVal = super.sizeThatFits(size)
        aReturnVal.height = 75.0
        return aReturnVal
    }

}
