//
//  IAAutoInsuranceDetailsController.swift
//  InsuranceApp
//

import UIKit
import ATKit


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
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        coverageBoxView.backgroundColor = UIColor(patternImage: UIImage(named: "bigBox")!.scaledImage(size: coverageBoxView.frame.size, scaleMode: UIImageScaleMode.resize))
        limitBoxView.backgroundColor = UIColor(patternImage: UIImage(named: "bigBox")!.scaledImage(size: limitBoxView.frame.size, scaleMode: UIImageScaleMode.resize))
        deductibleBoxView.backgroundColor = UIColor(patternImage: UIImage(named: "bigBox")!.scaledImage(size: deductibleBoxView.frame.size, scaleMode: UIImageScaleMode.resize))
        
        self.reloadAllData()
    }
    
    
    func updateUI(){
        self.mainBGView.layer.cornerRadius = 10.0
        self.mainBGView.layer.masksToBounds = true

        dateView.backgroundColor = UIColor(patternImage: UIImage(named: "dateBg")!)
        
        vehicleCollectionView.backgroundColor = UIColor.clear
        driverCollectionView.backgroundColor = UIColor.clear
        
        //coverageBoxView.backgroundColor = UIColor(patternImage: UIImage(named: "bigBox")!)
        //limitBoxView.backgroundColor = UIColor(patternImage: UIImage(named: "bigBox")!)
        //deductibleBoxView.backgroundColor = UIColor(patternImage: UIImage(named: "bigBox")!)
        
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
        self.performSegue(withIdentifier: "AutoInsuranceDetailsToAddVehicleSegueID", sender: self)
    }
    
    
    /**
     * Selector method that will be called when Add Driver button is tapped.
     * @return Void
     */
    @IBAction func didSelectAddDriverButton() {
        self.performSegue(withIdentifier: "AutoInsuranceDetailsToAddDriverSegueID", sender: self)
    }
    
    @IBAction func didSelectVechicleNext(_ sender: AnyObject) {
        let visibleItems: NSArray = self.vehicleCollectionView.indexPathsForVisibleItems as NSArray
        let currentItem: IndexPath = visibleItems.object(at: 0) as! IndexPath
        let nextItem: IndexPath = IndexPath(row: currentItem.item + 1, section: 0)
        self.vehicleCollectionView.scrollToItem(at: nextItem, at: .left, animated: true)
    }
    
    
    @IBAction func didSelectVehiclePrevious(_ sender: AnyObject) {
        let visibleItems: NSArray = self.vehicleCollectionView.indexPathsForVisibleItems as NSArray
        let currentItem: IndexPath = visibleItems.object(at: 0) as! IndexPath
        let nextItem: IndexPath = IndexPath(row: currentItem.item + 1, section: 0)
        self.vehicleCollectionView.scrollToItem(at: nextItem, at: .right, animated: true)
    }
    
    
    @IBAction func didSelectDriverNext(_ sender: AnyObject) {
        let visibleItems: NSArray = self.driverCollectionView.indexPathsForVisibleItems as NSArray
        let currentItem: IndexPath = visibleItems.object(at: 0) as! IndexPath
        let nextItem: IndexPath = IndexPath(row: currentItem.item + 1, section: 0)
        self.driverCollectionView.scrollToItem(at: nextItem, at: .left, animated: true)
    }
    
    @IBAction func didSelectDriverPrevious(_ sender: AnyObject) {
        let visibleItems: NSArray = self.driverCollectionView.indexPathsForVisibleItems as NSArray
        let currentItem: IndexPath = visibleItems.object(at: 0) as! IndexPath
        let nextItem: IndexPath = IndexPath(row: currentItem.item + 1, section: 0)
        self.driverCollectionView.scrollToItem(at: nextItem, at: .right, animated: true)
    }
    
    
    @IBAction func didSelectPayPremiumButton(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "AutoInsuranceDetailsToPayPremiumSegueID", sender: self)
    }
    
    
    @IBAction func didSelectFileClaimButton(_ sender: AnyObject) {
        IAConstants.homeController.didSelectFileClaimTabItemView()
    }
    
    
    @IBAction func didSelectViewPolicyButton(_ sender: AnyObject) {
        IAConstants.homeController.didSelectPoliciesTabItemView()
    }
    
    
    // MARK: - IADataManagerDelegate Methods
    
    /**
     * IADataManagerDelegate method. It is implemented to handle response sent by IADataManager.
     */
    internal override func aiDataManagerDidSucceed(sender pSender:IADataManager, response pResponse: IADataManagerResponse) {
        IAAppDelegate.currentAppDelegate.hideLoadingOverlay()
        
        if pResponse.error != nil {
            self.displayMessage(message: pResponse.error.localizedDescription, type: IAMessageType.error)
        } else if pSender.requestType == IARequestType.listVehicles {
            if pResponse.result != nil {
                self.vehicleArray = pResponse.result as! Array
            } else {
                self.vehicleArray = nil
            }
            self.reloadAllView()
            
            IAAppDelegate.currentAppDelegate.displayLoadingOverlay()
            self.dataManager.listDrivers()
        } else if pSender.requestType == IARequestType.listDrivers {
            if pResponse.result != nil {
                self.driverArray = pResponse.result as! Array
            } else {
                self.driverArray = nil
            }
            self.reloadAllView()
            IAAppDelegate.currentAppDelegate.displayLoadingOverlay()
            self.dataManager.dashboardDetails()
        } else if pSender.requestType == IARequestType.dashboardDetails {
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
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.vehicleCollectionView {
            // get a reference to our storyboard cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "vehicleListCell", for: indexPath) as! IAVehicleListCell
            
            let aVehicle = self.vehicleArray[indexPath.item]
            
            cell.vehicleImageView.image = aVehicle.photoOne
            
            // Use the outlet in our custom class to get a reference to the UILabel in the cell
            cell.modelNoLabel.text = aVehicle.title
            return cell
        }else  {
            // get a reference to our storyboard cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "driverListCell", for: indexPath) as! IADriverListCell
            
            let aDriver = self.driverArray[indexPath.item]
            
            cell.driverImage.image = aDriver.avatar
            cell.driverImage.layer.masksToBounds = true
            
            // Use the outlet in our custom class to get a reference to the UILabel in the cell
            cell.driverNameLabel.text = aDriver.fullName
            return cell
        }
        
        
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        if collectionView == self.vehicleCollectionView {
            /**
             * Delegate method that will be called when Vehicle is tapped.
             */
            self.selectedListIndex = indexPath.item
            self.performSegue(withIdentifier: "AutoInsuranceDetailsToVehicleDetailsSegueID", sender: self)
            
        } else if collectionView.isEqual(self.driverCollectionView) {
            self.selectedListIndex = indexPath.item
            self.performSegue(withIdentifier: "AutoInsuranceDetailsToDriverDetailsSegueID", sender: self)
        }
    }
    
    
    /**
     * Method that will be called while performing segue and will handle setting required data for next controller.
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AutoInsuranceDetailsToVehicleDetailsSegueID" {
            let aVehicle = self.vehicleArray[self.selectedListIndex]
            self.selectedListIndex = nil
            
            (segue.destination as! IAVehicleDetailsController).vehicle = aVehicle
        } else if segue.identifier == "AutoInsuranceDetailsToDriverDetailsSegueID" {
            let aDriver = self.driverArray[self.selectedListIndex]
            self.selectedListIndex = nil
            
            (segue.destination as! IADriverDetailsController).driver = aDriver
        }
    }
    
}
