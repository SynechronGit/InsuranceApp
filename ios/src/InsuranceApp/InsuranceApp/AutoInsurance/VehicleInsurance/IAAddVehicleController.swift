//
//  IAAddVehicleController.swift
//  InsuranceApp
//

import UIKit


/**
 * Controller for Add Vehicle screen.
 */
class IAAddVehicleController: IABaseController {
    @IBOutlet weak var licensePlateNumberTextField :UITextField!
    @IBOutlet weak var stateTextField :UITextField!
    @IBOutlet weak var vinTextField: UITextField!
    
    @IBOutlet weak var mainBgView: UIView!
    
    @IBOutlet weak var addBtn1: UIView!
    @IBOutlet weak var addBtn2: UIView!
    @IBOutlet weak var addBtn3: UIView!
    
    @IBOutlet weak var saveBtnView: UIView!
    
    @IBOutlet weak var takeVinNoView: UIView!
    @IBOutlet weak var vinNoGeneratorView: UIView!
    
    @IBOutlet weak var vinConfirmationNoBtn: UIButton!
    @IBOutlet weak var vinConfirmationYesBtn: UIButton!
    
    @IBOutlet weak var yearTextBox: UITextField!
    @IBOutlet weak var companyTextBox: UITextField!
    @IBOutlet weak var modelTextBox: UITextField!
    @IBOutlet weak var bosyStyleTextBox: UITextField!
    
    @IBOutlet weak var comprehensiveCoverageFirstOptionButton: UIButton!
    
    @IBOutlet weak var comprehensiveCoverageSecondOptionButton: UIButton!
    
    @IBOutlet weak var collisionCoverageFirstOptionButton: UIButton!
    
    @IBOutlet weak var collisionCoverageSecondOptionButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addPhoto1  = UITapGestureRecognizer(target: self, action: #selector(didSelectAddPhotoFirst))
        saveBtnView.addGestureRecognizer(addPhoto1)
        
        let addPhoto2  = UITapGestureRecognizer(target: self, action: #selector(didSelectAddPhotoSecond))
        saveBtnView.addGestureRecognizer(addPhoto2)
        
        let addPhoto3  = UITapGestureRecognizer(target: self, action: #selector(didSelectAddPhotoThird))
        saveBtnView.addGestureRecognizer(addPhoto3)
        
        let saveBtnTap = UITapGestureRecognizer(target: self, action: #selector(didSelectAddButton))
        saveBtnView.addGestureRecognizer(saveBtnTap)
        
        self.updateUI()
    }
    
    func updateUI(){
        self.mainBgView.layer.cornerRadius = 10.0
        self.mainBgView.layer.masksToBounds = true
        
        self.addBtn1.layer.cornerRadius = IAConstants.dashboardSubviewCornerRadius
        self.addBtn1.layer.masksToBounds = true
        
        self.addBtn2.layer.cornerRadius = IAConstants.dashboardSubviewCornerRadius
        self.addBtn2.layer.masksToBounds = true
        
        self.addBtn3.layer.cornerRadius = IAConstants.dashboardSubviewCornerRadius
        self.addBtn3.layer.masksToBounds = true
        
        self.takeVinNoView.layer.cornerRadius = IAConstants.dashboardSubviewCornerRadius
        self.takeVinNoView.layer.masksToBounds = true
        
        self.vinNoGeneratorView.layer.cornerRadius = IAConstants.dashboardSubviewCornerRadius
        self.vinNoGeneratorView.layer.masksToBounds = true
        
        self.saveBtnView.layer.cornerRadius = IAConstants.dashboardSubviewCornerRadius
        self.saveBtnView.layer.masksToBounds = true
    }
    
    // MARK: - Selector Methods
    
    /**
     * Selector method that will be called when button is tapped.
     * @return Void
     */
     func didSelectAddButton() {
//        let aVehicle = IAVehicle()
//        aVehicle.licensePlateNumber = self.licensePlateNumberTextField.text
//        aVehicle.state = self.stateTextField.text
//        
//        IAAppDelegate.currentAppDelegate.displayLoadingOverlay()
//        self.dataManager.addVehicle(aVehicle)
    }
    
    func didSelectAddPhotoFirst() {
    
    }
    
    
    func didSelectAddPhotoSecond() {
        
    }
    
    
    func didSelectAddPhotoThird() {
        
    }
    
    @IBAction func didSelectVinConfirmationYes(sender: AnyObject) {
    }
    
    @IBAction func didSelectVinConfirmationNo(sender: AnyObject) {
    }
    
    @IBAction func didSelectComprehensiveCoverageFirstOption(sender: AnyObject) {
    }
    
    @IBAction func didSelectComprehensiveCoverageSecondOption(sender: AnyObject) {
    }
    
    @IBAction func didSelectCollisionCoverageFirstOption(sender: AnyObject) {
    }
    
    
    @IBAction func didSelectCollisionCoverageSecondOption(sender: AnyObject) {
    }
    
    // MARK: - IADataManagerDelegate Methods
    
    /**
     * IADataManagerDelegate method. It is implemented to handle response sent by IADataManager.
     */
    internal override func aiDataManagerDidSucceed(sender pSender:IADataManager, response pResponse: IADataManagerResponse) {
        IAAppDelegate.currentAppDelegate.hideLoadingOverlay()
        
        if pResponse.error != nil {
            self.displayMessage(message: pResponse.error.localizedDescription, type: IAMessageType.Error)
        } else if pSender.requestType == IARequestType.AddVehicle {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
}
