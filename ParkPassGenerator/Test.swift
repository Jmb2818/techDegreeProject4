//
//  Test.swift
//  ParkPassGenerator
//
//  Created by Joshua Borck on 11/4/18.
//  Copyright © 2018 Joshua Borck. All rights reserved.
//

import Foundation

class Test {
    
    // MARK: Properties to mock data entered
    let dateOfBirthBirthday = DateEditor.createDateOfBirthDate(fromString: [DateEditor.getCurrentDateMonthDay(), "/1995"].joined())
    let employeeEntrant = Entrant(firstName: "Luke", lastName: "Skywalker", streetAddress: "1000 Jabba Place", city: "Mos Eisley", state: "Tatooine", zipCode: "54321", ssn: 123456789, dob: DateEditor.createDateOfBirthDate(fromString: "02/03/1982"))
    let semiEmployeeEntrant = Entrant(firstName: "Han", streetAddress: "Melennium Falcon", dob: DateEditor.createDateOfBirthDate(fromString: "02/03/1982"))
    let guestEntrant = Entrant()
    let guestEntrantAdult = Entrant(dob: DateEditor.createDateOfBirthDate(fromString: "02/03/1982"))
    let childGuestEntrant = Entrant(dob: DateEditor.createDateOfBirthDate(fromString: "01/02/2016"))
    let guestEntrantBirthday = Entrant(dob: DateEditor.createDateOfBirthDate(fromString: [DateEditor.getCurrentDateMonthDay(), "/1995"].joined()))
    
    // MARK: Main Test Function
    // Called from ViewController. Comment out the tests you do not want run here
    func runTests() {
//        createVipGuestPass()
//        createChildGuestPass()
//        createClassicGuestPass()
//        createFoodEmployeePass()
//        createGuestBirthdayPass()
//        createChildPassOlder()
//        createChildpPassNoDob()
//        createPassSwipedTooSoon()
//        createEmployeeManagerPass()
//        createMaintenanceEmployeePass()
//        createRideOperatorEmployeePass()
//        createEmployeeMissingInformationPass()
//        createManagerPassMissingManagerType()
    }
    
    // MARK: Helper Functions to mock data
    func createFoodEmployeePass() {
        do {
            let pass = try EmployeePass(entrant: employeeEntrant, employeeType: .food)
            testPass(pass: pass)
        } catch GeneratorError.missingInformation(let description) {
            print(description)
        } catch(let error) {
            print(error)
        }
    }
    
    func createClassicGuestPass() {
        do {
            let pass = try GuestPass(entrant: guestEntrant, guestType: .classic)
            testPass(pass: pass)
        } catch(let error) {
            print(error)
        }
    }
    
    func createVipGuestPass() {
        do {
            let pass = try GuestPass(entrant: guestEntrant, guestType: .vip)
            testPass(pass: pass)
        } catch(let error) {
            print(error)
        }
    }
    
    func createChildGuestPass() {
        do {
            let pass = try GuestPass(entrant: childGuestEntrant, guestType: .child)
            testPass(pass: pass)
        } catch GeneratorError.missingInformation(let description){
            print(description)
        } catch GeneratorError.olderThanFive(let description) {
            print(description)
        } catch(let error) {
            print(error)
        }
    }
    
    func createGuestBirthdayPass() {
        do {
            let pass = try GuestPass(entrant: guestEntrantBirthday, guestType: .classic)
            testPass(pass: pass)
        } catch(let error) {
            print(error)
        }
    }
    
    func createPassSwipedTooSoon() {
        do {
            let pass = try GuestPass(entrant: guestEntrant, guestType: .classic)
            testPass(pass: pass)
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                self.testPass(pass: pass)
            }
        } catch(let error) {
            print(error)
        }
    }
    
    func createChildPassOlder() {
        do {
            let pass = try GuestPass(entrant: guestEntrantAdult, guestType: .child)
            testPass(pass: pass)
        } catch GeneratorError.missingInformation(let description){
            print(description)
        } catch GeneratorError.olderThanFive(let description) {
            print(description)
        } catch(let error) {
            print(error)
        }
    }
    
    func createChildpPassNoDob() {
        do {
            let pass = try GuestPass(entrant: guestEntrant, guestType: .child)
            testPass(pass: pass)
        } catch GeneratorError.missingInformation(let description){
            print(description)
        } catch GeneratorError.olderThanFive(let description) {
            print(description)
        } catch(let error) {
            print(error)
        }
    }
    
    func createRideOperatorEmployeePass() {
        do {
            let pass = try EmployeePass(entrant: employeeEntrant, employeeType: .ride)
            testPass(pass: pass)
        } catch GeneratorError.missingInformation(let description) {
            print(description)
        } catch(let error) {
            print(error)
        }
    }
    
    func createMaintenanceEmployeePass() {
        do {
            let pass = try EmployeePass(entrant: employeeEntrant, employeeType: .maintenance)
            testPass(pass: pass)
        } catch GeneratorError.missingInformation(let description) {
            print(description)
        } catch(let error) {
            print(error)
        }
    }
    
    func createEmployeeMissingInformationPass() {
        do {
            let pass = try EmployeePass(entrant: semiEmployeeEntrant, employeeType: .maintenance)
            testPass(pass: pass)
        } catch GeneratorError.missingInformation(let description) {
            print(description)
        } catch(let error) {
            print(error)
        }
    }
    
    func createEmployeeManagerPass() {
        do {
            let pass = try EmployeePass(entrant: employeeEntrant, employeeType: .manager, managementType: .shiftManager)
            testPass(pass: pass)
        } catch GeneratorError.missingInformation(let description) {
            print(description)
        } catch(let error) {
            print(error)
        }
    }
    
    func createManagerPassMissingManagerType() {
        do {
            let pass = try EmployeePass(entrant: employeeEntrant, employeeType: .manager)
            testPass(pass: pass)
        } catch GeneratorError.missingInformation(let description) {
            print(description)
        } catch(let error) {
            print(error)
        }
    }
    
    
    // MARK: Function to imitate the pass being swiped at each kiosk
    func testPass(pass: Pass) {
        print("\(pass.passType) Pass swiped")
        print("")
        print("__________________")
        print("Area Access:")
        print("")
        print("Amusement Areas - \(pass.swipe(for: .amusement).description)")
        print("Ride Control Areas - \(pass.swipe(for: .rideControl).description)")
        print("Kitchen Areas - \(pass.swipe(for: .kitchen).description)")
        print("Maintenance Areas - \(pass.swipe(for: .maintenance).description)")
        print("Office Areas - \(pass.swipe(for: .office).description)")
        print("")
        print("__________________")
        print("Ride Access:")
        print("")
        print("All Rides - \(pass.swipe(rideAccess: .all).description)")
        print("Skip Lines - \(pass.swipe(rideAccess: .skipLines).description)")
        print("")
        print("__________________")
        print("Discounts")
        print("")
        print("You can get \(pass.swipe(discountOn: .food))% off of food and \(pass.swipe(discountOn: .merchandise))% off of mechandise.")
    }
}
