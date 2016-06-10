//
//  IADropdownListController.swift
//  InsuranceApp
//
//  Created by rupendra on 6/3/16.
//  Copyright © 2016 com. All rights reserved.
//

import UIKit


protocol IADropdownListControllerDelegate : class {
    func dropdownListController(pDropdownListController:IADropdownListController, didSelectValue pValue:String)
}


class IADropdownListController: UIViewController {
    @IBOutlet weak var dropdownTable :UITableView!
    @IBOutlet weak var datePicker :UIDatePicker!
    @IBOutlet weak var doneButton :UIButton!
    weak var delegate:IADropdownListControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    private var _list :Array<String>!
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
    
    
    private var _shouldDisplayAsDatePicker :Bool!
    var shouldDisplayAsDatePicker :Bool! {
        set {
            _shouldDisplayAsDatePicker = newValue
        }
        get {
            return _shouldDisplayAsDatePicker
        }
    }
    
    
    override func viewDidAppear(animated: Bool) {
        if self.shouldDisplayAsDatePicker != nil && self.shouldDisplayAsDatePicker == true {
            if self.datePicker != nil {
                self.datePicker.hidden = false
            }
            if self.doneButton != nil {
                self.doneButton.hidden = false
            }
            if self.dropdownTable != nil {
                self.dropdownTable.hidden = true
            }
        } else {
            if self.datePicker != nil {
                self.datePicker.hidden = true
            }
            if self.doneButton != nil {
                self.doneButton.hidden = true
            }
            if self.dropdownTable != nil {
                self.dropdownTable.hidden = false
            }
        }
    }
    
    
    @IBAction func didSelectDoneButton() {
        if self.delegate != nil {
            let aDateFormatter = NSDateFormatter()
            aDateFormatter.locale = NSLocale(localeIdentifier: "US_en")
            aDateFormatter.dateFormat = "MM-dd-yyyy"
            self.delegate?.dropdownListController(self, didSelectValue: aDateFormatter.stringFromDate(self.datePicker.date))
        }
    }
    
    
    // MARK: - UITableView Methods
    
    /**
     * Method that will calculate and return number of rows in given section of table.
     * @return Int. Number of rows in given section
     */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let aReturnVal:UITableViewCell = UITableViewCell()
        aReturnVal.backgroundColor = UIColor.clearColor()
        aReturnVal.textLabel?.font = UIFont(name: "Ubuntu", size: 13.0)
        aReturnVal.textLabel?.textAlignment = NSTextAlignment.Center
        
        if self.list != nil {
            aReturnVal.textLabel?.text = self.list[indexPath.row]
        }
        
        return aReturnVal
    }
    
    
    /**
     * Method that will handle tap on table cell.
     */
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if self.delegate != nil {
            self.delegate?.dropdownListController(self, didSelectValue: self.list[indexPath.row])
        }
    }
}
