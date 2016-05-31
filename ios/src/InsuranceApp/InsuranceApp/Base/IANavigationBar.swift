//
//  IANavigationBar.swift
//  InsuranceApp
//
//  Created by rupendra on 5/30/16.
//  Copyright © 2016 com. All rights reserved.
//

import UIKit

class IANavigationBar: UINavigationBar {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.barStyle  = UIBarStyle.BlackOpaque
        self.backgroundColor = UIColor(red: 11.0/255.0, green: 9.0/255.0, blue: 16.0/255.0, alpha: 1.0)
        self.tintColor = UIColor.whiteColor()
        self.barTintColor = UIColor(red: 11.0/255.0, green: 9.0/255.0, blue: 16.0/255.0, alpha: 1.0)
        self.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.shadowImage = UIImage()
    }
}
