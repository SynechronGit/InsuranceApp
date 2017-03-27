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
    case login
    case dashboardDetails
    case addVehicle
    case listVehicles
    case vehicleDetails
    case addDriver
    case listDrivers
    case driverDetails
    case listPolicies
    case listClaims
    case fileClaim
    case listPremiums
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
    @objc optional func aiDataManagerDidSucceed(sender pSender:IADataManager, response pResponse: IADataManagerResponse)
    @objc optional func aiDataManagerDidFail(sender pSender:IADataManager, error pError: NSError)
}


/*
 * Class to handle all the data related requests.
 */
class IADataManager: NSObject {
    var requestType :IARequestType!
    var delegate :IADataManagerDelegate?
    
    
    fileprivate func executeQuery(_ pQuery:String!, values pValues:Array<AnyObject>!) throws -> Array<Dictionary<String, AnyObject>>! {
        var aReturnVal :Array<Dictionary<String, AnyObject>>! = Array()
        
        do {
            var aDatabaseHandle: OpaquePointer? = nil
            if sqlite3_open(IAConstants.dataManagerSqliteFilePath, &aDatabaseHandle) != SQLITE_OK {
                throw IAError.generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Can not open database."]))
            }
            
            var anSqliteStatement: OpaquePointer? = nil
            if sqlite3_prepare_v2(aDatabaseHandle, pQuery, -1, &anSqliteStatement, nil) == SQLITE_OK {
                if pValues != nil && pValues.count > 0 {
                    for anIndex in 0..<pValues.count {
                        let aValue = pValues[anIndex]
                        if aValue is String {
                            if sqlite3_bind_text(anSqliteStatement, Int32(anIndex + 1), (aValue as! NSString).utf8String, -1, nil) != SQLITE_OK {
                                throw IAError.generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Can not bind value."]))
                            }
                        } else if aValue is NSNumber {
                            if sqlite3_bind_int(anSqliteStatement, Int32(anIndex + 1), (aValue as! NSNumber).int32Value) != SQLITE_OK {
                                throw IAError.generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Can not bind value."]))
                            }
                        } else if aValue is NSNull {
                            if sqlite3_bind_null(anSqliteStatement, Int32(anIndex + 1)) != SQLITE_OK {
                                throw IAError.generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Can not bind value."]))
                            }
                        } else if aValue is Data {
                            if sqlite3_bind_blob(anSqliteStatement, Int32(anIndex + 1), ((aValue as! Data) as NSData).bytes, Int32((aValue as! Data).count), nil) != SQLITE_OK {
                                throw IAError.generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Can not bind value."]))
                            }
                        }
                    }
                }
            } else {
                let anErrorMessage = String(cString: sqlite3_errmsg(aDatabaseHandle))
                throw IAError.generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Can not prepare statement. Error: " + anErrorMessage]))
            }
            
            while true {
                let anSqliteStepResult = sqlite3_step(anSqliteStatement)
                if anSqliteStepResult == SQLITE_ROW {
                    let aColumnCount :Int = Int(sqlite3_column_count(anSqliteStatement))
                    
                    var aRow = Dictionary<String, AnyObject>()
                    for aColumnIndex in 0..<aColumnCount {
                        let aColumnName :String! = String(cString: UnsafePointer<CChar>(sqlite3_column_name(anSqliteStatement, Int32(aColumnIndex))))
                        
                        let aColumnType :Int32 = sqlite3_column_type(anSqliteStatement, Int32(aColumnIndex))
                        
                        var aColumnValue :AnyObject!
                        if aColumnType == SQLITE_INTEGER {
                            aColumnValue = NSNumber(value: sqlite3_column_int(anSqliteStatement, Int32(aColumnIndex)) as Int32)
                        } else if aColumnType == SQLITE_FLOAT {
                            aColumnValue = NSNumber(value: sqlite3_column_double(anSqliteStatement, Int32(aColumnIndex)) as Double)
                        } else if aColumnType == SQLITE_BLOB {
                            let aDataLength = Int(sqlite3_column_bytes(anSqliteStatement, Int32(aColumnIndex)))
                            aColumnValue = NSData(bytes: sqlite3_column_blob(anSqliteStatement, Int32(aColumnIndex)), length: aDataLength)
                        } else if aColumnType == SQLITE_NULL {
                            aColumnValue = NSNull()
                        } else if aColumnType == SQLITE_TEXT || aColumnType == SQLITE3_TEXT {
                            let aValue = sqlite3_column_text(anSqliteStatement, Int32(aColumnIndex))
                            if aValue != nil {
                                aColumnValue = String(cString: aValue!) as AnyObject
                            }
                        }
                        aRow.updateValue(aColumnValue, forKey: aColumnName)
                    }
                    if aRow.count > 0 {
                        aReturnVal.append(aRow)
                    }
                } else if anSqliteStepResult == SQLITE_DONE {
                    break
                } else {
                    throw IAError.generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Can not step statement."]))
                }
            }
            
            if sqlite3_finalize(anSqliteStatement) != SQLITE_OK {
                let anErrorMessage = String(cString: sqlite3_errmsg(aDatabaseHandle))
                throw IAError.generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:String(format: "Can not finalize statement. Error: %@", anErrorMessage)]))
            }
            
            defer {
                if aDatabaseHandle != nil {
                    sqlite3_close(aDatabaseHandle)
                }
            }
        } catch IAError.generic(let pError){
            throw IAError.generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:String(format: "Execute query error. %@", pError.localizedDescription)]))
        } catch {
            throw IAError.generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Execute query error."]))
        }
        
        if aReturnVal.count <= 0 {
            aReturnVal = nil
        }
        
        return aReturnVal
    }
    
    
    fileprivate func sendRequest(_ pRequest:Any!) {
        let aDataManagerResponse :IADataManagerResponse = IADataManagerResponse()
        
        do {
            if self.requestType == IARequestType.login {
                let aCustomer :IACustomer = pRequest as! IACustomer
                let anSqlQuery :String = String(format: "SELECT id AS CustomerID, first_name AS FirstName, last_name AS LastName, email_address AS EmailAddress, password as Password FROM customers WHERE email_address='%@'", aCustomer.emailAddress)
                let anSqlResult = try self.executeQuery(anSqlQuery, values: nil)
                if anSqlResult != nil && (anSqlResult?.count)! >= 1 {
                    let aDBCustomerDict :[String:AnyObject] = anSqlResult!.first!
                    
                    let aDBCustomer = IACustomer()
                    aDBCustomer.customerID = String(format:"%d", (aDBCustomerDict["CustomerID"] as! NSNumber).intValue)
                    aDBCustomer.emailAddress = String(aDBCustomerDict["EmailAddress"] as! String)
                    aDBCustomer.firstName = String(aDBCustomerDict["FirstName"] as! String)
                    aDBCustomer.lastName = String(aDBCustomerDict["LastName"] as! String)
                    
                    aDataManagerResponse.result = aDBCustomer
                } else {
                    throw IAError.generic(NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Email address is not registered."]))
                }
            } else if self.requestType == IARequestType.dashboardDetails {
                let aDashboardDetails :IADashboard = IADashboard()
                
                let anSqlQuery :String = "SELECT (SELECT COUNT(id) FROM vehicles) AS AutoInsuranceCarCount, (SELECT COUNT(id) FROM drivers) AS AutoInsuranceDriverCount, (SELECT COUNT(id) FROM claims) AS ClaimCount"
                let anSqlResult = try self.executeQuery(anSqlQuery, values: nil)
                if anSqlResult != nil && anSqlResult?.count == 1 {
                    let aDBDashboardDict :[String:AnyObject] = anSqlResult![0]
                    if aDBDashboardDict["AutoInsuranceCarCount"] is NSNumber {
                        aDashboardDetails.autoInsuranceCarCount = (aDBDashboardDict["AutoInsuranceCarCount"] as! NSNumber).intValue
                    }
                    if aDBDashboardDict["AutoInsuranceDriverCount"] is NSNumber {
                        aDashboardDetails.autoInsuranceDriverCount = (aDBDashboardDict["AutoInsuranceDriverCount"] as! NSNumber).intValue
                    }
                    if aDBDashboardDict["ClaimCount"] is NSNumber {
                        aDashboardDetails.claimCount = (aDBDashboardDict["ClaimCount"] as! NSNumber).intValue
                    }
                }
                if aDashboardDetails.autoInsuranceCarCount == nil {
                    aDashboardDetails.autoInsuranceCarCount = 0
                }
                if aDashboardDetails.autoInsuranceDriverCount == nil {
                    aDashboardDetails.autoInsuranceDriverCount = 0
                }
                if aDashboardDetails.claimCount == nil {
                    aDashboardDetails.claimCount = 0
                }
                
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
                
                //aDashboardDetails.claimCount = 4
                aDashboardDetails.premiumCount = 2
                
                aDataManagerResponse.result = aDashboardDetails
            } else if self.requestType == IARequestType.addVehicle {
                let aVehicle :IAVehicle = pRequest as! IAVehicle
                var aPhotoOneData :Data! = nil
                if aVehicle.photoOne != nil {
                    aPhotoOneData = UIImagePNGRepresentation(aVehicle.photoOne)
                }
                var aPhotoTwoData :Data! = nil
                if aVehicle.photoTwo != nil {
                    aPhotoTwoData = UIImagePNGRepresentation(aVehicle.photoTwo)
                }
                var aPhotoThreeData :Data! = nil
                if aVehicle.photoThree != nil {
                    aPhotoThreeData = UIImagePNGRepresentation(aVehicle.photoThree)
                }
                let anSqlQuery :String = "INSERT INTO vehicles (vin, year, company, model_number, body_style, description, photo_one, photo_two, photo_three, comprehensive_coverage, collision_coverage) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
                var aValueArray = Array<AnyObject>()
                aValueArray.append(aVehicle.vin != nil ? (aVehicle.vin as AnyObject) : (NSNull() as AnyObject))
                aValueArray.append(aVehicle.year != nil ? (aVehicle.year as AnyObject) : (NSNull() as AnyObject))
                aValueArray.append(aVehicle.company != nil ? (aVehicle.company as AnyObject) : (NSNull() as AnyObject))
                aValueArray.append(aVehicle.modelNumber != nil ? (aVehicle.modelNumber as AnyObject) : (NSNull() as AnyObject))
                aValueArray.append(aVehicle.bodyStyle != nil ? (aVehicle.bodyStyle as AnyObject) : (NSNull() as AnyObject))
                aValueArray.append(aVehicle.vehicleDescription != nil ? (aVehicle.vehicleDescription as AnyObject) : (NSNull() as AnyObject))
                aValueArray.append(aPhotoOneData != nil ? (aPhotoOneData as AnyObject) : (NSNull() as AnyObject))
                aValueArray.append(aPhotoTwoData != nil ? (aPhotoTwoData as AnyObject) : (NSNull() as AnyObject))
                aValueArray.append(aPhotoThreeData != nil ? (aPhotoThreeData as AnyObject) : (NSNull() as AnyObject))
                aValueArray.append(aVehicle.comprehensiveCoverage != nil ? (aVehicle.comprehensiveCoverage as AnyObject) : (NSNull() as AnyObject))
                aValueArray.append(aVehicle.collisionCoverage != nil ? (aVehicle.collisionCoverage as AnyObject) : (NSNull() as AnyObject))
                _ = try self.executeQuery(anSqlQuery, values: aValueArray)
                aDataManagerResponse.result = aVehicle
            } else if self.requestType == IARequestType.listVehicles {
                let anSqlQuery :String = "SELECT vin, year, company, model_number, body_style, description, photo_one, photo_two, photo_three, comprehensive_coverage, collision_coverage FROM vehicles"
                let anSqlResult = try self.executeQuery(anSqlQuery, values: nil)
                if anSqlResult != nil && (anSqlResult?.count)! > 0 {
                    var aVehicleArray :Array<IAVehicle>! = Array<IAVehicle>()
                    for var aDBVehicleDict :[String:AnyObject] in anSqlResult! {
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
                            aDBVehicle.photoOne = UIImage(data: aDBVehicleDict["photo_one"] as! Data)
                        }
                        if aDBVehicleDict["photo_two"] is NSData {
                            aDBVehicle.photoTwo = UIImage(data: aDBVehicleDict["photo_two"] as! Data)
                        }
                        if aDBVehicleDict["photo_three"] is NSData {
                            aDBVehicle.photoThree = UIImage(data: aDBVehicleDict["photo_three"] as! Data)
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
            } else if self.requestType == IARequestType.addDriver {
                let aDriver :IADriver = pRequest as! IADriver
                var anAvatarData :Data! = nil
                if aDriver.avatar != nil {
                    anAvatarData = UIImagePNGRepresentation(aDriver.avatar)
                }
                let anSqlQuery :String = "INSERT INTO drivers (full_name, phone_number, email_address, street_address, city, state, zip_code, dob, license_number, appointed_since, driving_experience, employee_type, avatar) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
                var aValueArray = Array<AnyObject>()
                aValueArray.append(aDriver.fullName != nil ? (aDriver.fullName as AnyObject) : (NSNull() as AnyObject))
                aValueArray.append(aDriver.phoneNumber != nil ? (aDriver.phoneNumber as AnyObject) : (NSNull() as AnyObject))
                aValueArray.append(aDriver.emailAddress != nil ? (aDriver.emailAddress as AnyObject) : (NSNull() as AnyObject))
                aValueArray.append(aDriver.streetAddress != nil ? (aDriver.streetAddress as AnyObject) : (NSNull() as AnyObject))
                aValueArray.append(aDriver.city != nil ? (aDriver.city as AnyObject) : (NSNull() as AnyObject))
                aValueArray.append(aDriver.state != nil ? (aDriver.state as AnyObject) : (NSNull() as AnyObject))
                aValueArray.append(aDriver.zip != nil ? (aDriver.zip as AnyObject) : (NSNull() as AnyObject))
                aValueArray.append(aDriver.dob != nil ? (aDriver.dob as AnyObject) : (NSNull() as AnyObject))
                aValueArray.append(aDriver.licenseNumber != nil ? (aDriver.licenseNumber as AnyObject) : (NSNull() as AnyObject))
                aValueArray.append(aDriver.appointedSince != nil ? (aDriver.appointedSince as AnyObject) : (NSNull() as AnyObject))
                aValueArray.append(aDriver.drivingExperience != nil ? (aDriver.drivingExperience as AnyObject) : (NSNull() as AnyObject))
                aValueArray.append(aDriver.employeeType != nil ? (aDriver.employeeType as AnyObject) : (NSNull() as AnyObject))
                aValueArray.append(anAvatarData != nil ? (anAvatarData as AnyObject) : (NSNull() as AnyObject))
                _ = try self.executeQuery(anSqlQuery, values: aValueArray)
                aDataManagerResponse.result = aDriver
            } else if self.requestType == IARequestType.listDrivers {
                let anSqlQuery :String = "SELECT full_name, phone_number, email_address, street_address, city, state, zip_code, dob, license_number, appointed_since, driving_experience, employee_type, avatar FROM drivers"
                let anSqlResult = try self.executeQuery(anSqlQuery, values: nil)
                if anSqlResult != nil && (anSqlResult?.count)! > 0 {
                    var aDriverArray :Array<IADriver>! = Array<IADriver>()
                    for var aDBDriverDict :[String:AnyObject] in anSqlResult! {
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
                            aDBDriver.avatar = UIImage(data: aDBDriverDict["avatar"] as! Data)
                        }
                        aDriverArray.append(aDBDriver)
                    }
                    if aDriverArray.count <= 0 {
                        aDriverArray = nil
                    }
                    aDataManagerResponse.result = aDriverArray
                }
            } else if self.requestType == IARequestType.listPolicies {
                let anSqlQuery :String = "SELECT insurance_type, insured_vehicle_count, insured_driver_count, insured_home_item_count, insured_boat_count, insured_pet_count, coverage, premium_due, date, policy_number, insurer FROM policies"
                let anSqlResult = try self.executeQuery(anSqlQuery, values: nil)
                if anSqlResult != nil && (anSqlResult?.count)! > 0 {
                    var aPolicyArray :Array<IAPolicy>! = Array<IAPolicy>()
                    for var aDBPolicyDict :[String:AnyObject] in anSqlResult! {
                        let aDBPolicy = IAPolicy()
                        
                        aDBPolicy.insuranceType = aDBPolicyDict["insurance_type"] as! String
                        
                        if aDBPolicyDict["insured_vehicle_count"] is String {
                            aDBPolicy.insuredVehicleCount = Int(aDBPolicyDict["insured_vehicle_count"] as! String)
                        }
                        if aDBPolicyDict["insured_driver_count"] is String {
                            aDBPolicy.insuredDriverCount = Int(aDBPolicyDict["insured_driver_count"] as! String)
                        }
                        if aDBPolicyDict["insured_home_item_count"] is String {
                            aDBPolicy.insuredHomeItemCount = Int(aDBPolicyDict["insured_home_item_count"] as! String)
                        }
                        if aDBPolicyDict["insured_boat_count"] is String {
                            aDBPolicy.insuredBoatCount = Int(aDBPolicyDict["insured_boat_count"] as! String)
                        }
                        if aDBPolicyDict["insured_pet_count"] is String {
                            aDBPolicy.insuredPetCount = Int(aDBPolicyDict["insured_pet_count"] as! String)
                        }
                        if aDBPolicyDict["policy_number"] is String {
                            aDBPolicy.policyNumber = aDBPolicyDict["policy_number"] as! String
                        }
                        if aDBPolicyDict["insurer"] is String {
                            aDBPolicy.insurer = aDBPolicyDict["insurer"] as! String
                        }
                        
                        let aFormatter = NumberFormatter()
                        aFormatter.numberStyle = .decimal
                        
                        if aDBPolicyDict["coverage"] is String {
                            aDBPolicy.coverage = aFormatter.number(from: aDBPolicyDict["coverage"] as! String)
                        }
                        if aDBPolicyDict["premium_due"] is String {
                            aDBPolicy.premiumDue = aFormatter.number(from: aDBPolicyDict["premium_due"] as! String)
                        }
                        if aDBPolicyDict["date"] is String {
                            aDBPolicy.date = aDBPolicyDict["date"] as! String
                        }
                        
                        aPolicyArray.append(aDBPolicy)
                    }
                    if aPolicyArray.count <= 0 {
                        aPolicyArray = nil
                    }
                    aDataManagerResponse.result = aPolicyArray
                }
            } else if self.requestType == IARequestType.listClaims {
                
                let anSqlQuery :String = "SELECT code, date_of_claim, insurance_type, insured_item_name, insurer, status, incident_date, incident_type, value, photo1, photo2, photo3, policy_number FROM claims"
                let anSqlResult = try self.executeQuery(anSqlQuery, values: nil)
                if anSqlResult != nil && (anSqlResult?.count)! > 0 {
                    var aClaimArray :Array<IAClaim>! = Array<IAClaim>()
                    for var aDBClaimDict :[String:AnyObject] in anSqlResult! {
                        let aDBClaim = IAClaim()
    
                        if aDBClaimDict["code"] is String {
                            aDBClaim.code = aDBClaimDict["code"] as! String
                        }
                        
                        if aDBClaimDict["date_of_claim"] is String {
                            aDBClaim.dateOfClaim = aDBClaimDict["date_of_claim"] as! String
                        }
                        
                        if aDBClaimDict["insurance_type"] is String {
                            aDBClaim.insuranceType = aDBClaimDict["insurance_type"] as! String
                        }
                        
                        if aDBClaimDict["insured_item_name"] is String {
                            aDBClaim.insuredItemName = aDBClaimDict["insured_item_name"] as! String
                        }
                        
                        if aDBClaimDict["insurer"] is String {
                            aDBClaim.insurer = aDBClaimDict["insurer"] as! String
                        }
                        
                        if aDBClaimDict["status"] is String {
                            aDBClaim.status = aDBClaimDict["status"] as! String
                        }
                        
                        if aDBClaimDict["incident_date"] is String {
                            aDBClaim.dateOfIncident = aDBClaimDict["incident_date"] as! String
                        }
                        
                        if aDBClaimDict["incident_type"] is String {
                            aDBClaim.incedentType = aDBClaimDict["incident_type"] as! String
                        }
                        
                        if aDBClaimDict["value"] is String {
                            aDBClaim.value = aDBClaimDict["value"] as! String
                        }
                        
                        if aDBClaimDict["photo1"] is NSData {
                            aDBClaim.photoOne = UIImage(data: aDBClaimDict["photo1"] as! Data)
                        }
                        
                        if aDBClaimDict["photo2"] is NSData {
                            aDBClaim.photoTwo = UIImage(data: aDBClaimDict["photo2"] as! Data)
                        }
                        
                        if aDBClaimDict["photo3"] is NSData {
                            aDBClaim.photoThree = UIImage(data: aDBClaimDict["photo3"] as! Data)
                        }
                        if aDBClaimDict["policy_number"] is String {
                            aDBClaim.policyNumber = aDBClaimDict["policy_number"] as! String
                        }
                        
                        aClaimArray.append(aDBClaim)
                    }
                    if aClaimArray.count <= 0 {
                        aClaimArray = nil
                    }
                    aDataManagerResponse.result = aClaimArray
                }
                
            } else if self.requestType == IARequestType.fileClaim {
                let aClaim :IAClaim = pRequest as! IAClaim
                var aPhotoOneData :Data! = nil
                if aClaim.photoOne != nil {
                    aPhotoOneData = UIImagePNGRepresentation(aClaim.photoOne)
                }
                var aPhotoTwoData :Data! = nil
                if aClaim.photoTwo != nil {
                    aPhotoTwoData = UIImagePNGRepresentation(aClaim.photoTwo)
                }
                var aPhotoThreeData :Data! = nil
                if aClaim.photoThree != nil {
                    aPhotoThreeData = UIImagePNGRepresentation(aClaim.photoThree)
                }
                
                let anSqlQuery :String = "INSERT INTO claims (code, date_of_claim, insurance_type, insured_item_name, insurer, status, incident_date, incident_type, value, photo1, photo2, photo3, policy_number) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
                var aValueArray = Array<AnyObject>()
                aValueArray.append(aClaim.code != nil ? (aClaim.code as AnyObject) : (NSNull() as AnyObject))
                aValueArray.append(aClaim.dateOfClaim != nil ? (aClaim.dateOfClaim as AnyObject) : (NSNull() as AnyObject))
                aValueArray.append(aClaim.insuranceType != nil ? (aClaim.insuranceType as AnyObject) : (NSNull() as AnyObject))
                aValueArray.append(aClaim.insuredItemName != nil ? (aClaim.insuredItemName as AnyObject) : (NSNull() as AnyObject))
                aValueArray.append(aClaim.insurer != nil ? (aClaim.insurer as AnyObject) : (NSNull() as AnyObject))
                aValueArray.append(aClaim.status != nil ? (aClaim.status as AnyObject) : (NSNull() as AnyObject))
                aValueArray.append(aClaim.dateOfIncident != nil ? (aClaim.dateOfIncident as AnyObject) : (NSNull() as AnyObject))
                aValueArray.append(aClaim.incedentType != nil ? (aClaim.incedentType as AnyObject) : (NSNull() as AnyObject))
                aValueArray.append(aClaim.value != nil ? (aClaim.value as AnyObject) : (NSNull() as AnyObject))
                aValueArray.append(aPhotoOneData != nil ? (aPhotoOneData as AnyObject) : (NSNull() as AnyObject))
                aValueArray.append(aPhotoTwoData != nil ? (aPhotoTwoData as AnyObject) : (NSNull() as AnyObject))
                aValueArray.append(aPhotoThreeData != nil ? (aPhotoThreeData as AnyObject) : (NSNull() as AnyObject))
                aValueArray.append(aClaim.policyNumber != nil ? (aClaim.policyNumber as AnyObject) : (NSNull() as AnyObject))
                try self.executeQuery(anSqlQuery, values: aValueArray)
                aDataManagerResponse.result = aClaim
            } else if self.requestType == IARequestType.listPremiums {
                let anSqlQuery :String = "SELECT name, insurance_type, date, policy_number, amount FROM premiums"
                let anSqlResult = try self.executeQuery(anSqlQuery, values: nil)
                if anSqlResult != nil && (anSqlResult?.count)! > 0 {
                    var aPremiumArray :Array<IAPremium>! = Array<IAPremium>()
                    for var aDBPremiumDict :[String:AnyObject] in anSqlResult! {
                        let aDBPremium = IAPremium()
                        
                        if aDBPremiumDict["name"] is String {
                            aDBPremium.name = aDBPremiumDict["name"] as! String
                        }
                        
                        if aDBPremiumDict["insurance_type"] is String {
                            aDBPremium.insuranceType = aDBPremiumDict["insurance_type"] as! String
                        }
                        
                        if aDBPremiumDict["date"] is String {
                            aDBPremium.date = aDBPremiumDict["date"] as! String
                        }
                        
                        if aDBPremiumDict["policy_number"] is String {
                            aDBPremium.policyNumber = aDBPremiumDict["policy_number"] as! String
                        }
                        
                        if aDBPremiumDict["amount"] is String {
                            aDBPremium.amount = aDBPremiumDict["amount"] as! String
                        }
                        
                        aPremiumArray.append(aDBPremium)
                    }
                    if aPremiumArray.count <= 0 {
                        aPremiumArray = nil
                    }
                    aDataManagerResponse.result = aPremiumArray
                }
            }
        } catch IAError.generic(let pError){
            aDataManagerResponse.error = NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:pError.localizedDescription])
        } catch {
            aDataManagerResponse.error = NSError(domain: "com", code: 1, userInfo: [NSLocalizedDescriptionKey:"Send request error."])
        }
        
        let aDelayTime = DispatchTime.now() + Double(Int64(IAConstants.dataManagerResponseDelayInSeconds * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: aDelayTime) {
            self.delegate?.aiDataManagerDidSucceed!(sender: self, response: aDataManagerResponse)
        }
    }
    
    
    // MARK: Response Mapper Methods
    
    internal static func mapResponse(responseBody pResponseBody:String, requestType pRequestType:IARequestType) -> IADataManagerResponse {
        let aReturnVal = IADataManagerResponse()
        
        do {
            let aResponseDict = try JSONSerialization.jsonObject(with: pResponseBody.data(using: String.Encoding.utf8)!, options: JSONSerialization.ReadingOptions.allowFragments)
            
            if pRequestType == IARequestType.login {
                if (aResponseDict is NSDictionary) {
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
    
    internal func login(_ pCustomer :IACustomer) {
        self.requestType = IARequestType.login
        self.sendRequest(pCustomer)
    }
    
    
    internal func listVehicles() {
        self.requestType = IARequestType.listVehicles
        self.sendRequest(nil)
    }
    
    
    internal func addVehicle(_ pVehicle :IAVehicle) {
        self.requestType = IARequestType.addVehicle
        self.sendRequest(pVehicle)
    }
    
    
    internal func dashboardDetails() {
        self.requestType = IARequestType.dashboardDetails
        self.sendRequest(nil)
    }
    
    
    internal func addDriver(_ pDriver :IADriver) {
        self.requestType = IARequestType.addDriver
        self.sendRequest(pDriver)
    }
    
    
    internal func listDrivers() {
        self.requestType = IARequestType.listDrivers
        self.sendRequest(nil)
    }
    
    
    internal func driverDetails(_ pDriverID :String) {
        self.requestType = IARequestType.driverDetails
    }
    
    
    internal func listPolicies() {
        self.requestType = IARequestType.listPolicies
        self.sendRequest(nil)
    }
    
    
    internal func listClaims() {
        self.requestType = IARequestType.listClaims
        self.sendRequest(nil)
    }
    
    
    internal func fileClaim(_ pClaim :IAClaim) {
        self.requestType = IARequestType.fileClaim
        self.sendRequest(pClaim)
    }
    
    
    internal func listPremiums() {
        self.requestType = IARequestType.listPremiums
        self.sendRequest(nil)
    }
    
}
