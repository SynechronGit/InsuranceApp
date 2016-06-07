//
//  IATextField.swift
//  InsuranceApp
//
//  Created by rupendra on 6/3/16.
//  Copyright © 2016 com. All rights reserved.
//

import UIKit


protocol IATextFieldDelegate : class {
    func iaTextFieldDidSelectValue(pTextField:IATextField)
}


class IATextField: UITextField, IADropdownListControllerDelegate {
    var shouldDisplayAsDropdown :Bool!
    var shouldDisplayAsDatePicker :Bool!
    weak var controller :UIViewController!
    weak var iaTextFieldDelegate :AnyObject!
    var dropdownListController :IADropdownListController!
    var list :Array<String>!
    
    
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
        if ((self.shouldDisplayAsDropdown != nil && self.shouldDisplayAsDropdown == true) || (self.shouldDisplayAsDropdown != nil && self.shouldDisplayAsDropdown == true)) && self.rightView == nil {
            self.rightView = UIImageView(frame: CGRectMake(0.0, 0.0, 13.0, 13.0))
            (self.rightView as! UIImageView).image = UIImage(named: "DropdownArrow")
            (self.rightView as! UIImageView).contentMode = UIViewContentMode.ScaleAspectFit
            self.rightViewMode = UITextFieldViewMode.Always
        }
    }
    
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if (self.shouldDisplayAsDropdown != nil && self.shouldDisplayAsDropdown == true) || (self.shouldDisplayAsDatePicker != nil && self.shouldDisplayAsDatePicker == true) {
            self.resignFirstResponder()
            if touches.first?.tapCount == 1 && self.controller != nil {
                self.displayDropdownList()
            }
        }
    }
    
    
    func dropdownListController(pDropdownListController:IADropdownListController, didSelectValue pValue:String) {
        if pDropdownListController.isEqual(self.dropdownListController) {
            self.text = pValue
            self.dropdownListController.dismissViewControllerAnimated(true, completion: nil)
            self.delegate?.textFieldDidEndEditing!(self)
        }
    }
    
    
    func displayDropdownList() {
        if self.dropdownListController == nil {
            self.dropdownListController  = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("IADropdownListControllerID") as! IADropdownListController
        }
        self.dropdownListController.delegate = self
        self.dropdownListController.shouldDisplayAsDatePicker = self.shouldDisplayAsDatePicker
        self.dropdownListController.list = self.list
        if self.list != nil {
            var aHeight :CGFloat = CGFloat(self.list.count) * 36.0
            if aHeight > 300.0 {
                aHeight = 300.0
            }
            self.dropdownListController.preferredContentSize = CGSizeMake(320.0, aHeight)
        } else {
            self.dropdownListController.preferredContentSize = CGSizeMake(320.0, 200.0)
        }
        self.dropdownListController.modalPresentationStyle = .Popover
        self.dropdownListController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.Any
        self.dropdownListController.popoverPresentationController?.sourceView = self
        self.dropdownListController.popoverPresentationController?.sourceRect = self.bounds
        self.controller.presentViewController(self.dropdownListController, animated: true, completion: nil)
    }
}
