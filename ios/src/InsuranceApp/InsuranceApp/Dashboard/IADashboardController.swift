//
//  IADashboardController.swift
//  InsuranceApp
//

import UIKit


/**
 * Controller for Dashboard screen.
 */
class IADashboardController: IABaseController {
    @IBOutlet var autoInsuranceContainerView: InsuranceTypeContainerView!
    @IBOutlet var homeInsuranceContainerView: InsuranceTypeContainerView!
    @IBOutlet var boatInsuranceContainerView: InsuranceTypeContainerView!
    @IBOutlet var petInsuranceContainerView: InsuranceTypeContainerView!
    
    @IBOutlet var myClaimCountLabel: IALabel!
    @IBOutlet var payPremiumCountLabel: IALabel!
    
    @IBOutlet var myClaimsContainerView: UIView!
    @IBOutlet var payPremiumContainerView: UIView!
    
    @IBOutlet var roadsideAssistanceContainerView: UIView!
    @IBOutlet var insuranceIDCardContainerView: UIView!
    
    var dashboardDetails: IADashboard!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let aTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(IADashboardController.didSelectAutoInsuranceView))
        aTapGestureRecognizer.cancelsTouchesInView = false
        self.autoInsuranceContainerView.addGestureRecognizer(aTapGestureRecognizer)
        
        self.myClaimsContainerView.layer.cornerRadius = IAConstants.dashboardSubviewCornerRadius
        self.myClaimsContainerView.layer.masksToBounds = true
        
        self.payPremiumContainerView.layer.cornerRadius = IAConstants.dashboardSubviewCornerRadius
        self.payPremiumContainerView.layer.masksToBounds = true
        
        self.roadsideAssistanceContainerView.layer.cornerRadius = IAConstants.dashboardSubviewCornerRadius
        self.roadsideAssistanceContainerView.layer.masksToBounds = true
        
        self.insuranceIDCardContainerView.layer.cornerRadius = IAConstants.dashboardSubviewCornerRadius
        self.insuranceIDCardContainerView.layer.masksToBounds = true
        
        self.reloadAllData()
    }
    
    func reloadAllData() {
        IAAppDelegate.currentAppDelegate.displayLoadingOverlay()
        self.dataManager.dashboardDetails()
    }
    
    
    func reloadAllView() {
        self.autoInsuranceContainerView.firstCounterLabel.animatedText = String(format: "%02d", self.dashboardDetails.autoInsuranceCarCount)
        self.autoInsuranceContainerView.secondCounterLabel.animatedText = String(format: "%02d", self.dashboardDetails.autoInsuranceDriverCount)
        
        self.homeInsuranceContainerView.firstCounterLabel.animatedText = String(format: "%02d", self.dashboardDetails.homeInsuranceApplianceCount)
        self.homeInsuranceContainerView.secondCounterLabel.animatedText = String(format: "%02d", self.dashboardDetails.homeInsuranceFurnitureCount)
        self.homeInsuranceContainerView.thirdCounterLabel.animatedText = String(format: "%02d", self.dashboardDetails.homeInsuranceCurtainCount)
        self.homeInsuranceContainerView.fourthCounterLabel.animatedText = String(format: "%02d", self.dashboardDetails.homeInsuranceCrockeryCount)
        
        self.boatInsuranceContainerView.firstCounterLabel.animatedText = String(format: "%02d", self.dashboardDetails.boatInsuranceYatchCount)
        self.boatInsuranceContainerView.secondCounterLabel.animatedText = String(format: "%02d", self.dashboardDetails.boatInsuranceSkipperCount)
        self.boatInsuranceContainerView.thirdCounterLabel.animatedText = String(format: "%02d", self.dashboardDetails.boatInsuranceEquipmentCount)
        self.boatInsuranceContainerView.fourthCounterLabel.animatedText = String(format: "%02d", self.dashboardDetails.boatInsuranceLossCount)
        
        self.petInsuranceContainerView.firstCounterLabel.animatedText = String(format: "%02d", self.dashboardDetails.petInsuranceDogCount)
        self.petInsuranceContainerView.secondCounterLabel.animatedText = String(format: "%02d", self.dashboardDetails.petInsuranceCatCount)
        
        self.myClaimCountLabel.animatedText = String(format: "%02d", self.dashboardDetails.claimCount)
        self.payPremiumCountLabel.animatedText = String(format: "%02d", self.dashboardDetails.premiumCount)
    }
    
    
    // MARK: - Selector Methods
    
    /**
     * Selector method that will be called when Auto Insurance view is tapped.
     * @return Void
     */
    @IBAction func didSelectAutoInsuranceView() {
        self.performSegueWithIdentifier("DashboardToAutoInsuranceDetailsSegueID", sender: self)
    }
    
    
    // MARK: - IADataManagerDelegate Methods
    
    /**
     * IADataManagerDelegate method. It is implemented to handle response sent by IADataManager.
     */
    internal override func aiDataManagerDidSucceed(sender pSender:IADataManager, response pResponse: IADataManagerResponse) {
        IAAppDelegate.currentAppDelegate.hideLoadingOverlay()
        
        if pResponse.error != nil {
            self.displayMessage(message: pResponse.error.localizedDescription, type: IAMessageType.Error)
        } else if pSender.requestType == IARequestType.DashboardDetails {
            self.dashboardDetails = pResponse.result as! IADashboard
            self.reloadAllView()
        }
    }
}
