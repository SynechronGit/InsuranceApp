//
//  IAFileClaimController.swift
//  InsuranceApp
//
//  Created by rupendra on 6/1/16.
//  Copyright © 2016 com. All rights reserved.
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


class IAFileClaimController: IABaseController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, IADropdownListControllerDelegate {
    @IBOutlet weak var fileClaimContainerView: UIView!
    
    @IBOutlet weak var fileClaimScrollView: UIScrollView!
    @IBOutlet weak var fileClaimContentViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var insuranceTypeTextField: IATextField!
    @IBOutlet weak var insuredItemTextField: IATextField!
    @IBOutlet weak var reasonTextField: IATextField!
    @IBOutlet weak var estimatedValueTextField: IATextField!
    @IBOutlet weak var dateOfIncidentTextField: IATextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var addPhotoOneContainerView: UIView!
    @IBOutlet weak var addPhotoOneImageView: UIImageView!
    @IBOutlet weak var addPhotoOneIconImageView: UIImageView!
    @IBOutlet weak var addPhotoOneLabel: UILabel!
    
    @IBOutlet weak var addPhotoTwoContainerView: UIView!
    @IBOutlet weak var addPhotoTwoImageView: UIImageView!
    @IBOutlet weak var addPhotoTwoIconImageView: UIImageView!
    @IBOutlet weak var addPhotoTwoLabel: UILabel!
    
    @IBOutlet weak var addPhotoThreeContainerView: UIView!
    @IBOutlet weak var addPhotoThreeImageView: UIImageView!
    @IBOutlet weak var addPhotoThreeIconImageView: UIImageView!
    @IBOutlet weak var addPhotoThreeLabel: UILabel!
    
    @IBOutlet weak var scanDocumentOneContainerView: UIView!
    @IBOutlet weak var scanDocumentOneContainerTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var scanDocumentOneImageView: UIImageView!
    @IBOutlet weak var scanDocumentOneIconImageView: UIImageView!
    @IBOutlet weak var scanDocumentOneLabel: UILabel!
    
    @IBOutlet weak var scanDocumentTwoContainerView: UIView!
    @IBOutlet weak var scanDocumentTwoImageView: UIImageView!
    @IBOutlet weak var scanDocumentTwoIconImageView: UIImageView!
    @IBOutlet weak var scanDocumentTwoLabel: UILabel!
    
    @IBOutlet weak var scanDocumentThreeContainerView: UIView!
    @IBOutlet weak var scanDocumentThreeImageView: UIImageView!
    @IBOutlet weak var scanDocumentThreeIconImageView: UIImageView!
    @IBOutlet weak var scanDocumentThreeLabel: UILabel!
    
    var imagePickerController :UIImagePickerController!
    weak var imagePickerDestinationImageView: UIImageView!
    var dropdownListController :IADropdownListController!
    
    @IBOutlet weak var submitContainerView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "File Claim"
        
        self.fileClaimContainerView.layer.cornerRadius = IAConstants.dashboardSubviewCornerRadius
        self.fileClaimContainerView.layer.masksToBounds = true
        
        self.addPhotoOneContainerView.layer.cornerRadius = IAConstants.dashboardSubviewCornerRadius
        self.addPhotoOneContainerView.layer.masksToBounds = true
        var aTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(IAFileClaimController.didSelectAddPhotoOneContainerView))
        aTapGestureRecognizer.cancelsTouchesInView = false
        self.addPhotoOneContainerView.addGestureRecognizer(aTapGestureRecognizer)
        
        self.addPhotoTwoContainerView.layer.cornerRadius = IAConstants.dashboardSubviewCornerRadius
        self.addPhotoTwoContainerView.layer.masksToBounds = true
        aTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(IAFileClaimController.didSelectAddPhotoTwoContainerView))
        aTapGestureRecognizer.cancelsTouchesInView = false
        self.addPhotoTwoContainerView.addGestureRecognizer(aTapGestureRecognizer)
        self.addPhotoTwoContainerView.isHidden = true
        
        self.addPhotoThreeContainerView.layer.cornerRadius = IAConstants.dashboardSubviewCornerRadius
        self.addPhotoThreeContainerView.layer.masksToBounds = true
        aTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(IAFileClaimController.didSelectAddPhotoThreeContainerView))
        aTapGestureRecognizer.cancelsTouchesInView = false
        self.addPhotoThreeContainerView.addGestureRecognizer(aTapGestureRecognizer)
        self.addPhotoThreeContainerView.isHidden = true
        
        self.scanDocumentOneContainerView.layer.cornerRadius = IAConstants.dashboardSubviewCornerRadius
        self.scanDocumentOneContainerView.layer.masksToBounds = true
        aTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(IAFileClaimController.didSelectScanDocumentOneContainerView))
        aTapGestureRecognizer.cancelsTouchesInView = false
        self.scanDocumentOneContainerView.addGestureRecognizer(aTapGestureRecognizer)
        
        self.scanDocumentTwoContainerView.layer.cornerRadius = IAConstants.dashboardSubviewCornerRadius
        self.scanDocumentTwoContainerView.layer.masksToBounds = true
        aTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(IAFileClaimController.didSelectScanDocumentTwoContainerView))
        aTapGestureRecognizer.cancelsTouchesInView = false
        self.scanDocumentTwoContainerView.addGestureRecognizer(aTapGestureRecognizer)
        self.scanDocumentTwoContainerView.isHidden = true
        
        self.scanDocumentThreeContainerView.layer.cornerRadius = IAConstants.dashboardSubviewCornerRadius
        self.scanDocumentThreeContainerView.layer.masksToBounds = true
        aTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(IAFileClaimController.didSelectScanDocumentThreeContainerView))
        aTapGestureRecognizer.cancelsTouchesInView = false
        self.scanDocumentThreeContainerView.addGestureRecognizer(aTapGestureRecognizer)
        self.scanDocumentThreeContainerView.isHidden = true
        
        self.insuranceTypeTextField.shouldDisplayAsDropdown = true
        self.insuranceTypeTextField.delegate = self
        self.insuranceTypeTextField.controller = self
        self.insuranceTypeTextField.list = ["Vehicle", "Driver", "Home", "Boat", "Pet"]
        
        self.insuredItemTextField.shouldDisplayAsDropdown = true
        self.insuredItemTextField.delegate = self
        self.insuredItemTextField.controller = self
        self.insuredItemTextField.list = nil
        
        self.reasonTextField.shouldDisplayAsDropdown = true
        self.reasonTextField.delegate = self
        self.reasonTextField.controller = self
        self.reasonTextField.list = nil
        
        self.dateOfIncidentTextField.shouldDisplayAsDatePicker = true
        self.dateOfIncidentTextField.controller = self
        self.dateOfIncidentTextField.delegate = self
        self.dateOfIncidentTextField.maximumDate = Date()
        
        self.descriptionTextView.layer.cornerRadius = IAConstants.dashboardSubviewCornerRadius
        self.descriptionTextView.layer.borderWidth = 1.0
        self.descriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
        
        self.submitContainerView.layer.cornerRadius = IAConstants.dashboardSubviewCornerRadius
        self.submitContainerView.layer.masksToBounds = true
        aTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(IAFileClaimController.didSelectSubmitContainerView))
        aTapGestureRecognizer.cancelsTouchesInView = false
        self.submitContainerView.addGestureRecognizer(aTapGestureRecognizer)
    }
    
    
    func resetAllData() {
        self.view.endEditing(true)
        
        self.insuranceTypeTextField.text = nil
        self.insuredItemTextField.text = nil
        self.reasonTextField.text = nil
        self.estimatedValueTextField.text = nil
        self.dateOfIncidentTextField.text = nil
        self.descriptionTextView.text = nil
        
        self.addPhotoOneImageView.image = nil
        self.addPhotoOneIconImageView.isHidden = false
        self.addPhotoOneLabel.isHidden = false
        
        self.addPhotoTwoImageView.image = nil
        self.addPhotoTwoIconImageView.isHidden = false
        self.addPhotoTwoLabel.isHidden = false
        self.addPhotoTwoContainerView.isHidden = true
        
        self.addPhotoThreeImageView.image = nil
        self.addPhotoThreeIconImageView.isHidden = false
        self.addPhotoThreeLabel.isHidden = false
        self.addPhotoThreeContainerView.isHidden = true
        
        self.scanDocumentOneImageView.image = nil
        self.scanDocumentOneIconImageView.isHidden = false
        self.scanDocumentOneLabel.isHidden = false
        
        self.scanDocumentTwoImageView.image = nil
        self.scanDocumentTwoIconImageView.isHidden = false
        self.scanDocumentTwoLabel.isHidden = false
        self.scanDocumentTwoContainerView.isHidden = true
        
        self.scanDocumentThreeImageView.image = nil
        self.scanDocumentThreeIconImageView.isHidden = false
        self.scanDocumentThreeLabel.isHidden = false
        self.scanDocumentThreeContainerView.isHidden = true
    }
    
    
    func assignScrollContentHeight() {
        if UIDevice.current.isIphone {
            var aContentViewHeight :CGFloat = 849.0
            var aScanDocumentOneTop :CGFloat = 18.0
            
            if self.addPhotoTwoContainerView.isHidden == false {
                aScanDocumentOneTop = aScanDocumentOneTop + self.addPhotoTwoContainerView.frame.size.height + 18.0
                aContentViewHeight = aContentViewHeight + self.addPhotoTwoContainerView.frame.size.height + 18.0
            }
            
            if self.addPhotoThreeContainerView.isHidden == false {
                aScanDocumentOneTop = aScanDocumentOneTop + self.addPhotoThreeContainerView.frame.size.height + 18.0
                aContentViewHeight = aContentViewHeight + self.addPhotoThreeContainerView.frame.size.height + 18.0
            }
            
            if self.scanDocumentTwoContainerView.isHidden == false {
                aContentViewHeight = aContentViewHeight + self.scanDocumentTwoContainerView.frame.size.height + 18.0
            }
            
            if self.scanDocumentThreeContainerView.isHidden == false {
                aContentViewHeight = aContentViewHeight + self.scanDocumentThreeContainerView.frame.size.height + 18.0
            }
            
            self.scanDocumentOneContainerTopConstraint.constant = aScanDocumentOneTop
            self.fileClaimContentViewHeightConstraint.constant = aContentViewHeight
            self.fileClaimScrollView.contentSize = CGSize(width: self.fileClaimScrollView.frame.width, height: aContentViewHeight)
        }
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.isEqual(self.insuranceTypeTextField) {
            self.insuredItemTextField.text = nil
            self.reasonTextField.text = nil
            
            if self.insuranceTypeTextField.text == "Vehicle" {
                self.insuredItemTextField.list = ["Audi A7", "Mercedes Benz S550", "BMW i8"]
                self.reasonTextField.list = ["Theft", "Accident"]
            } else if self.insuranceTypeTextField.text == "Driver" {
                self.insuredItemTextField.list = ["Elijah Shah", "Brayden Howard", "Chris Logan", "Sam Mandies"]
                self.reasonTextField.list = ["Accident"]
            } else if self.insuranceTypeTextField.text == "Home" {
                self.insuredItemTextField.list = ["Appliances", "Furnitures", "Curtains", "Crockery"]
                self.reasonTextField.list = ["Theft"]
            } else if self.insuranceTypeTextField.text == "Boat" {
                self.insuredItemTextField.list = ["Yatch", "Skipper", "Equipments", "Loss"]
                self.reasonTextField.list = ["Theft", "Accident"]
            } else if self.insuranceTypeTextField.text == "Pet" {
                self.insuredItemTextField.list = ["Dogs", "Cats"]
                self.reasonTextField.list = ["Medical"]
            } else {
                self.insuredItemTextField.list = nil
                self.reasonTextField.list = nil
            }
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.isEqual(self.estimatedValueTextField) {
            self.view.endEditing(true)
            self.dateOfIncidentTextField.displayDropdownList()
        }
        
        return true
    }
    
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        var aReturnVal :Bool = true
        
        if textField is IATextField && (textField as! IATextField).shouldDisplayAsDropdown != nil && (textField as! IATextField).shouldDisplayAsDropdown == true {
            aReturnVal = false
        }
        
        return aReturnVal
    }
    
    
    // MARK: - Selector Methods
    
    /**
     * Selector method that will be called when Submit button is tapped.
     * @return Void
     */
    func didSelectSubmitContainerView() {
        do {
            if self.insuranceTypeTextField.text == nil || self.insuranceTypeTextField.text?.lengthOfBytes(using: String.Encoding.utf8) <= 0 {
                throw IAError.generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Please select insurance type."]))
            }
            
            if self.insuredItemTextField.text == nil || self.insuredItemTextField.text?.lengthOfBytes(using: String.Encoding.utf8) <= 0 {
                throw IAError.generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Please select insured Item."]))
            }
            
            if self.reasonTextField.text == nil || self.reasonTextField.text?.lengthOfBytes(using: String.Encoding.utf8) <= 0 {
                throw IAError.generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Please select reason for claim."]))
            }
            
            if self.estimatedValueTextField.text == nil || self.estimatedValueTextField.text?.lengthOfBytes(using: String.Encoding.utf8) <= 0 {
                throw IAError.generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Please enter estimated value."]))
            }
            
            if self.estimatedValueTextField.text != nil && self.estimatedValueTextField.text?.lengthOfBytes(using: String.Encoding.utf8) > 0 {
                if try IAUtils.doesRegexMatch("[^0-9]", subject: self.estimatedValueTextField.text!) == true {
                    throw IAError.generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Estimated value contains invalid characters."]))
                }
            }
            
            if self.estimatedValueTextField.text != nil && self.estimatedValueTextField.text?.lengthOfBytes(using: String.Encoding.utf8) > 8 {
                throw IAError.generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Estimated value should not be greater than 8 digits."]))
            }
            
            if IAUtils.convertStringtoInt(self.estimatedValueTextField.text!) <= 0{
                throw IAError.generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Estimated value is must be greater than zero"]))
            }
            
            if self.dateOfIncidentTextField.text == nil || self.dateOfIncidentTextField.text?.lengthOfBytes(using: String.Encoding.utf8) <= 0 {
                throw IAError.generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Please select date of incident."]))
            }
            
            if self.descriptionTextView.text != nil && self.descriptionTextView.text?.lengthOfBytes(using: String.Encoding.utf8) > 500 {
                throw IAError.generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Description should not be greater than 500 characters."]))
            }
            
            IAAppDelegate.currentAppDelegate.displayLoadingOverlay()
            
            let aDateFormatter = DateFormatter()
            aDateFormatter.locale = Locale(identifier: "US_en")
            aDateFormatter.dateFormat = "MM - dd - yyyy"
            
            let aClaim = IAClaim()
            aClaim.code = "UY3436809678"
            
            if self.insuranceTypeTextField.text == "Vehicle" {
                aClaim.insuranceType = IAInsuranceType.AutoCar.rawValue
                aClaim.insurer = "Austin Auto Insurance Pvt. Ltd."
            } else if self.insuranceTypeTextField.text == "Driver" {
                aClaim.insuranceType = IAInsuranceType.AutoDriver.rawValue
                aClaim.insurer = "Austin Insurance Pvt. Ltd."
            } else if self.insuranceTypeTextField.text == "Home" {
                aClaim.insuranceType = IAInsuranceType.Home.rawValue
                aClaim.insurer = "Austin Insurance Pvt. Ltd."
            } else if self.insuranceTypeTextField.text == "Boat" {
                aClaim.insuranceType = IAInsuranceType.Boat.rawValue
                aClaim.insurer = "Austin Insurance Pvt. Ltd."
            } else if self.insuranceTypeTextField.text == "Pet" {
                aClaim.insuranceType = IAInsuranceType.Pet.rawValue
                aClaim.insurer = "Austin Insurance Pvt. Ltd."
            }
            
            aClaim.dateOfClaim = aDateFormatter.string(from: Date())
            aClaim.insuredItemName = self.insuredItemTextField.text
            aClaim.status = IAClaimStatus.Report.rawValue
            aClaim.dateOfIncident = self.dateOfIncidentTextField.text!
            aClaim.incedentType = self.reasonTextField.text
            aClaim.value = "$"+self.estimatedValueTextField.text!
            aClaim.photoOne = self.addPhotoOneImageView.image
            aClaim.photoTwo = self.addPhotoTwoImageView.image
            aClaim.photoThree = self.addPhotoThreeImageView.image
            aClaim.policyNumber = "\(arc4random_uniform(8999) + 1000)"
            
            self.dataManager.fileClaim(aClaim)
        } catch IAError.generic(let pError){
            self.displayMessage(message: pError.localizedDescription, type: IAMessageType.error)
        } catch {
            self.displayMessage(message: "File claim error.", type: IAMessageType.error)
        }
    }
    
    
    @IBAction func didSelectDateOfIncidentCalendarButton() {
        self.dateOfIncidentTextField.displayDropdownList()
    }
    
    
    func didSelectAddPhotoOneContainerView() {
        self.imagePickerDestinationImageView = self.addPhotoOneImageView
        self.displayImagePicker()
    }
    
    
    func didSelectAddPhotoTwoContainerView() {
        self.imagePickerDestinationImageView = self.addPhotoTwoImageView
        self.displayImagePicker()
    }
    
    
    func didSelectAddPhotoThreeContainerView() {
        self.imagePickerDestinationImageView = self.addPhotoThreeImageView
        self.displayImagePicker()
    }
    
    
    func didSelectScanDocumentOneContainerView() {
        self.imagePickerDestinationImageView = self.scanDocumentOneImageView
        self.displayImagePicker()
    }
    
    
    func didSelectScanDocumentTwoContainerView() {
        self.imagePickerDestinationImageView = self.scanDocumentTwoImageView
        self.displayImagePicker()
    }
    
    
    func didSelectScanDocumentThreeContainerView() {
        self.imagePickerDestinationImageView = self.scanDocumentThreeImageView
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
    
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if var aPickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            aPickedImage = IAUtils.fixImageOrientation(aPickedImage)
            
            if self.imagePickerDestinationImageView != nil && self.imagePickerDestinationImageView.isEqual(self.addPhotoOneImageView)  {
                self.addPhotoOneImageView.image = aPickedImage
                self.addPhotoOneIconImageView.isHidden = true
                self.addPhotoOneLabel.isHidden = true
                self.addPhotoTwoContainerView.isHidden = false
            } else if self.imagePickerDestinationImageView != nil && self.imagePickerDestinationImageView.isEqual(self.addPhotoTwoImageView)  {
                self.addPhotoTwoImageView.image = aPickedImage
                self.addPhotoTwoIconImageView.isHidden = true
                self.addPhotoTwoLabel.isHidden = true
                self.addPhotoThreeContainerView.isHidden = false
            } else if self.imagePickerDestinationImageView != nil && self.imagePickerDestinationImageView.isEqual(self.addPhotoThreeImageView)  {
                self.addPhotoThreeImageView.image = aPickedImage
                self.addPhotoThreeIconImageView.isHidden = true
                self.addPhotoThreeLabel.isHidden = true
            } else if self.imagePickerDestinationImageView != nil && self.imagePickerDestinationImageView.isEqual(self.scanDocumentOneImageView) {
                self.scanDocumentOneImageView.image = aPickedImage
                self.scanDocumentOneIconImageView.isHidden = true
                self.scanDocumentOneLabel.isHidden = true
                self.scanDocumentTwoContainerView.isHidden = false
            } else if self.imagePickerDestinationImageView != nil && self.imagePickerDestinationImageView.isEqual(self.scanDocumentTwoImageView) {
                self.scanDocumentTwoImageView.image = aPickedImage
                self.scanDocumentTwoIconImageView.isHidden = true
                self.scanDocumentTwoLabel.isHidden = true
                self.scanDocumentThreeContainerView.isHidden = false
            } else if self.imagePickerDestinationImageView != nil && self.imagePickerDestinationImageView.isEqual(self.scanDocumentThreeImageView) {
                self.scanDocumentThreeImageView.image = aPickedImage
                self.scanDocumentThreeIconImageView.isHidden = true
                self.scanDocumentThreeLabel.isHidden = true
            }
        }
        self.assignScrollContentHeight()
        picker.dismiss(animated: true, completion: nil)
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
        } else if pSender.requestType == IARequestType.fileClaim {
            let anAlert = UIAlertController(title: "Claim filed successfully", message: nil, preferredStyle: .alert)
            anAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(action:UIAlertAction) in
                self.resetAllData()
                if IAConstants.homeController.claimsController != nil {
                    IAConstants.homeController.claimsController.reloadAllData()
                }
                if IAConstants.homeController.dashboardController != nil {
                    IAConstants.homeController.dashboardController.reloadAllData()
                }
            }))
            self.present(anAlert, animated: true, completion: nil)
        }
    }
}
