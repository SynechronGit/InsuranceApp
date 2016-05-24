//
//  IADataManager.swift
//  InsuranceApp
//
//  Created by rupendra on 5/24/16.
//  Copyright © 2016 com. All rights reserved.
//

import UIKit


/*
 * Enum to define different request types.
 */
public enum IARequestType: Int {
    case Login
}


/*
 * Model to hold server response data.
 */
class IADataManagerResponse: NSObject {
    var result: AnyObject!
    var error: NSError!
}


/*
 * Protocol to give success and failure callbacks.
 */
@objc protocol IADataManagerDelegate {
    optional func aiDataManagerDidSucceed(sender pSender:IADataManager, response pResponse: IADataManagerResponse)
    optional func aiDataManagerDidFail(sender pSender:IADataManager, error pError: NSError)
}


/*
 * Class to handle all the data related requests.
 */
class IADataManager: NSObject {
    var requestType :IARequestType!
    var delegate :IADataManagerDelegate?
    
    
    private func sendRequest(pRequest:AnyObject!) {
        var aResponseBody: String!
        
        if self.requestType == IARequestType.Login {
            aResponseBody = "{ \"id\": 1, \"name\": \"Jason Mark\", \"emailAddress\": \"jason.mark@example.com\" }"
        }
        
        let aDataManagerResponse = IADataManager.mapResponse(responseBody: aResponseBody, requestType: self.requestType)
        let aDelayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(IAConstants.dataManagerResponseDelayInSeconds * Double(NSEC_PER_SEC)))
        dispatch_after(aDelayTime, dispatch_get_main_queue()) {
            self.delegate?.aiDataManagerDidSucceed!(sender: self, response: aDataManagerResponse)
        }
    }
    
    
    // MARK: Response Mapper Methods
    internal static func mapResponse(responseBody pResponseBody:String, requestType pRequestType:IARequestType) -> IADataManagerResponse {
        let aReturnVal = IADataManagerResponse()
        
        do {
            let aResponseDict = try NSJSONSerialization.JSONObjectWithData(pResponseBody.dataUsingEncoding(NSUTF8StringEncoding)!, options: NSJSONReadingOptions.AllowFragments)
            
            if pRequestType == IARequestType.Login {
                if aResponseDict.isKindOfClass(NSDictionary) {
                    let aPatient = IACustomer(dictionary: (aResponseDict as? NSDictionary)!)
                    aReturnVal.result = aPatient
                } else {
                    aReturnVal.error = NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Can not sign in.", NSLocalizedFailureReasonErrorKey:aResponseDict])
                }
            }
        } catch {
            aReturnVal.error = NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Map response error."])
        }
        
        return aReturnVal
    }
    
    
    // MARK:- Request Methods
    
    internal func login(pCustomer :IACustomer) {
        self.requestType = IARequestType.Login
        self.sendRequest(nil)
    }
}
