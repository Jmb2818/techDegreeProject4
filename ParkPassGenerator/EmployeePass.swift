//
//  EmployeePass.swift
//  ParkPassGenerator
//
//  Created by Joshua Borck on 10/23/18.
//  Copyright © 2018 Joshua Borck. All rights reserved.
//

import Foundation

enum EmployeeType: String {
    case food = "Food Service"
    case ride = "Ride Operator"
    case maintenance = "Maintenance Worker"
    case manager = "Manager"
}

enum ManagerType {
    case shiftManager
    case generalManager
    case seniorManager
}

class EmployeePass: Pass {
    
    var entrant: Entrant
    var isBirthday: Bool
    var passSwipeStamp: Date? = nil
    let employeeType: EmployeeType
    let managerType: ManagerType?
    
    init(entrant: Entrant, employeeType: EmployeeType, managementType: ManagerType? = nil) throws {
        var emptyFields: [String] = []
        
        if entrant.firstName == nil {
            emptyFields.append("First Name")
        }
        if entrant.lastName == nil {
            emptyFields.append("Last Name")
        }
        if entrant.streetAddress == nil {
            emptyFields.append("Street Address")
        }
        if entrant.city == nil {
            emptyFields.append("City")
        }
        if entrant.state == nil {
            emptyFields.append("State")
        }
        if entrant.zipCode == nil {
            emptyFields.append("Zip Code")
        }
        if entrant.ssn == nil {
            emptyFields.append("Social Security Number")
        }
        if let dateOfBirth = entrant.dob {
            self.isBirthday = DateEditor.isBirthday(dateOfBirth: dateOfBirth)
        } else {
            emptyFields.append("Date of Birth")
            self.isBirthday = false
        }
        // TODO: Check that manager has a manager type or add that to the list of missing info
        guard emptyFields.isEmpty else {
            var missingItems = ""
            for missingItem in emptyFields {
                if missingItems.isEmpty {
                    missingItems += " \(missingItem)"
                } else {
                    missingItems += ", \(missingItem)"
                }
            }
            let errorString = "Employee pass creation error for: \(employeeType.rawValue). Missing Fields: \(missingItems)"
            throw GeneratorError.missingInformation(errorString)
        }

        self.entrant = entrant
        self.employeeType = employeeType
        self.managerType = managementType
    }
    
    func swipe(for areaAccess: AreaAccess) -> SwipeResult {
        switch areaAccess {
        case .amusement:
            return SwipeResult(access: true, message: birthdayMessage)
        case .kitchen:
            if self.employeeType != .ride {
                return SwipeResult(access: true, message: birthdayMessage)
            }
        case .maintenance:
            if self.employeeType == .maintenance || self.employeeType == .manager {
                return SwipeResult(access: true, message: birthdayMessage)
            }
        case .office:
            if self.employeeType == .manager {
                return SwipeResult(access: true, message: birthdayMessage)
            }
        case .rideControl:
            if self.employeeType != .food {
                return SwipeResult(access: true, message: birthdayMessage)
            }
        }
        return SwipeResult(access: false, message: birthdayMessage)
    }
    
    func swipe(rideAccess: RideAccess) -> SwipeResult {
        // TODO: Swipe Time Rejection
        switch rideAccess {
        case .all:
            return SwipeResult(access: true, message: birthdayMessage)
        case .skipLines:
            return SwipeResult(access: false, message: birthdayMessage)
        }
    }
    
    func swipe(discountOn: DiscountAccess) -> Int {
        switch discountOn {
        case .food:
            if self.employeeType == .manager {
                return 25
            } else {
                return 15
            }
        case .merchandise:
           return 25
        }
    }
}
