//
//  IAAutoInsuranceDetailsController.swift
//  InsuranceApp
//

import UIKit


/**
 * Controller for Auto Insurance Details screen.
 */
class IAAutoInsuranceDetailsController: IABaseController , UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var vehicleCollectionView: UICollectionView!
    var vehicleArray :Array<IAVehicle>!
    var driverArray :Array<IADriver>!
    
    @IBOutlet weak var driverCollectionView: UICollectionView!
    @IBOutlet weak var payPremiumBtn: UIButton!
    @IBOutlet weak var fileClaimBtn: UIButton!
    @IBOutlet weak var viewPolicyBtn: UIButton!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var coverageBoxView: UIView!
    @IBOutlet weak var limitBoxView: UIView!
    @IBOutlet weak var deductibleBoxView: UIView!
    
     var items = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vehicleCollectionView.delegate = self
        self.vehicleCollectionView.dataSource = self
        self.driverCollectionView.delegate = self
        self.driverCollectionView.dataSource = self
        
        self.updateUI()
    
        self.reloadAllData()

    }
    
    func updateUI(){
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "mainBG.png")!)
        dateView.backgroundColor = UIColor(patternImage: UIImage(named: "dateBg")!)
        
        coverageBoxView.backgroundColor = UIColor(patternImage: UIImage(named: "bigBox")!)
        limitBoxView.backgroundColor = UIColor(patternImage: UIImage(named: "bigBox")!)
        deductibleBoxView.backgroundColor = UIColor(patternImage: UIImage(named: "bigBox")!)
    }

    func reloadAllData() {
        IAAppDelegate.currentAppDelegate.displayLoadingOverlay()
        self.dataManager.listVehicles()
    }
    
    
    func reloadAllView() {
        if self.vehicleArray != nil {
            for aVehicle in self.vehicleArray {
                NSLog("licensePlateNumber: %@, state: %@", aVehicle.licensePlateNumber, aVehicle.state)
            }
        }
        
        if self.driverArray != nil {
            for aDriver in self.driverArray {
                NSLog("firstName: %@, lastName: %@", aDriver.firstName, aDriver.lastName)
            }
        }
    }
    
    
    // MARK: - Selector Methods
    
    /**
     * Selector method that will be called when Add Vehicle button is tapped.
     * @return Void
     */
    @IBAction func didSelectAddVehicleButton() {
        self.performSegueWithIdentifier("AutoInsuranceDetailsToAddVehicleSegueID", sender: self)
    }
    
    
    /**
     * Selector method that will be called when Add Driver button is tapped.
     * @return Void
     */
    @IBAction func didSelectAddDriverButton() {
        self.performSegueWithIdentifier("AutoInsuranceDetailsToAddDriverSegueID", sender: self)
    }
    
    
    // MARK: - IADataManagerDelegate Methods
    
    /**
     * IADataManagerDelegate method. It is implemented to handle response sent by IADataManager.
     */
    internal override func aiDataManagerDidSucceed(sender pSender:IADataManager, response pResponse: IADataManagerResponse) {
        IAAppDelegate.currentAppDelegate.hideLoadingOverlay()
        
        if pResponse.error != nil {
            self.displayMessage(message: pResponse.error.localizedDescription, type: IAMessageType.Error)
        } else if pSender.requestType == IARequestType.ListVehicles {
            if pResponse.result != nil {
                self.vehicleArray = pResponse.result as! Array
            } else {
                self.vehicleArray = nil
            }
            self.reloadAllView()
            
            IAAppDelegate.currentAppDelegate.displayLoadingOverlay()
            self.dataManager.listDrivers()
        } else if pSender.requestType == IARequestType.ListDrivers {
            if pResponse.result != nil {
                self.driverArray = pResponse.result as! Array
            } else {
                self.driverArray = nil
            }
            self.reloadAllView()
        }
    }
    
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
     func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count:Int?
        
        if collectionView == self.vehicleCollectionView {
            count = self.items.count
        }else if collectionView == self.driverCollectionView {
            count = self.items.count
        }
        
        return count!
        
    }
    
    // make a cell for each cell index path
     func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if collectionView == self.vehicleCollectionView {
            // get a reference to our storyboard cell
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("vehicleListCell", forIndexPath: indexPath) as! IAVehicleListCell
            
            // Use the outlet in our custom class to get a reference to the UILabel in the cell
            cell.modelNoLabel.text = self.items[indexPath.item]
            return cell
        }else  {
            // get a reference to our storyboard cell
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("driverListCell", forIndexPath: indexPath) as! IADriverListCell
            
            // Use the outlet in our custom class to get a reference to the UILabel in the cell
            cell.driverNameLabel.text = self.items[indexPath.item]
            return cell
        }
        
        
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
     func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }

}
