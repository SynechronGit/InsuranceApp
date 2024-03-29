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
    
    @IBOutlet weak var metWithAccidentContainerView: UIView!
    
    @IBOutlet var roadsideAssistanceContainerView: UIView!
    @IBOutlet var insuranceIDCardContainerView: UIView!
    
    var dashboardDetails: IADashboard!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let aTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(IADashboardController.didSelectAutoInsuranceView))
        aTapGestureRecognizer.cancelsTouchesInView = false
        self.autoInsuranceContainerView.addGestureRecognizer(aTapGestureRecognizer)
        self.autoInsuranceContainerView.layer.borderColor = UIColor(red: (self.autoInsuranceContainerView.backgroundColor?.redComponent)! * 1.3, green: (self.autoInsuranceContainerView.backgroundColor?.greenComponent)! * 1.3, blue: (self.autoInsuranceContainerView.backgroundColor?.blueComponent)! * 1.3, alpha: 1.0).cgColor
        
        self.homeInsuranceContainerView.alpha = 0.6
        self.boatInsuranceContainerView.alpha = 0.6
        self.petInsuranceContainerView.alpha = 0.6
        
        self.myClaimsContainerView.layer.cornerRadius = IAConstants.dashboardSubviewCornerRadius
        self.myClaimsContainerView.layer.masksToBounds = true
        let aMyClaimsTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(IADashboardController.didSelectMyClaimsContainerView))
        aMyClaimsTapGestureRecognizer.cancelsTouchesInView = false
        self.myClaimsContainerView.addGestureRecognizer(aMyClaimsTapGestureRecognizer)
        
        self.payPremiumContainerView.layer.cornerRadius = IAConstants.dashboardSubviewCornerRadius
        self.payPremiumContainerView.layer.masksToBounds = true
        let aPayPremiumTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(IADashboardController.didSelectPayPremiumContainerView))
        aPayPremiumTapGestureRecognizer.cancelsTouchesInView = false
        self.payPremiumContainerView.addGestureRecognizer(aPayPremiumTapGestureRecognizer)
        
        let aTapGestureRecognizerAccident = UITapGestureRecognizer(target: self, action: #selector(IADashboardController.didSelectMetWithAccident))
        aTapGestureRecognizerAccident.cancelsTouchesInView = false
        self.metWithAccidentContainerView.addGestureRecognizer(aTapGestureRecognizerAccident)
        self.metWithAccidentContainerView.layer.cornerRadius = IAConstants.dashboardSubviewCornerRadius
        self.metWithAccidentContainerView.layer.masksToBounds = true
        
        let aTapGestureRecognizerRoadSide = UITapGestureRecognizer(target: self, action: #selector(IADashboardController.didSelectRoadSideAssistance))
        aTapGestureRecognizerAccident.cancelsTouchesInView = false
        self.roadsideAssistanceContainerView.addGestureRecognizer(aTapGestureRecognizerRoadSide)
        self.roadsideAssistanceContainerView.layer.cornerRadius = IAConstants.dashboardSubviewCornerRadius
        self.roadsideAssistanceContainerView.layer.masksToBounds = true
        
        self.insuranceIDCardContainerView.layer.cornerRadius = IAConstants.dashboardSubviewCornerRadius
        self.insuranceIDCardContainerView.layer.masksToBounds = true
        let aTapGestureRecognizerInsuranceIDCard = UITapGestureRecognizer(target: self, action: #selector(IADashboardController.didSelectInsuranceIDCardContainerView))
        aTapGestureRecognizerInsuranceIDCard.cancelsTouchesInView = false
        self.insuranceIDCardContainerView.addGestureRecognizer(aTapGestureRecognizerInsuranceIDCard)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
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
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            self.autoInsuranceContainerView.layer.borderWidth = 0.0
            self.performSegue(withIdentifier: "DashboardToAutoInsuranceDetailsSegueID", sender: self)
        })
        let anAnimation = CABasicAnimation(keyPath: "borderWidth")
        anAnimation.fromValue = 0.0
        anAnimation.toValue = 3.0
        anAnimation.repeatCount = 3
        anAnimation.duration = 0.2
        anAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        self.autoInsuranceContainerView.layer.add(anAnimation, forKey: "pulse")
        CATransaction.commit()
    }
    
    
    @IBAction func didSelectMetWithAccident(){
        self.performSegue(withIdentifier: "DashboardToMetWithAccidentSegueID", sender: self)
    }
    
    
    @IBAction func didSelectRoadSideAssistance(){
        self.performSegue(withIdentifier: "DashboardToRoadsideAssistanceSegueID", sender: self)
    }
    
    
    @IBAction func didSelectInsuranceIDCardContainerView(){
        self.performSegue(withIdentifier: "DashboardToInsuranceIDCardSegueID", sender: self)
    }
    
    
    @IBAction func didSelectMyClaimsContainerView() {
        IAConstants.homeController.didSelectClaimsTabItemView()
    }
    
    
    @IBAction func didSelectPayPremiumContainerView() {
        self.performSegue(withIdentifier: "DashboardToPayPremiumSegueID", sender: self)
    }
    
    
    // MARK: - IADataManagerDelegate Methods
    
    /**
     * IADataManagerDelegate method. It is implemented to handle response sent by IADataManager.
     */
    internal override func aiDataManagerDidSucceed(sender pSender:IADataManager, response pResponse: IADataManagerResponse) {
        IAAppDelegate.currentAppDelegate.hideLoadingOverlay()
        
        if pResponse.error != nil {
            self.displayMessage(message: pResponse.error.localizedDescription, type: IAMessageType.error)
        } else if pSender.requestType == IARequestType.dashboardDetails {
            self.dashboardDetails = pResponse.result as! IADashboard
            self.reloadAllView()
        }
    }
}
