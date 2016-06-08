//
//  IAFileClaimController.swift
//  InsuranceApp
//
//  Created by rupendra on 6/1/16.
//  Copyright © 2016 com. All rights reserved.
//

import UIKit

class IAFileClaimController: IABaseController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    @IBOutlet weak var fileClaimContainerView: UIView!
    
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
    
    @IBOutlet weak var scanDocumentContainerView: UIView!
    @IBOutlet weak var scanDocumentImageView: UIImageView!
    @IBOutlet weak var scanDocumentIconImageView: UIImageView!
    @IBOutlet weak var scanDocumentLabel: UILabel!
    
    var imagePickerController :UIImagePickerController!
    weak var imagePickerDestinationImageView: UIImageView!
    
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
        
        self.addPhotoThreeContainerView.layer.cornerRadius = IAConstants.dashboardSubviewCornerRadius
        self.addPhotoThreeContainerView.layer.masksToBounds = true
        aTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(IAFileClaimController.didSelectAddPhotoThreeContainerView))
        aTapGestureRecognizer.cancelsTouchesInView = false
        self.addPhotoThreeContainerView.addGestureRecognizer(aTapGestureRecognizer)
        
        self.scanDocumentContainerView.layer.cornerRadius = IAConstants.dashboardSubviewCornerRadius
        self.scanDocumentContainerView.layer.masksToBounds = true
        aTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(IAFileClaimController.didSelectScanDocumentContainerView))
        aTapGestureRecognizer.cancelsTouchesInView = false
        self.scanDocumentContainerView.addGestureRecognizer(aTapGestureRecognizer)
        
        self.insuranceTypeTextField.shouldDisplayAsDropdown = true
        self.insuranceTypeTextField.delegate = self
        self.insuranceTypeTextField.controller = self
        self.insuranceTypeTextField.list = ["Vehicle", "Driver", "Home", "Boat", "Pet"]
        
        self.insuredItemTextField.shouldDisplayAsDropdown = true
        self.insuredItemTextField.controller = self
        self.insuredItemTextField.list = nil
        
        self.reasonTextField.shouldDisplayAsDropdown = true
        self.reasonTextField.controller = self
        self.reasonTextField.list = nil
        
        self.dateOfIncidentTextField.shouldDisplayAsDatePicker = true
        self.dateOfIncidentTextField.controller = self
        self.dateOfIncidentTextField.delegate = self
        
        self.submitContainerView.layer.cornerRadius = IAConstants.dashboardSubviewCornerRadius
        self.submitContainerView.layer.masksToBounds = true
        aTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(IAFileClaimController.didSelectSubmitButton))
        aTapGestureRecognizer.cancelsTouchesInView = false
        self.submitContainerView.addGestureRecognizer(aTapGestureRecognizer)
    }
    
    
    func resetAllData() {
        self.insuranceTypeTextField.text = nil
        self.insuredItemTextField.text = nil
        self.reasonTextField.text = nil
        self.estimatedValueTextField.text = nil
        self.dateOfIncidentTextField.text = nil
        self.descriptionTextView.text = nil
    }
    
    
    func textFieldDidEndEditing(textField: UITextField) {
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
    
    
    // MARK: - Selector Methods
    
    /**
     * Selector method that will be called when Submit button is tapped.
     * @return Void
     */
    func didSelectSubmitButton() {
        do {
            if self.insuranceTypeTextField.text == nil || self.insuranceTypeTextField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) <= 0 {
                throw IAError.Generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Please select insurance type."]))
            }
            
            IAAppDelegate.currentAppDelegate.displayLoadingOverlay()
            
            let aDateFormatter = NSDateFormatter()
            aDateFormatter.locale = NSLocale(localeIdentifier: "US_en")
            aDateFormatter.dateFormat = "MM-dd-yyyy"
            
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
            
            aClaim.dateOfClaim = aDateFormatter.stringFromDate(NSDate())
            aClaim.insuredItemName = self.insuredItemTextField.text
            aClaim.status = IAClaimStatus.Report.rawValue
            aClaim.dateOfIncident = self.dateOfIncidentTextField.text!
            aClaim.incedentType = self.reasonTextField.text
            aClaim.value = self.estimatedValueTextField.text
            aClaim.photoOne = self.addPhotoOneImageView.image
            aClaim.photoTwo = self.addPhotoTwoImageView.image
            aClaim.photoThree = self.addPhotoThreeImageView.image
            
            self.dataManager.fileClaim(aClaim)
        } catch IAError.Generic(let pError){
            self.displayMessage(message: pError.localizedDescription, type: IAMessageType.Error)
        } catch {
            self.displayMessage(message: "File claim error.", type: IAMessageType.Error)
        }
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
    
    
    func didSelectScanDocumentContainerView() {
        self.imagePickerDestinationImageView = self.scanDocumentImageView
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
    
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let aPickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            if self.imagePickerDestinationImageView != nil && self.imagePickerDestinationImageView.isEqual(self.addPhotoOneImageView)  {
                self.addPhotoOneImageView.image = aPickedImage
                self.addPhotoOneIconImageView.hidden = true
                self.addPhotoOneLabel.hidden = true
            } else if self.imagePickerDestinationImageView != nil && self.imagePickerDestinationImageView.isEqual(self.addPhotoTwoImageView)  {
                self.addPhotoTwoImageView.image = aPickedImage
                self.addPhotoTwoIconImageView.hidden = true
                self.addPhotoTwoLabel.hidden = true
            } else if self.imagePickerDestinationImageView != nil && self.imagePickerDestinationImageView.isEqual(self.addPhotoThreeImageView)  {
                self.addPhotoThreeImageView.image = aPickedImage
                self.addPhotoThreeIconImageView.hidden = true
                self.addPhotoThreeLabel.hidden = true
            } else if self.imagePickerDestinationImageView != nil && self.imagePickerDestinationImageView.isEqual(self.scanDocumentImageView) {
                self.scanDocumentImageView.image = aPickedImage
                self.scanDocumentIconImageView.hidden = true
                self.scanDocumentLabel.hidden = true
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
        } else if pSender.requestType == IARequestType.FileClaim {
            let anAlert = UIAlertController(title: "Claim filed successfully", message: nil, preferredStyle: .Alert)
            anAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: {(action:UIAlertAction) in
                if IAConstants.homeController.claimsController != nil {
                    IAConstants.homeController.claimsController.reloadAllData()
                }
                self.resetAllData()
            }))
            self.presentViewController(anAlert, animated: true, completion: nil)
        }
    }
}
