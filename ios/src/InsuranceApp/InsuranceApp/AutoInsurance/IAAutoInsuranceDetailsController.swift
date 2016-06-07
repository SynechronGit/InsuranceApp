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
    @IBOutlet weak var driverCollectionView: UICollectionView!
    var vehicleArray :Array<IAVehicle>!
    var driverArray :Array<IADriver>!
    var selectedListIndex :Int!
    
    @IBOutlet weak var mainBGView: UIView!
    @IBOutlet weak var payPremiumBtn: UIButton!
    @IBOutlet weak var fileClaimBtn: UIButton!
    @IBOutlet weak var viewPolicyBtn: UIButton!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var coverageBoxView: UIView!
    @IBOutlet weak var limitBoxView: UIView!
    @IBOutlet weak var deductibleBoxView: UIView!
  
    @IBOutlet weak var vehicleCountLabel: UILabel!
    @IBOutlet weak var driverCountLabel: UILabel!
    
    var dashboardDetails: IADashboard!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Auto Insurance"
        
        self.updateUI()
        
        self.vehicleCollectionView.delegate = self
        self.vehicleCollectionView.dataSource = self
        self.driverCollectionView.delegate = self
        self.driverCollectionView.dataSource = self
        
        

    }
    
    
    override func viewDidAppear(animated: Bool) {
        self.reloadAllData()
    }
    
    
    func updateUI(){
        self.mainBGView.layer.cornerRadius = 10.0
        self.mainBGView.layer.masksToBounds = true

        dateView.backgroundColor = UIColor(patternImage: UIImage(named: "dateBg")!)
        
        vehicleCollectionView.backgroundColor = UIColor.clearColor()
        driverCollectionView.backgroundColor = UIColor.clearColor()
        
        coverageBoxView.backgroundColor = UIColor(patternImage: UIImage(named: "bigBox")!)
        limitBoxView.backgroundColor = UIColor(patternImage: UIImage(named: "bigBox")!)
        deductibleBoxView.backgroundColor = UIColor(patternImage: UIImage(named: "bigBox")!)
        
        self.vehicleCountLabel.text = "Vehicles"
        self.driverCountLabel.text = "Drivers"
    }

    func reloadAllData() {
        IAAppDelegate.currentAppDelegate.displayLoadingOverlay()
        self.dataManager.listVehicles()
    }
    
    
    func reloadAllView() {
        self.vehicleCollectionView.reloadData()
        self.driverCollectionView.reloadData()
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
    
    @IBAction func didSelectVechicleNext(sender: AnyObject) {
        let visibleItems: NSArray = self.vehicleCollectionView.indexPathsForVisibleItems()
        let currentItem: NSIndexPath = visibleItems.objectAtIndex(0) as! NSIndexPath
        let nextItem: NSIndexPath = NSIndexPath(forRow: currentItem.item + 1, inSection: 0)
        self.vehicleCollectionView.scrollToItemAtIndexPath(nextItem, atScrollPosition: .Left, animated: true)
    }
    
    
    @IBAction func didSelectVehiclePrevious(sender: AnyObject) {
        let visibleItems: NSArray = self.vehicleCollectionView.indexPathsForVisibleItems()
        let currentItem: NSIndexPath = visibleItems.objectAtIndex(0) as! NSIndexPath
        let nextItem: NSIndexPath = NSIndexPath(forRow: currentItem.item + 1, inSection: 0)
        self.vehicleCollectionView.scrollToItemAtIndexPath(nextItem, atScrollPosition: .Right, animated: true)
    }
    
    
    @IBAction func didSelectDriverNext(sender: AnyObject) {
        let visibleItems: NSArray = self.driverCollectionView.indexPathsForVisibleItems()
        let currentItem: NSIndexPath = visibleItems.objectAtIndex(0) as! NSIndexPath
        let nextItem: NSIndexPath = NSIndexPath(forRow: currentItem.item + 1, inSection: 0)
        self.driverCollectionView.scrollToItemAtIndexPath(nextItem, atScrollPosition: .Left, animated: true)
    }
    
    @IBAction func didSelectDriverPrevious(sender: AnyObject) {
        let visibleItems: NSArray = self.driverCollectionView.indexPathsForVisibleItems()
        let currentItem: NSIndexPath = visibleItems.objectAtIndex(0) as! NSIndexPath
        let nextItem: NSIndexPath = NSIndexPath(forRow: currentItem.item + 1, inSection: 0)
        self.driverCollectionView.scrollToItemAtIndexPath(nextItem, atScrollPosition: .Right, animated: true)
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
            IAAppDelegate.currentAppDelegate.displayLoadingOverlay()
            self.dataManager.dashboardDetails()
        } else if pSender.requestType == IARequestType.DashboardDetails {
            if pResponse.result != nil {
                self.dashboardDetails = pResponse.result as! IADashboard
                self.vehicleCountLabel.text = "Vehicles (\(NSString(format: "%02d", self.dashboardDetails.autoInsuranceCarCount)))"
                self.driverCountLabel.text = "Drivers (\(NSString(format: "%02d", self.dashboardDetails.autoInsuranceDriverCount)))"
            } else {
                self.dashboardDetails = nil
            }
            self.reloadAllView()
        }
    }
    
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
     func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count:Int?
        
        if collectionView == self.vehicleCollectionView {
            if(self.vehicleArray == nil){
                count = 0
            }else{
                count = self.vehicleArray.count
            }
            
        }else if collectionView == self.driverCollectionView {
            if(self.driverArray == nil){
                count = 0
            }else{
                count = self.driverArray.count
            }
        } 
        
        return count!
        
    }
    
    // make a cell for each cell index path
     func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if collectionView == self.vehicleCollectionView {
            // get a reference to our storyboard cell
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("vehicleListCell", forIndexPath: indexPath) as! IAVehicleListCell
            
            let aVehicle = self.vehicleArray[indexPath.item]
            
            cell.vehicleImageView.image = aVehicle.photoOne
            
            // Use the outlet in our custom class to get a reference to the UILabel in the cell
            cell.modelNoLabel.text = aVehicle.title
            return cell
        }else  {
            // get a reference to our storyboard cell
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("driverListCell", forIndexPath: indexPath) as! IADriverListCell
            
            let aDriver = self.driverArray[indexPath.item]
            
            cell.driverImage.image = aDriver.avatar
            
            // Use the outlet in our custom class to get a reference to the UILabel in the cell
            cell.driverNameLabel.text = aDriver.fullName
            return cell
        }
        
        
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
     func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // handle tap events
        if collectionView == self.vehicleCollectionView {
            /**
             * Delegate method that will be called when Vehicle is tapped.
             */
            self.selectedListIndex = indexPath.item
            self.performSegueWithIdentifier("AutoInsuranceDetailsToVehicleDetailsSegueID", sender: self)
            
        } else if collectionView.isEqual(self.driverCollectionView) {
            self.selectedListIndex = indexPath.item
            self.performSegueWithIdentifier("AutoInsuranceDetailsToDriverDetailsSegueID", sender: self)
        }
    }
    
    
    /**
     * Method that will be called while performing segue and will handle setting required data for next controller.
     */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AutoInsuranceDetailsToVehicleDetailsSegueID" {
            let aVehicle = self.vehicleArray[self.selectedListIndex]
            self.selectedListIndex = nil
            
            (segue.destinationViewController as! IAVehicleDetailsController).vehicle = aVehicle
        } else if segue.identifier == "AutoInsuranceDetailsToDriverDetailsSegueID" {
            let aDriver = self.driverArray[self.selectedListIndex]
            self.selectedListIndex = nil
            
            (segue.destinationViewController as! IADriverDetailsController).driver = aDriver
        }
    }
    
}
