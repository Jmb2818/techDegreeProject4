//
//  SwipeResult.swift
//  ParkPassGenerator
//
//  Created by Joshua Borck on 10/23/18.
//  Copyright © 2018 Joshua Borck. All rights reserved.
//

import Foundation

// Struct for printout of the result of a swipe
struct SwipeResult {
    
    // MARK: Proeprties
    let access: Bool
    let description: String
    
    // MARK: Initializer that takes a modified message like a birthday message
    init(access: Bool, message: String = "") {
        self.access = access
        
        if access {
            self.description = ["Access Granted.", message].joined()
        } else {
            self.description = ["Access Denied.", message].joined()
        }
    }
    
    
}
