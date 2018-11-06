//
//  GuestPass.swift
//  ParkPassGenerator
//
//  Created by Joshua Borck on 10/24/18.
//  Copyright © 2018 Joshua Borck. All rights reserved.
//

import Foundation

class GuestPass: Pass {
    
    // MARK: Properties
    var entrant: Entrant
    var isBirthday: Bool
    let passType: String
    let guestType: GuestType
    var passSwipeStamp: Date? = nil
    
    // MARK: Initializers
    init(entrant: Entrant, guestType: GuestType) throws {
        // If the guest type is a child, make sure there is a DOB and they are under 5
        if guestType == .child {
            guard let dateOfBirth = entrant.dob else {
                let errorDescription = "Guest pass creation error for child's pass. No date of birth entered."
                throw GeneratorError.missingInformation(errorDescription)
            }
            
            let dateComponents = Calendar.current.dateComponents([.year], from: Date(), to: dateOfBirth)
            if let yearDifference = dateComponents.year, yearDifference < 5 {
                throw GeneratorError.olderThanFive("Error creating child's pass. Child is older than five.")
            }
        }
        
        // If the entrant has entered a DOB then check if it is their birthday for special messaging
        if let dateOfBirth = entrant.dob {
            self.isBirthday = DateEditor.isBirthday(dateOfBirth: dateOfBirth)
        } else {
            self.isBirthday = false
        }
        
        self.entrant = entrant
        self.guestType = guestType
        self.passType = guestType.rawValue
    }
    
    // MARK: Required Methods
    func swipe(for areaAcess: AreaAccess) -> SwipeResult {
        switch areaAcess {
        case .amusement:
            return SwipeResult(access: true, message: birthdayMessage)
        default:
            return SwipeResult(access: false, message: birthdayMessage)
        }
    }
    
    func swipe(rideAccess: RideAccess) -> SwipeResult {
        switch rideAccess {
        case .all:
            
            // Check if pass has a pass stamp and if it is swiped less than 5 seconds ago
            // If not then give new pass stamp
            if let lastSwipeDate = passSwipeStamp {
                if isPassSwipedTooSoon(timeOfLastSwipe: lastSwipeDate) {
                    return SwipeResult(access: false, message: " Sorry you have tried to access this ride in the last 5 seconds.")
                } else {
                    passSwipeStamp = Date()
                }
            } else {
                passSwipeStamp = Date()
            }
            return SwipeResult(access: true, message: birthdayMessage)
        case .skipLines:
                if self.guestType == .vip {
                    return SwipeResult(access: true, message: birthdayMessage)
                } else {
                    return SwipeResult(access: false, message: birthdayMessage)
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
