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
    case ListVehicles
    case VehicleDetails
    case AddDriver
    case ListDrivers
    case DriverDetails
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
    
    
    private func executeQuery(pQuery:String!, values pValues:Array<AnyObject>!) throws -> Array<Dictionary<String, AnyObject>>! {
        var aReturnVal :Array<Dictionary<String, AnyObject>>! = Array()
        
        do {
            var aDatabaseHandle: COpaquePointer = nil
            if sqlite3_open(IAConstants.dataManagerSqliteFilePath, &aDatabaseHandle) != SQLITE_OK {
                throw IAError.Generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Can not open database."]))
            }
            
            var anSqliteStatement: COpaquePointer = nil
            if sqlite3_prepare_v2(aDatabaseHandle, pQuery, -1, &anSqliteStatement, nil) == SQLITE_OK {
                if pValues != nil && pValues.count > 0 {
                    for anIndex in 0..<pValues.count {
                        let aValue = pValues[anIndex]
                        if aValue is String {
                            if sqlite3_bind_text(anSqliteStatement, Int32(anIndex + 1), (aValue as! NSString).UTF8String, -1, nil) != SQLITE_OK {
                                throw IAError.Generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Can not bind value."]))
                            }
                        } else if aValue is NSNumber {
                            if sqlite3_bind_int(anSqliteStatement, Int32(anIndex + 1), (aValue as! NSNumber).intValue) != SQLITE_OK {
                                throw IAError.Generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Can not bind value."]))
                            }
                        } else if aValue is NSNull {
                            if sqlite3_bind_null(anSqliteStatement, Int32(anIndex + 1)) != SQLITE_OK {
                                throw IAError.Generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Can not bind value."]))
                            }
                        }
                    }
                }
            } else {
                let anErrorMessage = String.fromCString(sqlite3_errmsg(aDatabaseHandle))
                throw IAError.Generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Can not prepare statement. Error: " + anErrorMessage!]))
            }
            
            while true {
                let anSqliteStepResult = sqlite3_step(anSqliteStatement)
                if anSqliteStepResult == SQLITE_ROW {
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
                } else if anSqliteStepResult == SQLITE_DONE {
                    break
                } else {
                    throw IAError.Generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Can not step statement."]))
                }
            }
            
            if sqlite3_finalize(anSqliteStatement) != SQLITE_OK {
                let anErrorMessage = String.fromCString(sqlite3_errmsg(aDatabaseHandle))
                throw IAError.Generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:String(format: "Can not finalize statement. Error: %@", anErrorMessage!)]))
            }
            
            defer {
                if aDatabaseHandle != nil {
                    sqlite3_close(aDatabaseHandle)
                }
            }
        } catch IAError.Generic(let pError){
            throw IAError.Generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:String(format: "Execute query error. %@", pError.localizedDescription)]))
        } catch {
            throw IAError.Generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Execute query error."]))
        }
        
        if aReturnVal.count <= 0 {
            aReturnVal = nil
        }
        
        return aReturnVal
    }
    
    
    private func sendRequest(pRequest:Any!) {
        let aDataManagerResponse :IADataManagerResponse = IADataManagerResponse()
        
        do {
            if self.requestType == IARequestType.Login {
                let aCustomer :IACustomer = pRequest as! IACustomer
                let anSqlQuery :String = String(format: "SELECT id AS CustomerID, first_name AS FirstName, last_name AS LastName, email_address AS EmailAddress, password as Password FROM customers WHERE email_address='%@'", aCustomer.emailAddress)
                let anSqlResult = try self.executeQuery(anSqlQuery, values: nil)
                if anSqlResult != nil && anSqlResult.count >= 1 {
                    let aDBCustomerDict :[String:AnyObject] = anSqlResult.first!
                    
                    let aDBCustomer = IACustomer()
                    aDBCustomer.customerID = String(format:"%d", (aDBCustomerDict["CustomerID"] as! NSNumber).integerValue)
                    aDBCustomer.emailAddress = String(aDBCustomerDict["EmailAddress"] as! String)
                    aDBCustomer.firstName = String(aDBCustomerDict["FirstName"] as! String)
                    aDBCustomer.lastName = String(aDBCustomerDict["LastName"] as! String)
                    
                    aDataManagerResponse.result = aDBCustomer
                } else {
                    throw IAError.Generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Email address is not registered."]))
                }
            } else if self.requestType == IARequestType.AddVehicle {
                let aVehicle :IAVehicle = pRequest as! IAVehicle
                let anSqlQuery :String = "INSERT INTO vehicles (license_plate_number, state) VALUES (?, ?)"
                var aValueArray = Array<AnyObject>()
                aValueArray.append(aVehicle.licensePlateNumber != nil ? aVehicle.licensePlateNumber : NSNull())
                aValueArray.append(aVehicle.state != nil ? aVehicle.state : NSNull())
                try self.executeQuery(anSqlQuery, values: aValueArray)
                aDataManagerResponse.result = aVehicle
            } else if self.requestType == IARequestType.ListVehicles {
                let anSqlQuery :String = "SELECT license_plate_number, state FROM vehicles"
                let anSqlResult = try self.executeQuery(anSqlQuery, values: nil)
                if anSqlResult != nil && anSqlResult.count > 0 {
                    var aVehicleArray :Array<IAVehicle>! = Array<IAVehicle>()
                    for var aDBVehicleDict :[String:AnyObject] in anSqlResult {
                        let aDBVehicle = IAVehicle()
                        aDBVehicle.licensePlateNumber = aDBVehicleDict["license_plate_number"] as! String
                        aDBVehicle.state = aDBVehicleDict["state"] as! String
                        aVehicleArray.append(aDBVehicle)
                    }
                    if aVehicleArray.count <= 0 {
                        aVehicleArray = nil
                    }
                    aDataManagerResponse.result = aVehicleArray
                }
            } else if self.requestType == IARequestType.AddDriver {
                let aDriver :IADriver = pRequest as! IADriver
                let anSqlQuery :String = "INSERT INTO drivers (first_name, last_name, relationship, dob, state, license, type, status, avatar) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)"
                var aValueArray = Array<AnyObject>()
                aValueArray.append(aDriver.firstName != nil ? aDriver.firstName : NSNull())
                aValueArray.append(aDriver.lastName != nil ? aDriver.lastName : NSNull())
                aValueArray.append(aDriver.relationship != nil ? aDriver.relationship : NSNull())
                aValueArray.append(aDriver.dob != nil ? aDriver.dob : NSNull())
                aValueArray.append(aDriver.state != nil ? aDriver.state : NSNull())
                aValueArray.append(aDriver.license != nil ? aDriver.license : NSNull())
                aValueArray.append(aDriver.type != nil ? aDriver.type : NSNull())
                aValueArray.append(aDriver.status != nil ? aDriver.status : NSNull())
                aValueArray.append(aDriver.avatar != nil ? aDriver.avatar : NSNull())
                try self.executeQuery(anSqlQuery, values: aValueArray)
                aDataManagerResponse.result = aDriver
            } else if self.requestType == IARequestType.ListDrivers {
                let anSqlQuery :String = "SELECT first_name, last_name, relationship, dob, state, license, type, status, avatar FROM drivers"
                let anSqlResult = try self.executeQuery(anSqlQuery, values: nil)
                if anSqlResult != nil && anSqlResult.count > 0 {
                    var aDriverArray :Array<IADriver>! = Array<IADriver>()
                    for var aDBDriverDict :[String:AnyObject] in anSqlResult {
                        let aDBDriver = IADriver()
                        aDBDriver.firstName = aDBDriverDict["first_name"] as! String
                        aDBDriver.lastName = aDBDriverDict["last_name"] as! String
                        aDBDriver.relationship = aDBDriverDict["relationship"] as! String
                        aDBDriver.dob   = aDBDriverDict["dob"] as! String
                        aDBDriver.state = aDBDriverDict["state"] as! String
                        aDBDriver.license = aDBDriverDict["license"] as! String
                        aDBDriver.type = aDBDriverDict["type"] as! String
                        aDBDriver.status = aDBDriverDict["status"] as! String
                   //     aDBDriver.avatar = aDBDriverDict["avatar"] as! String
                        aDriverArray.append(aDBDriver)
                    }
                    if aDriverArray.count <= 0 {
                        aDriverArray = nil
                    }
                    aDataManagerResponse.result = aDriverArray
                }
            }

        } catch IAError.Generic(let pError){
            aDataManagerResponse.error = NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:pError.localizedDescription])
        } catch {
            aDataManagerResponse.error = NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Send request error."])
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
    
    
    internal func listVehicles() {
        self.requestType = IARequestType.ListVehicles
        self.sendRequest(nil)
    }
    
    
    internal func addDriver(pDriver :IADriver) {
        self.requestType = IARequestType.AddDriver
        self.sendRequest(pDriver)
    }
    
    
    internal func listDrivers() {
        self.requestType = IARequestType.ListDrivers
        self.sendRequest(nil)
    }
    
    
    internal func driverDetails(pDriverID :String) {
        self.requestType = IARequestType.DriverDetails
    }
    
}
