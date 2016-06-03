//
//  IAAddVehicleController.swift
//  InsuranceApp
//

import UIKit


/**
 * Controller for Add Vehicle screen.
 */
class IAAddVehicleController: IABaseController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var licensePlateNumberTextField :UITextField!
    @IBOutlet weak var stateTextField :UITextField!
    @IBOutlet weak var vinTextField: UITextField!
    
    @IBOutlet weak var mainBgView: UIView!
    
    @IBOutlet weak var addBtn1: UIView!
    @IBOutlet weak var addPhotoFirstImageView: UIImageView!
    @IBOutlet weak var addBtn2: UIView!
    @IBOutlet weak var addPhotoSecondImageView: UIImageView!
    @IBOutlet weak var addBtn3: UIView!
    @IBOutlet weak var addPhotoThirdImageView: UIImageView!
    
    var imagePickerController :UIImagePickerController!
    weak var imagePickerDestinationImageView: UIImageView!
    
    @IBOutlet weak var saveBtnView: UIView!
    
    @IBOutlet weak var takeVinNoView: UIView!
    @IBOutlet weak var vinNoGeneratorView: UIView!
    
    @IBOutlet weak var vinConfirmationNoBtn: UIButton!
    @IBOutlet weak var vinConfirmationYesBtn: UIButton!
    
    @IBOutlet weak var yearTextBox: IATextField!
    @IBOutlet weak var companyTextBox: IATextField!
    @IBOutlet weak var modelTextBox: IATextField!
    @IBOutlet weak var bosyStyleTextBox: IATextField!
    
    @IBOutlet weak var comprehensiveCoverageFirstOptionButton: UIButton!
    @IBOutlet weak var comprehensiveCoverageFirstOptionLabel: UILabel!
    @IBOutlet weak var comprehensiveCoverageSecondOptionButton: UIButton!
    @IBOutlet weak var comprehensiveCoverageSecondOptionLabel: UILabel!
    
    @IBOutlet weak var collisionCoverageFirstOptionButton: UIButton!
    @IBOutlet weak var collisionCoverageFirstOptionLabel: UILabel!
    @IBOutlet weak var collisionCoverageSecondOptionButton: UIButton!
    @IBOutlet weak var collisionCoverageSecondOptionLabel: UILabel!
    
    var vinConfirmation : Bool = true
    var comprahensiveFirstOption : Bool = true
    var collisionFirstOption : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addPhoto1  = UITapGestureRecognizer(target: self, action: #selector(didSelectAddPhotoFirst))
        addBtn1.addGestureRecognizer(addPhoto1)
        
        let addPhoto2  = UITapGestureRecognizer(target: self, action: #selector(didSelectAddPhotoSecond))
        addBtn2.addGestureRecognizer(addPhoto2)
        
        let addPhoto3  = UITapGestureRecognizer(target: self, action: #selector(didSelectAddPhotoThird))
        addBtn3.addGestureRecognizer(addPhoto3)
        
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
        
        self.yearTextBox.shouldDisplayAsDropdown = true
        self.yearTextBox.controller = self
        var yearsArray = Array<String>()
        for anIndex:Int in 1990 ..< 2016 {
            yearsArray.append(String(format: "%d", anIndex + 1))
        }
        self.yearTextBox.list = yearsArray
        
        self.companyTextBox.shouldDisplayAsDropdown = true
        self.companyTextBox.controller = self
        self.companyTextBox.list = ["Mercedes", "BMW", "Audi"]
        
        self.modelTextBox.shouldDisplayAsDropdown = true
        self.modelTextBox.controller = self
        var modelArray = Array<String>()
        modelArray = ["S660","X5","X6", "A4", "A5"]
        self.modelTextBox.list = modelArray
        
        self.bosyStyleTextBox.shouldDisplayAsDropdown = true
        self.bosyStyleTextBox.controller = self
        self.bosyStyleTextBox.list = ["Hatchbacks", "Sedans", "Vans‎", "Hardtop"]
    }
    
    
    // MARK: - Selector Methods
    
    /**
     * Selector method that will be called when button is tapped.
     * @return Void
     */
    func didSelectAddButton() {
        
        do {
            
            if self.addPhotoFirstImageView.image == nil && self.addPhotoSecondImageView.image == nil && self.addPhotoThirdImageView.image == nil  {
                throw IAError.Generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Please provide vehicle's photo."]))
            }
            
            
            if self.yearTextBox.text == nil || self.yearTextBox.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) <= 0 {
                throw IAError.Generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Please select year."]))
            }
            
            if self.companyTextBox.text == nil || self.companyTextBox.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) <= 0 {
                throw IAError.Generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Please select company."]))
            }
            
            if self.modelTextBox.text == nil || self.modelTextBox.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) <= 0 {
                throw IAError.Generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Please select model number."]))
            }
            
            if self.bosyStyleTextBox.text == nil || self.bosyStyleTextBox.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) <= 0 {
                throw IAError.Generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Please select body style."]))
            }
            
            
            IAAppDelegate.currentAppDelegate.displayLoadingOverlay()
            let aVehicle = IAVehicle()
            aVehicle.photoOne = self.addPhotoFirstImageView.image
            aVehicle.photoTwo = self.addPhotoSecondImageView.image
            aVehicle.photoThree = self.addPhotoThirdImageView.image
            aVehicle.vin = "1LNLM82W8NY668232"
            aVehicle.year = self.yearTextBox.text
            aVehicle.company = self.companyTextBox.text
            aVehicle.modelNumber = self.modelTextBox.text
            aVehicle.bodyStyle = self.bosyStyleTextBox.text
            if self.comprahensiveFirstOption == true {
                aVehicle.comprehensiveCoverage = self.comprehensiveCoverageFirstOptionLabel.text
            } else {
                aVehicle.comprehensiveCoverage = self.comprehensiveCoverageSecondOptionLabel.text
            }
            if self.collisionFirstOption == true {
                aVehicle.collisionCoverage = self.collisionCoverageFirstOptionLabel.text
            } else {
                aVehicle.collisionCoverage = self.collisionCoverageSecondOptionLabel.text
            }
            
            self.dataManager.addVehicle(aVehicle)
            
        } catch IAError.Generic(let pError){
            self.displayMessage(message: pError.localizedDescription, type: IAMessageType.Error)
        } catch {
            self.displayMessage(message: "Add Vehicle error.", type: IAMessageType.Error)
        }
        
    }
    
    func didSelectAddPhotoFirst() {
        self.imagePickerDestinationImageView = self.addPhotoFirstImageView
        self.displayImagePicker()
    }
    
    
    func didSelectAddPhotoSecond() {
        self.imagePickerDestinationImageView = self.addPhotoSecondImageView
        self.displayImagePicker()
        
    }
    
    
    func didSelectAddPhotoThird() {
        self.imagePickerDestinationImageView = self.addPhotoThirdImageView
        self.displayImagePicker()
    }
    
    func displayImagePicker() {
        if self.imagePickerController == nil {
            self.imagePickerController = UIImagePickerController()
        }
        self.imagePickerController.allowsEditing = false
        self.imagePickerController.sourceType = .PhotoLibrary
        self.imagePickerController.delegate = self
        self.imagePickerController.modalPresentationStyle = UIModalPresentationStyle.FormSheet
        self.presentViewController(self.imagePickerController, animated: true, completion: nil)
    }
    
    
    @IBAction func didSelectVinConfirmationYes(sender: AnyObject) {
        
        if (vinConfirmation == true){
            vinConfirmation = false
            vinConfirmationYesBtn.setBackgroundImage(UIImage(named: "tick_box_deselected"), forState: .Normal)
            vinConfirmationNoBtn.setBackgroundImage(UIImage(named: "tick_box_selected"), forState: .Normal)
        }else{
            vinConfirmation = true
            vinConfirmationYesBtn.setBackgroundImage(UIImage(named: "tick_box_selected"), forState: .Normal)
            vinConfirmationNoBtn.setBackgroundImage(UIImage(named: "tick_box_deselected"), forState: .Normal)
        }
        
    }
    
    @IBAction func didSelectVinConfirmationNo(sender: AnyObject) {
        if (vinConfirmation == false){
            vinConfirmation = true
            vinConfirmationNoBtn.setBackgroundImage(UIImage(named: "tick_box_deselected"), forState: .Normal)
            vinConfirmationYesBtn.setBackgroundImage(UIImage(named: "tick_box_selected"), forState: .Normal)
        }else{
            vinConfirmation = false
            vinConfirmationNoBtn.setBackgroundImage(UIImage(named: "tick_box_selected"), forState: .Normal)
            vinConfirmationYesBtn.setBackgroundImage(UIImage(named: "tick_box_deselected"), forState: .Normal)
        }
        
    }
    
    @IBAction func didSelectComprehensiveCoverageFirstOption(sender: AnyObject) {
        if (comprahensiveFirstOption == true){
            comprahensiveFirstOption = false
            comprehensiveCoverageFirstOptionButton.setBackgroundImage(UIImage(named: "tick_box_deselected"), forState: .Normal)
            comprehensiveCoverageSecondOptionButton.setBackgroundImage(UIImage(named: "tick_box_selected"), forState: .Normal)
        }else{
            comprahensiveFirstOption = true
            comprehensiveCoverageFirstOptionButton.setBackgroundImage(UIImage(named: "tick_box_selected"), forState: .Normal)
            comprehensiveCoverageSecondOptionButton.setBackgroundImage(UIImage(named: "tick_box_deselected"), forState: .Normal)
        }
        
    }
    
    @IBAction func didSelectComprehensiveCoverageSecondOption(sender: AnyObject) {
        if (comprahensiveFirstOption == false){
            comprahensiveFirstOption = true
            comprehensiveCoverageSecondOptionButton.setBackgroundImage(UIImage(named: "tick_box_deselected"), forState: .Normal)
            comprehensiveCoverageFirstOptionButton.setBackgroundImage(UIImage(named: "tick_box_selected"), forState: .Normal)
        }else{
            comprahensiveFirstOption = false
            comprehensiveCoverageSecondOptionButton.setBackgroundImage(UIImage(named: "tick_box_selected"), forState: .Normal)
            comprehensiveCoverageFirstOptionButton.setBackgroundImage(UIImage(named: "tick_box_deselected"), forState: .Normal)
        }
        
    }
    
    @IBAction func didSelectCollisionCoverageFirstOption(sender: AnyObject) {
        if (collisionFirstOption == true){
            collisionFirstOption = false
            collisionCoverageFirstOptionButton.setBackgroundImage(UIImage(named: "tick_box_deselected"), forState: .Normal)
            collisionCoverageSecondOptionButton.setBackgroundImage(UIImage(named: "tick_box_selected"), forState: .Normal)
        }else{
            collisionFirstOption = true
            collisionCoverageFirstOptionButton.setBackgroundImage(UIImage(named: "tick_box_selected"), forState: .Normal)
            collisionCoverageSecondOptionButton.setBackgroundImage(UIImage(named: "tick_box_deselected"), forState: .Normal)
        }
    }
    
    
    @IBAction func didSelectCollisionCoverageSecondOption(sender: AnyObject) {
        if (collisionFirstOption == false){
            collisionFirstOption = true
            collisionCoverageSecondOptionButton.setBackgroundImage(UIImage(named: "tick_box_deselected"), forState: .Normal)
            collisionCoverageFirstOptionButton.setBackgroundImage(UIImage(named: "tick_box_selected"), forState: .Normal)
        }else{
            collisionFirstOption = false
            collisionCoverageSecondOptionButton.setBackgroundImage(UIImage(named: "tick_box_selected"), forState: .Normal)
            collisionCoverageFirstOptionButton.setBackgroundImage(UIImage(named: "tick_box_deselected"), forState: .Normal)
        }
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let aPickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            if self.imagePickerDestinationImageView != nil && self.imagePickerDestinationImageView.isEqual(self.addPhotoFirstImageView)  {
                self.addPhotoFirstImageView.image = aPickedImage
                
            } else if self.imagePickerDestinationImageView != nil && self.imagePickerDestinationImageView.isEqual(self.addPhotoSecondImageView) {
                 self.addPhotoSecondImageView.image = aPickedImage
                
            } else if self.imagePickerDestinationImageView != nil && self.imagePickerDestinationImageView.isEqual(self.addPhotoThirdImageView) {
                self.addPhotoThirdImageView.image = aPickedImage
                
            }
        }
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
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
            let anAlert = UIAlertController(title: "Vehicle added successfully", message: nil, preferredStyle: .Alert)
            anAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: {(action:UIAlertAction) in
                self.navigationController?.popViewControllerAnimated(true)
            }))
            self.presentViewController(anAlert, animated: true, completion: nil)
        }
    }
}
