//
//  SwipeResult.swift
//  ParkPassGenerator
//
//  Created by Joshua Borck on 10/23/18.
//  Copyright © 2018 Joshua Borck. All rights reserved.
//

import Foundation

struct SwipeResult {
    let access: Bool
    let description: String
    
    init(access: Bool, message: String = "") {
        self.access = access
        
        if access {
            self.description = ["Access Granted", message].joined()
        } else {
            self.description = ["Access Denied", message].joined()
        }
    }
    
    
}
