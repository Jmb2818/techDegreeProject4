//
//  EmployeePass.swift
//  ParkPassGenerator
//
//  Created by Joshua Borck on 10/23/18.
//  Copyright © 2018 Joshua Borck. All rights reserved.
//

import Foundation

class EmployeePass: Pass {
    
    // MARK: Properties
    var entrant: Entrant
    var isBirthday: Bool
    var passSwipeStamp: Date? = nil
    let passType: String
    let employeeType: EmployeeType
    let managerType: ManagerType?
    
     // MARK: Initializers
    init(entrant: Entrant, employeeType: EmployeeType, managementType: ManagerType? = nil) throws {
        var emptyFields: [String] = []
        
        // Check to make sure all required employee information has been entered
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
        if employeeType == .manager, managementType == nil {
           emptyFields.append("Management Type")
        }
        // If any information is missing then throw an error telling user what is missing
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
        // if employee is a manager make sure the swipe knows which type of manager
        if employeeType == .manager, let managerType = managementType {
            self.passType = (employeeType.rawValue + "-" + managerType.rawValue)
        } else {
            self.passType = employeeType.rawValue
        }
        self.managerType = managementType
    }
    
    // MARK: Required Methods
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
        
        switch rideAccess {
        case .all:
            // Check if pass has a pass stamp and if it is swiped less than 5 seconds ago
            // If not then give new pass stamp
            if let lastSwipeDate = passSwipeStamp {
                if isPassSwipedTooSoon(timeOfLastSwipe: lastSwipeDate) {
                    return SwipeResult(access: false, message: "Sorry you have tried to access this ride in the last 5 seconds.")
                } else {
                    passSwipeStamp = Date()
                }
            } else {
                passSwipeStamp = Date()
            }
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
