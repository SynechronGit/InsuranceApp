//
//  IADropdownListController.swift
//  InsuranceApp
//
//  Created by rupendra on 6/3/16.
//  Copyright © 2016 com. All rights reserved.
//

import UIKit


protocol IADropdownListControllerDelegate : class {
    func dropdownListController(_ pDropdownListController:IADropdownListController, didSelectValue pValue:String)
}


class IADropdownListController: UIViewController {
    @IBOutlet weak var dropdownTable :UITableView!
    @IBOutlet weak var datePicker :UIDatePicker!
    var minimumDate :Date!
    var maximumDate :Date!
    var date :Date!
    @IBOutlet weak var doneButton :UIButton!
    weak var delegate:IADropdownListControllerDelegate?
    
    @IBOutlet weak var dropdownTableTopConstraint :NSLayoutConstraint!
    @IBOutlet weak var dropdownTableBottomConstraint :NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UIDevice.current.isIphone {
            self.dropdownTableTopConstraint.constant = 20.0
            self.dropdownTableBottomConstraint.constant = 20.0
        } else {
            self.dropdownTableTopConstraint.constant = 0.0
            self.dropdownTableBottomConstraint.constant = 0.0
        }
    }
    
    
    fileprivate var _list :Array<String>!
    var list :Array<String>! {
        set {
            _list = newValue
            if self.dropdownTable != nil {
                self.dropdownTable.reloadData()
            }
        }
        get {
            return _list
        }
    }
    
    
    fileprivate var _shouldDisplayAsDatePicker :Bool!
    var shouldDisplayAsDatePicker :Bool! {
        set {
            _shouldDisplayAsDatePicker = newValue
        }
        get {
            return _shouldDisplayAsDatePicker
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        if self.shouldDisplayAsDatePicker != nil && self.shouldDisplayAsDatePicker == true {
            if self.datePicker != nil {
                self.datePicker.isHidden = false
                self.datePicker.minimumDate = self.minimumDate
                self.datePicker.maximumDate = self.maximumDate
                if self.date != nil {
                    self.datePicker.date = self.date
                } else {
                    self.datePicker.date = Date()
                }
            }
            if self.doneButton != nil {
                self.doneButton.isHidden = false
            }
            if self.dropdownTable != nil {
                self.dropdownTable.isHidden = true
            }
        } else {
            if self.datePicker != nil {
                self.datePicker.isHidden = true
            }
            if self.doneButton != nil {
                self.doneButton.isHidden = true
            }
            if self.dropdownTable != nil {
                self.dropdownTable.isHidden = false
            }
        }
    }
    
    
    @IBAction func didSelectDoneButton() {
        if self.delegate != nil {
            let aDateFormatter = DateFormatter()
            aDateFormatter.locale = Locale(identifier: "US_en")
            aDateFormatter.dateFormat = IAConstants.dateFormatAppStandard
            self.delegate?.dropdownListController(self, didSelectValue: aDateFormatter.string(from: self.datePicker.date))
        }
    }
    
    
    // MARK: - UITableView Methods
    
    /**
     * Method that will calculate and return number of rows in given section of table.
     * @return Int. Number of rows in given section
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var aReturnVal :Int = 0
        
        if self.list != nil {
            aReturnVal = self.list.count
        }
        
        return aReturnVal
    }
    
    
    /**
     * Method that will init, set and return the cell view.
     * @return UITableViewCell. View of the cell in given table view.
     */
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        let aReturnVal:UITableViewCell = UITableViewCell()
        aReturnVal.backgroundColor = UIColor.clear
        aReturnVal.textLabel?.font = UIFont(name: "Ubuntu", size: 13.0)
        aReturnVal.textLabel?.textAlignment = NSTextAlignment.center
        
        if self.list != nil {
            aReturnVal.textLabel?.text = self.list[indexPath.row]
        }
        
        return aReturnVal
    }
    
    
    /**
     * Method that will handle tap on table cell.
     */
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if self.delegate != nil {
            self.delegate?.dropdownListController(self, didSelectValue: self.list[indexPath.row])
        }
    }
}
