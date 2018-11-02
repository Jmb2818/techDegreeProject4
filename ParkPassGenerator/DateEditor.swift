//
//  DateEditor.swift
//  ParkPassGenerator
//
//  Created by Joshua Borck on 10/23/18.
//  Copyright © 2018 Joshua Borck. All rights reserved.
//

import Foundation

class DateEditor {
    static var formatter = DateFormatter()
    
    static func createDateOfBirthDate(fromString string: String) -> Date? {
        formatter.dateFormat = "MM/dd/yyyy"
        
        guard let dateOfBirth = formatter.date(from: string) else {
            return nil
        }
        return dateOfBirth
    }
    
    static func isBirthday(dateOfBirth: Date) -> Bool {
        formatter.dateFormat = "MMM d"
        let birthDay = formatter.string(from: dateOfBirth)
        let currentDate = formatter.string(from: Date())
        return birthDay == currentDate
    }
}
