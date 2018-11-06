//
//  GeneratorError.swift
//  ParkPassGenerator
//
//  Created by Joshua Borck on 10/24/18.
//  Copyright © 2018 Joshua Borck. All rights reserved.
//

import Foundation

// An enumeration of all the errors while generating a pass
enum GeneratorError: Error {
    case missingInformation(String)
    case olderThanFive(String)
}
