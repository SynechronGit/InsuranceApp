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
    case AddVehicle
}


/*
 * Model to hold server response data.
 */
class IADataManagerResponse: NSObject {
    var result: Any!
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
    
    
    private func executeQuery(pQuery:String!) -> Array<Dictionary<String, AnyObject>>! {
        var aReturnVal :Array<Dictionary<String, AnyObject>>! = Array()
        
        do {
            var aDatabaseHandle: COpaquePointer = nil
            if sqlite3_open(IAConstants.dataManagerSqliteFilePath, &aDatabaseHandle) != SQLITE_OK {
                throw IAError.Generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Can not open database."]))
            }
            
            var anSqliteStatement: COpaquePointer = nil
            if sqlite3_prepare_v2(aDatabaseHandle, pQuery, -1, &anSqliteStatement, nil) != SQLITE_OK {
                let anErrorMessage = String.fromCString(sqlite3_errmsg(aDatabaseHandle))
                throw IAError.Generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Can not prepare statement. Error: " + anErrorMessage!]))
            }
            
            while sqlite3_step(anSqliteStatement) == SQLITE_ROW {
                let aColumnCount :Int = Int(sqlite3_column_count(anSqliteStatement))
                
                var aRow = Dictionary<String, AnyObject>()
                for aColumnIndex in 0..<aColumnCount {
                    let aColumnName :String! = String.fromCString(UnsafePointer<CChar>(sqlite3_column_name(anSqliteStatement, Int32(aColumnIndex))))
                    
                    let aColumnType :Int32 = sqlite3_column_type(anSqliteStatement, Int32(aColumnIndex))
                    
                    var aColumnValue :AnyObject!
                    if aColumnType == SQLITE_INTEGER {
                        aColumnValue = NSNumber(int: sqlite3_column_int(anSqliteStatement, Int32(aColumnIndex)))
                    } else if aColumnType == SQLITE_FLOAT {
                        aColumnValue = NSNumber(double: sqlite3_column_double(anSqliteStatement, Int32(aColumnIndex)))
                    } else if aColumnType == SQLITE_BLOB {
                        let aDataLength = Int(sqlite3_column_bytes(anSqliteStatement, Int32(aColumnIndex)))
                        aColumnValue = NSData(bytes: sqlite3_column_blob(anSqliteStatement, Int32(aColumnIndex)), length: aDataLength)
                    } else if aColumnType == SQLITE_NULL {
                        aColumnValue = NSNull()
                    } else if aColumnType == SQLITE_TEXT || aColumnType == SQLITE3_TEXT {
                        aColumnValue = String.fromCString(UnsafePointer<CChar>(sqlite3_column_text(anSqliteStatement, Int32(aColumnIndex))))
                    }
                    aRow.updateValue(aColumnValue, forKey: aColumnName)
                }
                if aRow.count > 0 {
                    aReturnVal.append(aRow)
                }
            }
            
            if sqlite3_finalize(anSqliteStatement) != SQLITE_OK {
                let anErrorMessage = String.fromCString(sqlite3_errmsg(aDatabaseHandle))
                throw IAError.Generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Can not finalize statement. Error: " + anErrorMessage!]))
            }
        } catch IAError.Generic(let pMessage){
            NSLog("Execute query error. %@", pMessage)
        } catch {
            NSLog("Execute query error.")
        }
        
        return aReturnVal
    }
    
    
    private func sendRequest(pRequest:Any!) {
        let aDataManagerResponse :IADataManagerResponse = IADataManagerResponse()
        
        if self.requestType == IARequestType.Login {
            let aCustomer :IACustomer = pRequest as! IACustomer
            let anSqlQuery :String = String(format: "SELECT id AS CustomerID, first_name AS FirstName, last_name AS LastName, email_address AS EmailAddress, password as Password FROM customers WHERE email_address='%@'", aCustomer.emailAddress)
            let anSqlResult = self.executeQuery(anSqlQuery)
            if anSqlResult != nil && anSqlResult.count >= 1 {
                let aDBCustomerDict :[String:AnyObject] = anSqlResult.first!
                
                let aDBCustomer = IACustomer()
                aDBCustomer.customerID = String(format:"%d", (aDBCustomerDict["CustomerID"] as! NSNumber).integerValue)
                aDBCustomer.emailAddress = String(aDBCustomerDict["EmailAddress"] as! String)
                aDBCustomer.firstName = String(aDBCustomerDict["FirstName"] as! String)
                aDBCustomer.lastName = String(aDBCustomerDict["LastName"] as! String)
                
                aDataManagerResponse.result = aDBCustomer
            } else {
                aDataManagerResponse.error = NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Email address is not registered."])
            }
        } else if self.requestType == IARequestType.AddVehicle {
            let aVehicle :IAVehicle = pRequest as! IAVehicle
            let anSqlQuery :String = String(format: "INSERT INTO vehicles (licensePlateNumber, state, photo) VALUES ('%@', '%@', NULL)", aVehicle.licensePlateNumber, aVehicle.state)
            let anSqlResult = self.executeQuery(anSqlQuery)
            if anSqlResult != nil && anSqlResult.count >= 1 {
                
                aDataManagerResponse.result = aVehicle
            } else {
                aDataManagerResponse.error = NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Can not insert vehicle."])
            }
        }
        
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
        self.sendRequest(pCustomer)
    }
    
    
    internal func addVehicle(pVehicle :IAVehicle) {
        self.requestType = IARequestType.AddVehicle
        self.sendRequest(pVehicle)
    }
}
