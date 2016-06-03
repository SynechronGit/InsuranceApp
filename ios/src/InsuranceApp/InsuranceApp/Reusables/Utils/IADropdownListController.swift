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
        aReturnVal.textLabel?.font = UIFont(name: "Ubuntu-Regular", size: 13.0)
        
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
