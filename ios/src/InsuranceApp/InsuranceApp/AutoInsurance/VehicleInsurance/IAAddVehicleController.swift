//
//  IAAddVehicleController.swift
//  InsuranceApp
//

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func <= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l <= r
  default:
    return !(rhs < lhs)
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}



/**
 * Controller for Add Vehicle screen.
 */
class IAAddVehicleController: IABaseController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, IADropdownListControllerDelegate {
    @IBOutlet weak var licensePlateNumberTextField :UITextField!
    @IBOutlet weak var stateTextField :UITextField!
    @IBOutlet weak var vinTextField: UITextField!
    
    
    @IBOutlet weak var addVehicleScrollView: UIScrollView!
    @IBOutlet weak var mainBgView: UIView!
    @IBOutlet weak var mainBgViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var addBtn1: UIView!
    @IBOutlet weak var addPhotoFirstImageView: UIImageView!
    @IBOutlet weak var addBtn2: UIView!
    @IBOutlet weak var addPhotoSecondImageView: UIImageView!
    @IBOutlet weak var addBtn3: UIView!
    @IBOutlet weak var addPhotoThirdImageView: UIImageView!
    @IBOutlet weak var vehicleImageBottomBorderTopConstraint :NSLayoutConstraint!
    
    var imagePickerController :UIImagePickerController!
    weak var imagePickerDestinationImageView: UIImageView!
    var dropdownListController :IADropdownListController!
    
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
        self.addBtn2.isHidden = true
        self.addBtn3.isHidden = true
        
        //self.mainBgView.layer.cornerRadius = 10.0
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
        self.descriptionBgView.layer.borderColor = UIColor.lightGray.cgColor
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
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.assignScrollContentHeight()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
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
            if self.vinTextBox.text == nil || self.vinTextBox.text?.lengthOfBytes(using: String.Encoding.utf8) <= 0 {
                throw IAError.generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Please enter VIN."]))
            }
            
            if self.vinTextBox.text != nil && self.vinTextBox.text?.lengthOfBytes(using: String.Encoding.utf8) > 17 {
                throw IAError.generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"VIN should not be greater than 17 characters."]))
            }
            
            if self.companyTextBox.text == nil || self.companyTextBox.text?.lengthOfBytes(using: String.Encoding.utf8) <= 0 {
                throw IAError.generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Please select company."]))
            }
            
            if self.modelTextBox.text == nil || self.modelTextBox.text?.lengthOfBytes(using: String.Encoding.utf8) <= 0 {
                throw IAError.generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Please select model number."]))
            }
            
            if self.bosyStyleTextBox.text == nil || self.bosyStyleTextBox.text?.lengthOfBytes(using: String.Encoding.utf8) <= 0 {
                throw IAError.generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Please select body style."]))
            }
            
            if self.yearTextBox.text == nil || self.yearTextBox.text?.lengthOfBytes(using: String.Encoding.utf8) <= 0 {
                throw IAError.generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Please select year."]))
            }
            
            
            if self.vehicleNameTextBox.text == nil || self.vehicleNameTextBox.text?.lengthOfBytes(using: String.Encoding.utf8) <= 0 {
                throw IAError.generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Please enter vehicle's name"]))
            }
            
            if self.vehicleNameTextBox.text != nil && self.vehicleNameTextBox.text?.lengthOfBytes(using: String.Encoding.utf8) > 0 {
                if try IAUtils.doesRegexMatch("[^A-Za-z ]", subject: self.vehicleNameTextBox.text!) == true {
                    throw IAError.generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Name contains invalid characters."]))
                }
            }
            
            if self.vehicleNameTextBox.text != nil && self.vehicleNameTextBox.text?.lengthOfBytes(using: String.Encoding.utf8) > 25 {
                throw IAError.generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Name should not be greater than 25 digits."]))
            }
            
            if self.descriptionTextView.text != nil && self.descriptionTextView.text?.lengthOfBytes(using: String.Encoding.utf8) > 500 {
                throw IAError.generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Description should not be greater than 500 characters."]))
            }
            
            if self.addPhotoFirstImageView.image == nil && self.addPhotoSecondImageView.image == nil && self.addPhotoThirdImageView.image == nil  {
                throw IAError.generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Please provide vehicle's photo."]))
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
            
        } catch IAError.generic(let pError){
            self.displayMessage(message: pError.localizedDescription, type: IAMessageType.error)
        } catch {
            self.displayMessage(message: "Add Vehicle error.", type: IAMessageType.error)
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
        if self.dropdownListController == nil {
            self.dropdownListController  = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "IADropdownListControllerID") as! IADropdownListController
        }
        self.dropdownListController.delegate = self
        self.dropdownListController.list = ["Camera", "Photo Album"]
        self.dropdownListController.preferredContentSize = CGSize(width: 200.0, height: 80.0)
        self.dropdownListController.modalPresentationStyle = .popover
        self.dropdownListController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.any
        self.dropdownListController.popoverPresentationController?.sourceView = self.imagePickerDestinationImageView
        self.dropdownListController.popoverPresentationController?.sourceRect = self.imagePickerDestinationImageView.bounds
        self.present(self.dropdownListController, animated: true, completion: nil)
    }
    
    
    func dropdownListController(_ pDropdownListController:IADropdownListController, didSelectValue pValue:String) {
        pDropdownListController.dismiss(animated: false, completion: nil)
        
        if self.imagePickerController == nil {
            self.imagePickerController = UIImagePickerController()
        }
        self.imagePickerController.allowsEditing = false
        self.imagePickerController.delegate = self
        self.imagePickerController.modalPresentationStyle = UIModalPresentationStyle.formSheet
        
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            self.imagePickerController.sourceType = .photoLibrary
        #else
            if pValue == "Camera" {
                self.imagePickerController.sourceType = .camera
            } else if pValue == "Photo Album" {
                self.imagePickerController.sourceType = .photoLibrary
            }
        #endif
        
        self.present(self.imagePickerController, animated: true, completion: nil)
    }

    
    @IBAction func didSelectComprehensiveCoverageFirstOption(_ sender: AnyObject) {
        if (comprahensiveFirstOption == true){
            comprahensiveFirstOption = false
            comprehensiveCoverageFirstOptionButton.setBackgroundImage(UIImage(named: "tick_box_deselected"), for: UIControlState())
            comprehensiveCoverageSecondOptionButton.setBackgroundImage(UIImage(named: "tick_box_selected"), for: UIControlState())
        }else{
            comprahensiveFirstOption = true
            comprehensiveCoverageFirstOptionButton.setBackgroundImage(UIImage(named: "tick_box_selected"), for: UIControlState())
            comprehensiveCoverageSecondOptionButton.setBackgroundImage(UIImage(named: "tick_box_deselected"), for: UIControlState())
        }
        
    }
    
    @IBAction func didSelectComprehensiveCoverageSecondOption(_ sender: AnyObject) {
        if (comprahensiveFirstOption == false){
            comprahensiveFirstOption = true
            comprehensiveCoverageSecondOptionButton.setBackgroundImage(UIImage(named: "tick_box_deselected"), for: UIControlState())
            comprehensiveCoverageFirstOptionButton.setBackgroundImage(UIImage(named: "tick_box_selected"), for: UIControlState())
        }else{
            comprahensiveFirstOption = false
            comprehensiveCoverageSecondOptionButton.setBackgroundImage(UIImage(named: "tick_box_selected"), for: UIControlState())
            comprehensiveCoverageFirstOptionButton.setBackgroundImage(UIImage(named: "tick_box_deselected"), for: UIControlState())
        }
        
    }
    
    @IBAction func didSelectCollisionCoverageFirstOption(_ sender: AnyObject) {
        if (collisionFirstOption == true){
            collisionFirstOption = false
            collisionCoverageFirstOptionButton.setBackgroundImage(UIImage(named: "tick_box_deselected"), for: UIControlState())
            collisionCoverageSecondOptionButton.setBackgroundImage(UIImage(named: "tick_box_selected"), for: UIControlState())
        }else{
            collisionFirstOption = true
            collisionCoverageFirstOptionButton.setBackgroundImage(UIImage(named: "tick_box_selected"), for: UIControlState())
            collisionCoverageSecondOptionButton.setBackgroundImage(UIImage(named: "tick_box_deselected"), for: UIControlState())
        }
    }
    
    
    @IBAction func didSelectCollisionCoverageSecondOption(_ sender: AnyObject) {
        if (collisionFirstOption == false){
            collisionFirstOption = true
            collisionCoverageSecondOptionButton.setBackgroundImage(UIImage(named: "tick_box_deselected"), for: UIControlState())
            collisionCoverageFirstOptionButton.setBackgroundImage(UIImage(named: "tick_box_selected"), for: UIControlState())
        }else{
            collisionFirstOption = false
            collisionCoverageSecondOptionButton.setBackgroundImage(UIImage(named: "tick_box_selected"), for: UIControlState())
            collisionCoverageFirstOptionButton.setBackgroundImage(UIImage(named: "tick_box_deselected"), for: UIControlState())
        }
    }
    
    
    func assignScrollContentHeight() {
        if UIDevice.current.isIphone {
            var aContentViewHeight :CGFloat = 1262.0
            var aBottomBorderTop :CGFloat = self.addBtn1.frame.size.height + 30.0 + 30.0
            
            if self.addBtn2.isHidden == false {
                aBottomBorderTop = aBottomBorderTop + self.addBtn2.frame.size.height + 18.0
                aContentViewHeight = aContentViewHeight + self.addBtn2.frame.size.height + 18.0
            }
            
            if self.addBtn3.isHidden == false {
                aBottomBorderTop = aBottomBorderTop + self.addBtn3.frame.size.height + 18.0
                aContentViewHeight = aContentViewHeight + self.addBtn3.frame.size.height + 18.0
            }
            
            self.vehicleImageBottomBorderTopConstraint.constant = aBottomBorderTop
            self.mainBgViewHeightConstraint.constant = aContentViewHeight
            self.addVehicleScrollView.contentSize = CGSize(width: self.addVehicleScrollView.frame.width, height: aContentViewHeight)
        }
    }
    
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if var aPickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            aPickedImage = IAUtils.fixImageOrientation(aPickedImage)
            
            if self.imagePickerDestinationImageView != nil && self.imagePickerDestinationImageView.isEqual(self.addPhotoFirstImageView)  {
                self.addPhotoFirstImageView.image = aPickedImage
                self.addBtn2.isHidden = false
                
            } else if self.imagePickerDestinationImageView != nil && self.imagePickerDestinationImageView.isEqual(self.addPhotoSecondImageView) {
                self.addPhotoSecondImageView.image = aPickedImage
                self.addBtn3.isHidden = false
                
            } else if self.imagePickerDestinationImageView != nil && self.imagePickerDestinationImageView.isEqual(self.addPhotoThirdImageView) {
                self.addPhotoThirdImageView.image = aPickedImage
            }
        }
        picker.dismiss(animated: true, completion: nil)
        self.assignScrollContentHeight()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    
    
    // MARK: - IADataManagerDelegate Methods
    
    /**
     * IADataManagerDelegate method. It is implemented to handle response sent by IADataManager.
     */
    internal override func aiDataManagerDidSucceed(sender pSender:IADataManager, response pResponse: IADataManagerResponse) {
        IAAppDelegate.currentAppDelegate.hideLoadingOverlay()
        
        if pResponse.error != nil {
            self.displayMessage(message: pResponse.error.localizedDescription, type: IAMessageType.error)
        } else if pSender.requestType == IARequestType.addVehicle {
            let anAlert = UIAlertController(title: "Vehicle added successfully", message: nil, preferredStyle: .alert)
            anAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(action:UIAlertAction) in
                self.navigationController?.popViewController(animated: true)
            }))
            self.present(anAlert, animated: true, completion: nil)
        }
    }
}
