//
//  IAVehicleDetailsController.swift
//  InsuranceApp
//
//  Created by nikhil bahalkar on 02/06/16.
//  Copyright © 2016 com. All rights reserved.
//

import UIKit

class IAVehicleDetailsController: IABaseController ,UICollectionViewDelegate, UICollectionViewDataSource{
    var vehicle: IAVehicle!
    
    @IBOutlet weak var mainBgView: UIView!
    @IBOutlet weak var vinNoBgView: UIView!
    @IBOutlet weak var comprehensiveCoverageBgView: UIView!
    @IBOutlet weak var collisionCoverageBgView: UIView!
    
    @IBOutlet weak var vehicleNameHeadingLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var modelNoLabel: UILabel!
    @IBOutlet weak var bodyStyleLabel: UILabel!
    
    @IBOutlet weak var vinNoLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var vehicleListCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.vehicleListCollectionView.backgroundColor = UIColor.clearColor()
        
        self.mainBgView.layer.cornerRadius = 10.0
        self.mainBgView.layer.masksToBounds = true
        
        self.vinNoBgView.layer.cornerRadius = IAConstants.dashboardSubviewCornerRadius
        self.vinNoBgView.layer.masksToBounds = true
        
        self.comprehensiveCoverageBgView.layer.cornerRadius = 10.0
        self.comprehensiveCoverageBgView.layer.masksToBounds = true
        
        self.collisionCoverageBgView.layer.cornerRadius = 10.0
        self.collisionCoverageBgView.layer.masksToBounds = true
        
        self.vehicleListCollectionView.delegate = self
        self.vehicleListCollectionView.dataSource = self
        
        self.reloadAllData()
    }
    
    
    func reloadAllData() {
        self.reloadAllView()
    }
    
    
    func reloadAllView() {
        self.vehicleNameHeadingLabel.text = self.vehicle.title
        self.yearLabel.text = self.vehicle.year
        self.companyLabel.text = self.vehicle.company
        self.modelNoLabel.text = self.vehicle.modelNumber
        self.bodyStyleLabel.text = self.vehicle.bodyStyle
        
        self.vinNoLabel.text = self.vehicle.vin
        self.descriptionTextView.text = self.vehicle.vehicleDescription
        
        self.vehicleListCollectionView.reloadData()
    }
    
    
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 1
        
    }
    
    // make a cell for each cell index path
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
            // get a reference to our storyboard cell
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("vehicleListCell", forIndexPath: indexPath) as! IAVehicleListCell
            
            //let aVehicle = self.vehicleData[indexPath.item]
        
            return cell
    }
    
    
}