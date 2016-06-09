//
//  IAAddVehicleController.swift
//  InsuranceApp
//

import UIKit


/**
 * Controller for Add Vehicle screen.
 */
class IAAddVehicleController: IABaseController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
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

    
    @IBOutlet weak var vinTextBox: IATextField!
    @IBOutlet weak var yearTextBox: IATextField!
    @IBOutlet weak var companyTextBox: IATextField!
    @IBOutlet weak var modelTextBox: IATextField!
    @IBOutlet weak var bosyStyleTextBox: IATextField!
    @IBOutlet weak var vehicleNameTextBox: IATextField!
    
    @IBOutlet weak var comprehensiveCoverageFirstOptionButton: UIButton!
    @IBOutlet weak var comprehensiveCoverageFirstOptionLabel: UILabel!
    @IBOutlet weak var comprehensiveCoverageSecondOptionButton: UIButton!
    @IBOutlet weak var comprehensiveCoverageSecondOptionLabel: UILabel!
    
    @IBOutlet weak var collisionCoverageFirstOptionButton: UIButton!
    @IBOutlet weak var collisionCoverageFirstOptionLabel: UILabel!
    @IBOutlet weak var collisionCoverageSecondOptionButton: UIButton!
    @IBOutlet weak var collisionCoverageSecondOptionLabel: UILabel!
    
    @IBOutlet weak var descriptionBgView: UIView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    
    var vinConfirmation : Bool = true
    var comprahensiveFirstOption : Bool = true
    var collisionFirstOption : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Add Vehicle"
        
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
        self.addBtn2.hidden = true
        self.addBtn3.hidden = true
        
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
        
        self.saveBtnView.layer.cornerRadius = IAConstants.dashboardSubviewCornerRadius
        self.saveBtnView.layer.masksToBounds = true
        
        self.descriptionBgView.layer.cornerRadius = IAConstants.dashboardSubviewCornerRadius
        self.descriptionBgView.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.descriptionBgView.layer.borderWidth = 2.0
        self.descriptionBgView.layer.masksToBounds = true
        
        
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
        self.companyTextBox.delegate = self
        
        self.modelTextBox.shouldDisplayAsDropdown = true
        self.modelTextBox.controller = self
        self.modelTextBox.list = nil
        self.modelTextBox.delegate = self
        
        
        self.bosyStyleTextBox.shouldDisplayAsDropdown = true
        self.bosyStyleTextBox.controller = self
        self.bosyStyleTextBox.list = nil
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if textField.isEqual(self.companyTextBox) {
            self.modelTextBox.text = nil
            self.bosyStyleTextBox.text = nil
            if self.companyTextBox.text == "Mercedes" {
                self.modelTextBox.list = ["A-Class A 180", "B-Class B 180 Sport", "S350", "S400", "Maybach S500", "G 63 AMG", "M Guard", "GLE 250D", "GLE 350D" ]
            } else if self.companyTextBox.text == "BMW" {
                self.modelTextBox.list = ["1 Series 11d sports", "320d", "520d" , "X6" , "X1",  "X5"]
            } else if self.companyTextBox.text == "Audi" {
                self.modelTextBox.list = ["A8", "RS7", "A3", "A4", "Q3", "Q5", "Q7"]
            } else {
                self.modelTextBox.list = nil
            }
        }
        
        if textField.isEqual(self.modelTextBox) {
            if (self.modelTextBox.text == "1 Series 11d sports" || self.modelTextBox.text == "A-Class A 180" || self.modelTextBox.text == "B-Class B 180 Sport"){
                self.bosyStyleTextBox.list = ["Hatchback", "SUV"]
                self.bosyStyleTextBox.text = "Hatchback"
            } else if (self.modelTextBox.text == "A8" || self.modelTextBox.text == "RS7" || self.modelTextBox.text == "A3" || self.modelTextBox.text == "A4" || self.modelTextBox.text == "320d" || self.modelTextBox.text == "520d" || self.modelTextBox.text == "S350" || self.modelTextBox.text == "S400" || self.modelTextBox.text == "Maybach S500" ) {
                self.bosyStyleTextBox.list = ["Hatchback", "Sedan"]
                self.bosyStyleTextBox.text = "Sedan"
            } else if (self.modelTextBox.text == "Q3" || self.modelTextBox.text == "Q5" || self.modelTextBox.text == "Q7" || self.modelTextBox.text == "X6" || self.modelTextBox.text == "X1" || self.modelTextBox.text == "X5" || self.modelTextBox.text == "G 63 AMG" || self.modelTextBox.text == "M Guard" || self.modelTextBox.text == "GLE 250D" || self.modelTextBox.text == "GLE 350D"){
                self.bosyStyleTextBox.list = ["Sedan", "SUV"]
                self.bosyStyleTextBox.text = "SUV"
            }
        }
    }
    
    
    // MARK: - Selector Methods
    
    /**
     * Selector method that will be called when button is tapped.
     * @return Void
     */
    func didSelectAddButton() {
        
        do {
            if self.vehicleNameTextBox.text == nil || self.vehicleNameTextBox.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) <= 0 {
                throw IAError.Generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Please enter VIN."]))
            }
            
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
            aVehicle.vin = self.vinTextBox.text
            aVehicle.year = self.yearTextBox.text
            aVehicle.company = self.companyTextBox.text
            aVehicle.modelNumber = self.modelTextBox.text
            aVehicle.bodyStyle = self.bosyStyleTextBox.text
            aVehicle.vehicleDescription = self.descriptionTextView.text
            aVehicle.vehicleName = self.vehicleNameTextBox.text
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
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            self.imagePickerController.sourceType = .PhotoLibrary
        #else
            self.imagePickerController.sourceType = .PhotoLibrary
        #endif
        self.imagePickerController.delegate = self
        self.imagePickerController.modalPresentationStyle = UIModalPresentationStyle.FormSheet
        self.presentViewController(self.imagePickerController, animated: true, completion: nil)
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
                self.addBtn2.hidden = false
                
            } else if self.imagePickerDestinationImageView != nil && self.imagePickerDestinationImageView.isEqual(self.addPhotoSecondImageView) {
                self.addPhotoSecondImageView.image = aPickedImage
                self.addBtn3.hidden = false
                
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
