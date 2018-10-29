//
//  GuestPass.swift
//  ParkPassGenerator
//
//  Created by Joshua Borck on 10/24/18.
//  Copyright © 2018 Joshua Borck. All rights reserved.
//

import Foundation

enum GuestType {
    case classic
    case vip
    case child
}

class GuestPass: Pass {
    var entrant: Entrant
    let guestType: GuestType
    
    init(entrant: Entrant, guestType: GuestType) throws {
        if guestType == .child {
            guard let dateOfBirth = entrant.dob else {
                throw GeneratorError.noDateOfBirth
            }
            
            let dateComponents = Calendar.current.dateComponents([.year], from: Date(), to: dateOfBirth)
            if let yearDifference = dateComponents.year, yearDifference > 5 {
                throw GeneratorError.olderThanFive
            }
        }
        self.entrant = entrant
        self.guestType = guestType
    }
    
    func swipe(for areaAcess: AreaAccess) -> SwipeResult {
        switch areaAcess {
        case .amusement:
            return SwipeResult(access: true)
        default:
            return SwipeResult(access: false)
        }
    }
    
    func swipe(rideAccess: RideAccess) -> SwipeResult {
        switch rideAccess {
        case .all:
            return SwipeResult(access: true)
        case .skipLines:
                if self.guestType == .vip {
                    return SwipeResult(access: true)
                } else {
                    return SwipeResult(access: false)
            }
        }
    }
    
    func swipe(discountOn: DiscountAccess) -> Int {
        switch discountOn {
        case .food:
            if self.guestType == .vip {
                return 10
            } else {
                return 0
            }
        case .merchandise:
            if self.guestType == .vip {
                return 20
            } else {
                return 0
            }
        }
    }
    
    
}
