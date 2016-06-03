//
//  IATextField.swift
//  InsuranceApp
//
//  Created by rupendra on 6/3/16.
//  Copyright © 2016 com. All rights reserved.
//

import UIKit

class IATextField: UITextField {
    var shouldDisplayAsDropdown :Bool!
    
    
    private var bottomBorderLayer :CALayer!
    
    /**
     * Override init method so that common initialization will be done from different init methods.
     */
    required init(coder pDecoder: NSCoder) {
        super.init(coder:pDecoder)!
        self.initialize()
    }
    
    
    /**
     * Override init method so that common initialization will be done from different init methods.
     */
    override init(frame:CGRect) {
        super.init(frame:frame)
        self.initialize()
        
    }
    
    
    /**
     * Override init method so that common initialization will be done from different init methods.
     */
    override  func awakeFromNib() {
        super.awakeFromNib()
        self.initialize()
    }
    
    
    /**
     * Method that will perform initialization tasks for this view.
     */
    func initialize() {
        if self.bottomBorderLayer == nil {
            self.layer.masksToBounds = false
            self.bottomBorderLayer = CALayer()
            self.bottomBorderLayer.frame = CGRectMake(0.0, self.bounds.size.height - 2, self.bounds.size.width, 2.0)
            self.bottomBorderLayer.backgroundColor = UIColor.lightGrayColor().CGColor
            self.layer.addSublayer(self.bottomBorderLayer)
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if self.bottomBorderLayer != nil {
            self.bottomBorderLayer.frame = CGRectMake(0.0, self.bounds.size.height + 3, self.bounds.size.width, 2.0)
        }
        if self.shouldDisplayAsDropdown != nil && self.shouldDisplayAsDropdown == true && self.rightView == nil {
            self.rightView = UIImageView(frame: CGRectMake(0.0, 0.0, 19.0, 19.0))
            (self.rightView as! UIImageView).image = UIImage(named: "nextArrow")
            (self.rightView as! UIImageView).contentMode = UIViewContentMode.ScaleAspectFit
            self.rightViewMode = UITextFieldViewMode.Always
            
            self.userInteractionEnabled = false
        }
    }
}
