//
//  Entrant.swift
//  ParkPassGenerator
//
//  Created by Joshua Borck on 10/23/18.
//  Copyright © 2018 Joshua Borck. All rights reserved.
//

import Foundation

// Entrant to park and initializer
struct Entrant {
    let firstName: String?
    let lastName: String?
    let streetAddress: String?
    let city: String?
    let state: String?
    let zipCode: String?
    let ssn: Int?
    let dob: Date?
    
    // Initializer setting everything to nil by default. Checked for correct info in creation of pass.
    init(firstName: String? = nil, lastName: String? = nil, streetAddress: String? = nil, city: String? = nil, state: String? = nil, zipCode: String? = nil, ssn: Int? = nil, dob: Date? = nil) {
        self.firstName = firstName
        self.lastName = lastName
        self.streetAddress = streetAddress
        self.city = city
        self.state = state
        self.zipCode = zipCode
        self.ssn = ssn
        self.dob = dob
    }
    
}
