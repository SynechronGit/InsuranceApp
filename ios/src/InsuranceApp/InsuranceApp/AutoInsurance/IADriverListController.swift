//
//  IADriverListController.swift
//  InsuranceApp
//
//  Created by nikhil bahalkar on 31/05/16.
//  Copyright © 2016 com. All rights reserved.
//

import UIKit

class IADriverListController: UICollectionViewController{
    
    let reuseIdentifier = "driverListCell" // also enter this string as the cell identifier in the storyboard
    var items = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    
    override func viewDidLoad() {
        self.collectionView?.backgroundColor  = UIColor.clearColor()
    }
    
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //  print(item)
        return self.items.count
    }
    
    // make a cell for each cell index path
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! IADriverListCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        cell.driverNameLabel.text = self.items[indexPath.item]
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }
    
    
}