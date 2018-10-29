//
//  EmployeePass.swift
//  ParkPassGenerator
//
//  Created by Joshua Borck on 10/23/18.
//  Copyright © 2018 Joshua Borck. All rights reserved.
//

import Foundation

protocol Pass {
    var entrant: Entrant { get set }
    func swipe(for areaAcess: AreaAccess) -> SwipeResult
    func swipe(rideAccess: RideAccess) -> SwipeResult
    func swipe(discountOn: DiscountAccess) -> Int
}

enum EmployeeType: String {
    case food = "Food Service"
    case ride = "Ride Operator"
    case maintenance = "Maintenance Worker"
    case manager = "Manager"
}

class EmployeePass: Pass {
    
    var entrant: Entrant
    var employeeType: EmployeeType
    
    init(entrant: Entrant, employeeType: EmployeeType) throws {
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
        if entrant.dob == nil {
            emptyFields.append("Date of Birth")
        }
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
    }
    
    func swipe(for areaAccess: AreaAccess) -> SwipeResult {
        switch areaAccess {
        case .amusement:
            return SwipeResult(access: true)
        case .kitchen:
            if self.employeeType != .ride {
                return SwipeResult(access: true)
            }
        case .maintenance:
            if self.employeeType == .maintenance || self.employeeType == .manager {
                return SwipeResult(access: true)
            }
        case .office:
            if self.employeeType == .manager {
                return SwipeResult(access: true)
            }
        case .rideControl:
            if self.employeeType != .food {
                return SwipeResult(access: true)
            }
        }
        return SwipeResult(access: false)
    }
    
    func swipe(rideAccess: RideAccess) -> SwipeResult {
        switch rideAccess {
        case .all:
            return SwipeResult(access: true)
        case .skipLines:
            return SwipeResult(access: false)
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
