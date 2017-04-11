//
//  IATextField.swift
//  InsuranceApp
//
//  Created by rupendra on 6/3/16.
//  Copyright © 2016 com. All rights reserved.
//

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}



protocol IATextFieldDelegate : class {
    func iaTextFieldDidSelectValue(_ pTextField:IATextField)
}


class IATextField: UITextField, IADropdownListControllerDelegate {
    var shouldDisplayAsDropdown :Bool!
    var shouldDisplayAsDatePicker :Bool!
    var minimumDate :Date!
    var maximumDate :Date!
    weak var controller :UIViewController!
    weak var iaTextFieldDelegate :AnyObject!
    var dropdownListController :IADropdownListController!
    var list :Array<String>!
    
    
    fileprivate var bottomBorderLayer :CALayer!
    
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
            self.bottomBorderLayer.frame = CGRect(x: 0.0, y: self.bounds.size.height - 2, width: self.bounds.size.width, height: 2.0)
            self.bottomBorderLayer.backgroundColor = UIColor.lightGray.cgColor
            self.layer.addSublayer(self.bottomBorderLayer)
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if self.bottomBorderLayer != nil {
            self.bottomBorderLayer.frame = CGRect(x: 0.0, y: self.bounds.size.height + 3, width: self.bounds.size.width, height: 2.0)
        }
        if ((self.shouldDisplayAsDropdown != nil && self.shouldDisplayAsDropdown == true) || (self.shouldDisplayAsDropdown != nil && self.shouldDisplayAsDropdown == true)) && self.rightView == nil {
            self.rightView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: 13.0, height: 13.0))
            (self.rightView as! UIImageView).image = UIImage(named: "DropdownArrow")
            (self.rightView as! UIImageView).contentMode = UIViewContentMode.scaleAspectFit
            self.rightViewMode = UITextFieldViewMode.always
        }
    }
    
    
    override func becomeFirstResponder() -> Bool {
        let aReturnVal :Bool = super.becomeFirstResponder()
        
        if (self.shouldDisplayAsDropdown != nil && self.shouldDisplayAsDropdown == true) || (self.shouldDisplayAsDatePicker != nil && self.shouldDisplayAsDatePicker == true) {
            self.endEditing(true)
            if self.controller != nil {
                self.displayDropdownList()
            }
        }
        
        return aReturnVal
    }
    
    
    func dropdownListController(_ pDropdownListController:IADropdownListController, didSelectValue pValue:String) {
        if pDropdownListController.isEqual(self.dropdownListController) {
            self.text = pValue
            self.dropdownListController.dismiss(animated: true, completion: nil)
            self.delegate?.textFieldDidEndEditing!(self)
        }
    }
    
    
    func displayDropdownList() {
        if (self.list != nil && self.list.count > 0) || (self.shouldDisplayAsDatePicker != nil && self.shouldDisplayAsDatePicker == true) {
            if self.dropdownListController == nil {
                self.dropdownListController  = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "IADropdownListControllerID") as! IADropdownListController
            }
            self.dropdownListController.delegate = self
            self.dropdownListController.shouldDisplayAsDatePicker = self.shouldDisplayAsDatePicker
            self.dropdownListController.minimumDate = self.minimumDate
            self.dropdownListController.maximumDate = self.maximumDate
            if self.text?.lengthOfBytes(using: String.Encoding.utf8) > 0 {
                self.dropdownListController.date = Date.dateFromString(self.text!, format: IAConstants.dateFormatAppStandard)
            } else {
                self.dropdownListController.date = nil
            }
            self.dropdownListController.list = self.list
            if self.list != nil {
                var aHeight :CGFloat = CGFloat(self.list.count) * 36.0
                if aHeight > 300.0 {
                    aHeight = 300.0
                }
                self.dropdownListController.preferredContentSize = CGSize(width: 320.0, height: aHeight)
            } else {
                self.dropdownListController.preferredContentSize = CGSize(width: 320.0, height: 200.0)
            }
            self.dropdownListController.modalPresentationStyle = .popover
            self.dropdownListController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.any
            self.dropdownListController.popoverPresentationController?.sourceView = self
            self.dropdownListController.popoverPresentationController?.sourceRect = self.bounds
            self.controller.present(self.dropdownListController, animated: true, completion: nil)
        }
    }
}
