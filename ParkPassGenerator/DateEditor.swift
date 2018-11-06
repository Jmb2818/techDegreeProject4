//
//  DateEditor.swift
//  ParkPassGenerator
//
//  Created by Joshua Borck on 10/23/18.
//  Copyright © 2018 Joshua Borck. All rights reserved.
//

import Foundation

// Class created to format dates into various needed formats
class DateEditor {
    static var formatter = DateFormatter()
    
    // Function to format date of birth entered as string by user to actual date
    static func createDateOfBirthDate(fromString string: String) -> Date? {
        formatter.dateFormat = "MM/dd/yyyy"
        
        guard let dateOfBirth = formatter.date(from: string) else {
            return nil
        }
        return dateOfBirth
    }
    
    // Function to check if the date of birth of an entrant is the same date as current date
    static func isBirthday(dateOfBirth: Date) -> Bool {
        formatter.dateFormat = "MMM d"
        let birthDay = formatter.string(from: dateOfBirth)
        let currentDate = formatter.string(from: Date())
        return birthDay == currentDate
    }
    
    // Function to get current Date's month and day
    static func getCurrentDateMonthDay() -> String {
        formatter.dateFormat = "MMM d"
        return formatter.string(from: Date())
    }
}
