//
//  IAAddDriverController.swift
//  InsuranceApp
//

import UIKit


/**
 * Controller for Add Driver screen.
 */
class IAAddDriverController: IABaseController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, IADropdownListControllerDelegate{
    @IBOutlet weak var addPhotoContainerView: UIView!
    @IBOutlet weak var driverPhotoImageView: UIImageView!
    @IBOutlet weak var driverPhotoIconImageView: UIImageView!
    @IBOutlet weak var driverPhotoLabel: UILabel!
    
    @IBOutlet weak var takeLicensePhotoContainerView: UIView!
    @IBOutlet weak var licensePhotoImageView: UIImageView!
    @IBOutlet weak var licensePhotoIconImageView: UIImageView!
    @IBOutlet weak var licensePhotoLabel: UILabel!
    
    var imagePickerController :UIImagePickerController!
    weak var imagePickerDestinationImageView: UIImageView!
    var dropdownListController :IADropdownListController!
    
    @IBOutlet weak var nameTextField: IATextField!
    @IBOutlet weak var phoneNumberTextField: IATextField!
    @IBOutlet weak var emailAddressTextField: IATextField!
    @IBOutlet weak var streetAddressTextField: IATextField!
    @IBOutlet weak var cityTextField: IATextField!
    @IBOutlet weak var stateTextField: IATextField!
    @IBOutlet weak var zipTextField: IATextField!
    @IBOutlet weak var dobTextField: IATextField!
    @IBOutlet weak var licenseNumberTextField: IATextField!
    @IBOutlet weak var appointedSinceTextField: IATextField!
    @IBOutlet weak var drivingExperienceTextField: IATextField!
    @IBOutlet weak var employeeTypeTextField: IATextField!
    
    @IBOutlet weak var addContainerView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Add Driver"
        
        self.addPhotoContainerView.layer.cornerRadius = IAConstants.dashboardSubviewCornerRadius
        self.addPhotoContainerView.layer.masksToBounds = true
        var aTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(IAAddDriverController.didSelectAddPhotoContainerView))
        aTapGestureRecognizer.cancelsTouchesInView = false
        self.addPhotoContainerView.addGestureRecognizer(aTapGestureRecognizer)
        
        self.takeLicensePhotoContainerView.layer.cornerRadius = IAConstants.dashboardSubviewCornerRadius
        self.takeLicensePhotoContainerView.layer.masksToBounds = true
        aTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(IAAddDriverController.didSelectTakeLicensePhotoContainerView))
        aTapGestureRecognizer.cancelsTouchesInView = false
        self.takeLicensePhotoContainerView.addGestureRecognizer(aTapGestureRecognizer)
        
        self.addContainerView.layer.cornerRadius = IAConstants.dashboardSubviewCornerRadius
        self.addContainerView.layer.masksToBounds = true
        aTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(IAAddDriverController.didSelectAddButton(_:)))
        aTapGestureRecognizer.cancelsTouchesInView = false
        self.addContainerView.addGestureRecognizer(aTapGestureRecognizer)
        
        self.cityTextField.shouldDisplayAsDropdown = true
        self.cityTextField.controller = self
        self.cityTextField.list = nil
        
        self.stateTextField.shouldDisplayAsDropdown = true
        self.stateTextField.controller = self
        self.stateTextField.delegate = self
        self.stateTextField.list = ["Florida", "New York", "California"]
        
        self.dobTextField.shouldDisplayAsDatePicker = true
        self.dobTextField.controller = self
        self.dobTextField.delegate = self
        self.dobTextField.minimumDate = NSDate().dateByAddingTimeInterval(-100 * 365 * 24 * 60 * 60)
        self.dobTextField.maximumDate = NSDate()
        
        self.appointedSinceTextField.shouldDisplayAsDropdown = true
        self.appointedSinceTextField.controller = self
        self.appointedSinceTextField.list = nil
        
        self.drivingExperienceTextField.shouldDisplayAsDropdown = true
        self.drivingExperienceTextField.controller = self
        self.drivingExperienceTextField.list = nil
        
        self.employeeTypeTextField.shouldDisplayAsDropdown = true
        self.employeeTypeTextField.controller = self
        self.employeeTypeTextField.list = ["None", "Full Time", "Part Time"]
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField.isEqual(self.nameTextField) {
            self.phoneNumberTextField.becomeFirstResponder()
        } else if textField.isEqual(self.phoneNumberTextField) {
            self.emailAddressTextField.becomeFirstResponder()
        } else if textField.isEqual(self.emailAddressTextField) {
            self.streetAddressTextField.becomeFirstResponder()
        } else if textField.isEqual(self.streetAddressTextField) {
            self.streetAddressTextField.resignFirstResponder()
            self.stateTextField.displayDropdownList()
        } else if textField.isEqual(self.zipTextField) {
            self.zipTextField.resignFirstResponder()
            self.dobTextField.displayDropdownList()
        } else if textField.isEqual(self.licenseNumberTextField) {
            self.licenseNumberTextField.resignFirstResponder()
            self.appointedSinceTextField.displayDropdownList()
        }
        
        return true
    }
    
    
    func textFieldDidEndEditing(textField: UITextField) {
        if textField.isEqual(self.stateTextField) {
            self.cityTextField.text = nil
            if self.stateTextField.text == "Florida" {
                self.cityTextField.list = ["Jacksonville", "Miami", "Tampa", "Orlando", "St. Petersburg"]
            } else if self.stateTextField.text == "New York" {
                self.cityTextField.list = ["New York", "Buffalo", "Rochester", "Yonkers", "Syracuse"]
            } else if self.stateTextField.text == "California" {
                self.cityTextField.list = ["Los Angeles", "San Diego", "San Jose", "San Francisco", "Fresno"]
            } else {
                self.cityTextField.list = nil
            }
        } else if textField.isEqual(self.dobTextField) {
            if self.dobTextField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0 {
                let aDateOfBirth = NSDate.dateFromString(self.dobTextField.text!, format: IAConstants.dateFormatAppStandard)
                
                var anAppointedSinceArray = Array<String>()
                anAppointedSinceArray.append("None")
                if aDateOfBirth.year < NSDate().year {
                    for anIndex:Int in aDateOfBirth.year ..< NSDate().year {
                        anAppointedSinceArray.append(String(format: "%d", anIndex + 1))
                    }
                }
                self.appointedSinceTextField.list = anAppointedSinceArray
                
                let aMaxExperience = NSDate().year - aDateOfBirth.year
                var aDrivingExperienceArray = Array<String>()
                aDrivingExperienceArray.append("Unknown")
                if 0 < aMaxExperience {
                    for anIndex:Int in 0 ..< aMaxExperience {
                        aDrivingExperienceArray.append(String(format: "%02d Years", anIndex + 1))
                    }
                }
                self.drivingExperienceTextField.list = aDrivingExperienceArray
            }
        }
    }
    
    
    func didSelectAddPhotoContainerView() {
        self.imagePickerDestinationImageView = self.driverPhotoImageView
        self.displayImagePicker()
    }
    
    
    func didSelectTakeLicensePhotoContainerView() {
        self.imagePickerDestinationImageView = self.licensePhotoImageView
        self.displayImagePicker()
    }
    
    
    @IBAction func didSelectDobCalendarButton() {
        self.dobTextField.displayDropdownList()
    }
    
    
    @IBAction func didSelectAppointedSinceCalendarButton() {
        self.appointedSinceTextField.displayDropdownList()
    }
    
    
    func displayImagePicker() {
        if self.dropdownListController == nil {
            self.dropdownListController  = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("IADropdownListControllerID") as! IADropdownListController
        }
        self.dropdownListController.delegate = self
        self.dropdownListController.list = ["Camera", "Photo Album"]
        self.dropdownListController.preferredContentSize = CGSizeMake(200.0, 80.0)
        self.dropdownListController.modalPresentationStyle = .Popover
        self.dropdownListController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.Any
        self.dropdownListController.popoverPresentationController?.sourceView = self.imagePickerDestinationImageView
        self.dropdownListController.popoverPresentationController?.sourceRect = self.imagePickerDestinationImageView.bounds
        self.presentViewController(self.dropdownListController, animated: true, completion: nil)
    }
    
    
    func dropdownListController(pDropdownListController:IADropdownListController, didSelectValue pValue:String) {
        pDropdownListController.dismissViewControllerAnimated(false, completion: nil)
        
        if self.imagePickerController == nil {
            self.imagePickerController = UIImagePickerController()
        }
        self.imagePickerController.allowsEditing = false
        self.imagePickerController.delegate = self
        self.imagePickerController.modalPresentationStyle = UIModalPresentationStyle.FormSheet
        
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            self.imagePickerController.sourceType = .PhotoLibrary
        #else
            if pValue == "Camera" {
                self.imagePickerController.sourceType = .Camera
            } else if pValue == "Photo Album" {
                self.imagePickerController.sourceType = .PhotoLibrary
            }
        #endif
        
        self.presentViewController(self.imagePickerController, animated: true, completion: nil)
    }
    
    
    @IBAction func didSelectAddButton(sender: AnyObject) {
        do {
            self.view.endEditing(true)
            
            if self.driverPhotoImageView.image == nil {
                throw IAError.Generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Please provide driver's photo."]))
            }
            
            if self.licensePhotoImageView.image == nil {
                throw IAError.Generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Please provide license photo."]))
            }
            
            // Name Validations
            
            if self.nameTextField.text == nil || self.nameTextField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) <= 0 {
                throw IAError.Generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Please enter name."]))
            }
            
            if self.nameTextField.text != nil && self.nameTextField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0 {
                if try IAUtils.doesRegexMatch("[^A-Za-z ]", subject: self.nameTextField.text!) == true {
                    throw IAError.Generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Name contains invalid characters."]))
                }
            }
            
            if self.nameTextField.text != nil && self.nameTextField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 25 {
                throw IAError.Generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Name should not be greater than 25 characters."]))
            }
            
            // Phone Number Validations
            
            if self.phoneNumberTextField.text == nil || self.phoneNumberTextField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) <= 0 {
                throw IAError.Generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Please enter phone number."]))
            }
            
            if self.phoneNumberTextField.text != nil && self.phoneNumberTextField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0 {
                if try IAUtils.doesRegexMatch("[^0-9]", subject: self.phoneNumberTextField.text!) == true {
                    throw IAError.Generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Phone number contains invalid characters."]))
                }
            }
            
            if self.phoneNumberTextField.text != nil && self.phoneNumberTextField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 15 {
                throw IAError.Generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Phone number should not be greater than 15 digits."]))
            }
            
            // Email Address Validations
            
            if self.emailAddressTextField.text == nil || self.emailAddressTextField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) <= 0 {
                throw IAError.Generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Please enter email address."]))
            }
            
            if self.emailAddressTextField.text != nil && self.emailAddressTextField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0 {
                if try IAUtils.doesRegexMatch("[^A-Za-z0-9@\\-\\._]", subject: self.emailAddressTextField.text!) == true {
                    throw IAError.Generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Email address contains invalid characters."]))
                }
            }
            
            if self.emailAddressTextField.text != nil && self.emailAddressTextField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 50 {
                throw IAError.Generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Email address should not be greater than 50 characters."]))
            }
            
            // Street Address Validations
            
            if self.streetAddressTextField.text == nil || self.streetAddressTextField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) <= 0 {
                throw IAError.Generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Please enter street address."]))
            }
            
            if self.streetAddressTextField.text != nil && self.streetAddressTextField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 100 {
                throw IAError.Generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Street address should not be greater than 100 characters."]))
            }
            
            // Zip Code Validations
            
            if self.zipTextField.text == nil || self.zipTextField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) <= 0 {
                throw IAError.Generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Please enter zip code."]))
            }
            
            if self.zipTextField.text != nil && self.zipTextField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0 {
                if try IAUtils.doesRegexMatch("[^0-9]", subject: self.zipTextField.text!) == true {
                    throw IAError.Generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Zip code contains invalid characters."]))
                }
            }
            
            if self.zipTextField.text != nil && self.zipTextField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) != 5 {
                throw IAError.Generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Zip code should be of 5 digits."]))
            }
            
            let aDriver = IADriver()
            aDriver.avatar = self.driverPhotoImageView.image
            aDriver.licensePhoto = self.licensePhotoImageView.image
            aDriver.fullName = self.nameTextField.text!
            aDriver.phoneNumber = self.phoneNumberTextField.text!
            aDriver.emailAddress =  self.emailAddressTextField.text!
            aDriver.streetAddress = self.streetAddressTextField.text!
            aDriver.city = self.cityTextField.text!
            aDriver.state = self.stateTextField.text!
            aDriver.zip = self.zipTextField.text!
            aDriver.dob = self.dobTextField.text!
            aDriver.licenseNumber = self.licenseNumberTextField.text!
            aDriver.appointedSince = self.appointedSinceTextField.text!
            aDriver.drivingExperience = self.drivingExperienceTextField.text!
            aDriver.employeeType = self.employeeTypeTextField.text!
            
            IAAppDelegate.currentAppDelegate.displayLoadingOverlay()
            self.dataManager.addDriver(aDriver)
        } catch IAError.Generic(let pError){
            self.displayMessage(message: pError.localizedDescription, type: IAMessageType.Error)
        } catch {
            self.displayMessage(message: "Add driver error.", type: IAMessageType.Error)
        }
    }
    
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if var aPickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            aPickedImage = IAUtils.fixImageOrientation(aPickedImage)
            
            if self.imagePickerDestinationImageView != nil && self.imagePickerDestinationImageView.isEqual(self.driverPhotoImageView)  {
                self.driverPhotoImageView.image = aPickedImage
                self.driverPhotoIconImageView.hidden = true
                self.driverPhotoLabel.hidden = true
            } else if self.imagePickerDestinationImageView != nil && self.imagePickerDestinationImageView.isEqual(self.licensePhotoImageView)  {
                self.licensePhotoImageView.image = aPickedImage
                self.licensePhotoIconImageView.hidden = true
                self.licensePhotoLabel.hidden = true
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
        } else if pSender.requestType == IARequestType.AddDriver {
            let anAlert = UIAlertController(title: "Driver added successfully. Do you want to add more drivers?", message: nil, preferredStyle: .Alert)
            anAlert.addAction(UIAlertAction(title: "Yes", style: .Default, handler : {(action:UIAlertAction) in
                
                self.driverPhotoImageView.image = nil
                self.licensePhotoImageView.image = nil
                self.driverPhotoIconImageView.hidden = false
                self.driverPhotoLabel.hidden = false
                self.licensePhotoIconImageView.hidden = false
                self.licensePhotoLabel.hidden = false
                self.nameTextField.text! = ""
                self.phoneNumberTextField.text! = ""
                self.emailAddressTextField.text! = ""
                self.streetAddressTextField.text! = ""
                self.cityTextField.text! = ""
                self.stateTextField.text! = ""
                self.zipTextField.text! = ""
                self.dobTextField.text! = ""
                self.licenseNumberTextField.text! = ""
                self.appointedSinceTextField.text! = ""
                self.drivingExperienceTextField.text! = ""
                self.employeeTypeTextField.text! = ""
                
                }))

            anAlert.addAction(UIAlertAction(title: "No", style: .Default, handler: {(action:UIAlertAction) in
                self.navigationController?.popViewControllerAnimated(true)
            }))
            self.presentViewController(anAlert, animated: true, completion: nil)
        }
    }

}
