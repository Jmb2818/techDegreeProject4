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

enum EmployeeType {
    case food, ride, maintenance, manager
}

class employeePass: Pass {
    
    var entrant: Entrant
    var employeeType: EmployeeType
    
    init(entrant: Entrant, employeeType: EmployeeType) {
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
            } else {
                return SwipeResult(access: false)
            }
        case .maintenance:
            if self.employeeType == .maintenance || self.employeeType == .manager {
                return SwipeResult(access: true)
            } else {
                return SwipeResult(access: false)
            }
        case .office:
            if self.employeeType == .manager {
                return SwipeResult(access: true)
            } else {
                return SwipeResult(access: false)
            }
        case .rideControl:
            if self.employeeType != .food {
                return SwipeResult(access: true)
            } else {
                return SwipeResult(access: false)
            }
        }
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
