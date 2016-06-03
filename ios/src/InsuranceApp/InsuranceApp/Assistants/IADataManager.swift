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
    case DashboardDetails
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
                        } else if aValue is NSData {
                            if sqlite3_bind_blob(anSqliteStatement, Int32(anIndex + 1), (aValue as! NSData).bytes, Int32((aValue as! NSData).length), nil) != SQLITE_OK {
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
            } else if self.requestType == IARequestType.DashboardDetails {
                let aDashboardDetails :IADashboard = IADashboard()
                
                aDashboardDetails.autoInsuranceCarCount = 7
                aDashboardDetails.autoInsuranceDriverCount = 7
                
                aDashboardDetails.homeInsuranceApplianceCount = 16
                aDashboardDetails.homeInsuranceFurnitureCount = 32
                aDashboardDetails.homeInsuranceCurtainCount = 24
                aDashboardDetails.homeInsuranceCrockeryCount = 56
                
                aDashboardDetails.boatInsuranceYatchCount = 3
                aDashboardDetails.boatInsuranceSkipperCount = 3
                aDashboardDetails.boatInsuranceEquipmentCount = 16
                aDashboardDetails.boatInsuranceLossCount = 2
                
                aDashboardDetails.petInsuranceDogCount = 3
                aDashboardDetails.petInsuranceCatCount = 1
                
                aDashboardDetails.claimCount = 4
                aDashboardDetails.premiumCount = 2
                
                aDataManagerResponse.result = aDashboardDetails
            } else if self.requestType == IARequestType.AddVehicle {
                let aVehicle :IAVehicle = pRequest as! IAVehicle
                var aPhotoOneData :NSData! = nil
                if aVehicle.photoOne != nil {
                    aPhotoOneData = UIImagePNGRepresentation(aVehicle.photoOne)
                }
                var aPhotoTwoData :NSData! = nil
                if aVehicle.photoTwo != nil {
                    aPhotoTwoData = UIImagePNGRepresentation(aVehicle.photoTwo)
                }
                var aPhotoThreeData :NSData! = nil
                if aVehicle.photoThree != nil {
                    aPhotoThreeData = UIImagePNGRepresentation(aVehicle.photoThree)
                }
                let anSqlQuery :String = "INSERT INTO vehicles (vin, year, company, model_number, body_style, description, photo_one, photo_two, photo_three, comprehensive_coverage, collision_coverage) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
                var aValueArray = Array<AnyObject>()
                aValueArray.append(aVehicle.vin != nil ? aVehicle.vin : NSNull())
                aValueArray.append(aVehicle.year != nil ? aVehicle.year : NSNull())
                aValueArray.append(aVehicle.company != nil ? aVehicle.company : NSNull())
                aValueArray.append(aVehicle.modelNumber != nil ? aVehicle.modelNumber : NSNull())
                aValueArray.append(aVehicle.bodyStyle != nil ? aVehicle.bodyStyle : NSNull())
                aValueArray.append(aVehicle.vehicleDescription != nil ? aVehicle.vehicleDescription : NSNull())
                aValueArray.append(aPhotoOneData != nil ? aPhotoOneData : NSNull())
                aValueArray.append(aPhotoTwoData != nil ? aPhotoTwoData : NSNull())
                aValueArray.append(aPhotoThreeData != nil ? aPhotoThreeData : NSNull())
                aValueArray.append(aVehicle.comprehensiveCoverage != nil ? aVehicle.comprehensiveCoverage : NSNull())
                aValueArray.append(aVehicle.collisionCoverage != nil ? aVehicle.collisionCoverage : NSNull())
                try self.executeQuery(anSqlQuery, values: aValueArray)
                aDataManagerResponse.result = aVehicle
            } else if self.requestType == IARequestType.ListVehicles {
                let anSqlQuery :String = "SELECT vin, year, company, model_number, body_style, description, photo_one, photo_two, photo_three, comprehensive_coverage, collision_coverage FROM vehicles"
                let anSqlResult = try self.executeQuery(anSqlQuery, values: nil)
                if anSqlResult != nil && anSqlResult.count > 0 {
                    var aVehicleArray :Array<IAVehicle>! = Array<IAVehicle>()
                    for var aDBVehicleDict :[String:AnyObject] in anSqlResult {
                        let aDBVehicle = IAVehicle()
                        if aDBVehicleDict["vin"] is String {
                            aDBVehicle.vin = aDBVehicleDict["vin"] as! String
                        }
                        if aDBVehicleDict["year"] is String {
                            aDBVehicle.year = aDBVehicleDict["year"] as! String
                        }
                        if aDBVehicleDict["company"] is String {
                            aDBVehicle.company = aDBVehicleDict["company"] as! String
                        }
                        if aDBVehicleDict["model_number"] is String {
                            aDBVehicle.modelNumber = aDBVehicleDict["model_number"] as! String
                        }
                        if aDBVehicleDict["body_style"] is String {
                            aDBVehicle.bodyStyle = aDBVehicleDict["body_style"] as! String
                        }
                        if aDBVehicleDict["description"] is String {
                            aDBVehicle.vehicleDescription = aDBVehicleDict["description"] as! String
                        }
                        if aDBVehicleDict["photo_one"] is NSData {
                            aDBVehicle.photoOne = UIImage(data: aDBVehicleDict["photo_one"] as! NSData)
                        }
                        if aDBVehicleDict["photo_two"] is NSData {
                            aDBVehicle.photoTwo = UIImage(data: aDBVehicleDict["photo_two"] as! NSData)
                        }
                        if aDBVehicleDict["photo_three"] is NSData {
                            aDBVehicle.photoThree = UIImage(data: aDBVehicleDict["photo_three"] as! NSData)
                        }
                        if aDBVehicleDict["comprehensive_coverage"] is String {
                            aDBVehicle.comprehensiveCoverage = aDBVehicleDict["comprehensive_coverage"] as! String
                        }
                        if aDBVehicleDict["collision_coverage"] is String {
                            aDBVehicle.collisionCoverage = aDBVehicleDict["collision_coverage"] as! String
                        }
                        aVehicleArray.append(aDBVehicle)
                    }
                    if aVehicleArray.count <= 0 {
                        aVehicleArray = nil
                    }
                    aDataManagerResponse.result = aVehicleArray
                }
            } else if self.requestType == IARequestType.AddDriver {
                let aDriver :IADriver = pRequest as! IADriver
                var anAvatarData :NSData! = nil
                if aDriver.avatar != nil {
                    anAvatarData = UIImagePNGRepresentation(aDriver.avatar)
                }
                let anSqlQuery :String = "INSERT INTO drivers (full_name, phone_number, email_address, street_address, city, state, zip_code, dob, license_number, appointed_since, driving_experience, employee_type, avatar) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
                var aValueArray = Array<AnyObject>()
                aValueArray.append(aDriver.fullName != nil ? aDriver.fullName : NSNull())
                aValueArray.append(aDriver.phoneNumber != nil ? aDriver.phoneNumber : NSNull())
                aValueArray.append(aDriver.emailAddress != nil ? aDriver.emailAddress : NSNull())
                aValueArray.append(aDriver.streetAddress != nil ? aDriver.streetAddress : NSNull())
                aValueArray.append(aDriver.city != nil ? aDriver.city : NSNull())
                aValueArray.append(aDriver.state != nil ? aDriver.state : NSNull())
                aValueArray.append(aDriver.zip != nil ? aDriver.zip : NSNull())
                aValueArray.append(aDriver.dob != nil ? aDriver.dob : NSNull())
                aValueArray.append(aDriver.licenseNumber != nil ? aDriver.licenseNumber : NSNull())
                aValueArray.append(aDriver.appointedSince != nil ? aDriver.appointedSince : NSNull())
                aValueArray.append(aDriver.drivingExperience != nil ? aDriver.drivingExperience : NSNull())
                aValueArray.append(aDriver.employeeType != nil ? aDriver.employeeType : NSNull())
                aValueArray.append(anAvatarData != nil ? anAvatarData : NSNull())
                
                try self.executeQuery(anSqlQuery, values: aValueArray)
                aDataManagerResponse.result = aDriver
            } else if self.requestType == IARequestType.ListDrivers {
                let anSqlQuery :String = "SELECT full_name, phone_number, email_address, street_address, city, state, zip_code, dob, license_number, appointed_since, driving_experience, employee_type, avatar FROM drivers"
                let anSqlResult = try self.executeQuery(anSqlQuery, values: nil)
                if anSqlResult != nil && anSqlResult.count > 0 {
                    var aDriverArray :Array<IADriver>! = Array<IADriver>()
                    for var aDBDriverDict :[String:AnyObject] in anSqlResult {
                        let aDBDriver = IADriver()
                        aDBDriver.fullName = aDBDriverDict["full_name"] as! String
                        if aDBDriverDict["phone_number"] is String {
                            aDBDriver.phoneNumber = aDBDriverDict["phone_number"] as! String
                        }
                        if aDBDriverDict["email_address"] is String {
                            aDBDriver.emailAddress = aDBDriverDict["email_address"] as! String
                        }
                        if aDBDriverDict["street_address"] is String {
                            aDBDriver.streetAddress = aDBDriverDict["street_address"] as! String
                        }
                        if aDBDriverDict["city"] is String {
                            aDBDriver.city = aDBDriverDict["city"] as! String
                        }
                        if aDBDriverDict["state"] is String {
                            aDBDriver.state = aDBDriverDict["state"] as! String
                        }
                        if aDBDriverDict["zip_code"] is String {
                            aDBDriver.zip = aDBDriverDict["zip_code"] as! String
                        }
                        if aDBDriverDict["dob"] is String {
                            aDBDriver.dob   = aDBDriverDict["dob"] as! String
                        }
                        if aDBDriverDict["license_number"] is String {
                            aDBDriver.licenseNumber = aDBDriverDict["license_number"] as! String
                        }
                        if aDBDriverDict["appointed_since"] is String {
                            aDBDriver.appointedSince = aDBDriverDict["appointed_since"] as! String
                        }
                        if aDBDriverDict["driving_experience"] is String {
                            aDBDriver.drivingExperience = aDBDriverDict["driving_experience"] as! String
                        }
                        if aDBDriverDict["employee_type"] is String {
                            aDBDriver.employeeType = aDBDriverDict["employee_type"] as! String
                        }
                        if aDBDriverDict["avatar"] is NSData {
                            aDBDriver.avatar = UIImage(data: aDBDriverDict["avatar"] as! NSData)
                        }
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
    
    
    internal func listVehicles() {
        self.requestType = IARequestType.ListVehicles
        self.sendRequest(nil)
    }
    
    
    internal func addVehicle(pVehicle :IAVehicle) {
        self.requestType = IARequestType.AddVehicle
        self.sendRequest(pVehicle)
    }
    
    
    internal func dashboardDetails() {
        self.requestType = IARequestType.DashboardDetails
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
