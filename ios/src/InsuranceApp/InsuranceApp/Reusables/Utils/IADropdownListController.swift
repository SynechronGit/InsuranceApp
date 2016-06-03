//
//  IADropdownListController.swift
//  InsuranceApp
//
//  Created by rupendra on 6/3/16.
//  Copyright © 2016 com. All rights reserved.
//

import UIKit

class IADropdownListController: UIViewController {
    @IBOutlet weak var dropdownTable :UITableView!
    var list :Array<String>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
}
