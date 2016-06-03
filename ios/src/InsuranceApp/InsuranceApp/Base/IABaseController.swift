//
//  IABaseController.swift
//  InsuranceApp
//

import UIKit


/**
 * Controller as a base for other controllers. It implements all the common functionalities.
 */
class IABaseController: UIViewController, IADataManagerDelegate {
    var dataManager: IADataManager!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataManager = IADataManager()
        self.dataManager.delegate = self
        
        let anImageView = UIImageView(frame: CGRectMake(0.0, 0.0, 15.0, 15.0))
        anImageView.image = UIImage(named: "SearchIcon")
        let aRightBarButtonItem = UIBarButtonItem(customView: anImageView)
        self.navigationItem.rightBarButtonItem = aRightBarButtonItem
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.Plain, target:nil, action:nil)
    }
    
    
    /**
     * Method that displays message as per given message type
     * @param: pMessage. String. Message that should be displayed.
     * @param: pType. IAMessageType. Message type that should be displayed.
     */
    internal func displayMessage(message pMessage: String, type pType: IAMessageType) {
        let anAlert = UIAlertController(title: pMessage, message: nil, preferredStyle: .Alert)
        let anOkAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        anAlert.addAction(anOkAction)
        presentViewController(anAlert, animated: true, completion: nil)
    }
    
    
    // MARK: - IADataManagerDelegate Methods
    
    /**
     * IADataManagerDelegate method. It is implemented to handle response sent by IADataManager.
     */
    internal func aiDataManagerDidFail(sender pSender:IADataManager, error pError: NSError) {
        IAAppDelegate.currentAppDelegate.hideLoadingOverlay()
        self.displayMessage(message: pError.localizedDescription, type: IAMessageType.Error)
    }
    
    
    /**
     * IADataManagerDelegate method. It is implemented to handle response sent by IADataManager.
     */
    internal func aiDataManagerDidSucceed(sender pSender:IADataManager, response pResponse: IADataManagerResponse) {
    }
}
