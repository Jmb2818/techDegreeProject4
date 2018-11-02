//
//  Pass.swift
//  ParkPassGenerator
//
//  Created by Joshua Borck on 11/1/18.
//  Copyright © 2018 Joshua Borck. All rights reserved.
//

import Foundation

protocol Pass {
    var entrant: Entrant { get set }
    var isBirthday: Bool { get }
    var passSwipeStamp: Date? { get set }
    func swipe(for areaAcess: AreaAccess) -> SwipeResult
    func swipe(rideAccess: RideAccess) -> SwipeResult
    func swipe(discountOn: DiscountAccess) -> Int
}
extension Pass {
    var birthdayMessage: String {
        if isBirthday {
            return " Hope you have a wonderful birthday!"
        } else {
            return ""
        }
    }
    
   func isPassSwipedTooSoon(timeOfLastSwipe: Date) -> Bool {
        
        let timeOfLastSwipeInSeconds = timeOfLastSwipe.timeIntervalSince1970
        let timeNowInSeconds = Date().timeIntervalSince1970
        let timeDifference = timeNowInSeconds - timeOfLastSwipeInSeconds
        if timeDifference > 5 {
            return true
        }
        return false
    }
}
