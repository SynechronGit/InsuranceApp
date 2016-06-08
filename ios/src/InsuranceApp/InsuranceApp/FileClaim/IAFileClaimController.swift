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
    
    @IBOutlet weak var addPhotoContainerView: UIView!
    @IBOutlet weak var addPhotoImageView: UIImageView!
    @IBOutlet weak var addPhotoIconImageView: UIImageView!
    @IBOutlet weak var addPhotoLabel: UILabel!
    
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
        
        self.submitContainerView.layer.cornerRadius = IAConstants.dashboardSubviewCornerRadius
        self.submitContainerView.layer.masksToBounds = true
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
        } catch IAError.Generic(let pError){
            self.displayMessage(message: pError.localizedDescription, type: IAMessageType.Error)
        } catch {
            self.displayMessage(message: "File claim error.", type: IAMessageType.Error)
        }
    }
    
    
    func didSelectAddPhotoContainerView() {
        self.imagePickerDestinationImageView = self.addPhotoImageView
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
            if self.imagePickerDestinationImageView != nil && self.imagePickerDestinationImageView.isEqual(self.addPhotoImageView)  {
                self.addPhotoImageView.image = aPickedImage
            } else if self.imagePickerDestinationImageView != nil && self.imagePickerDestinationImageView.isEqual(self.scanDocumentImageView) {
                self.scanDocumentImageView.image = aPickedImage
            }
        }
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
}
