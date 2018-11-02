//
//  ViewController.swift
//  ParkPassGenerator
//
//  Created by Joshua Borck on 10/23/18.
//  Copyright © 2018 Joshua Borck. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let birthDateString = "09/10/2016"
        guard let birthDate = DateEditor.createDateOfBirthDate(fromString: birthDateString) else {
            return
        }
        let foodEmployee = Entrant(firstName: "Josh", streetAddress: "10156 Deere Drive", city: "Davison", zipCode: "48423", dob: birthDate)
        let childPass = Entrant(dob: birthDate)
        do {
            let pass = try EmployeePass(entrant: foodEmployee, employeeType: .food)
            let childsPass = try GuestPass(entrant: childPass, guestType: .child)
            let result = childsPass.swipe(for: .maintenance)
            let secondResult = childsPass.swipe(for: .kitchen)
            let discountResult = childsPass.swipe(discountOn: .food)
            print("Maintenance Area: \(result.description)")
            print("Kitchen Area: \(secondResult.description)")
            print("Your food discount is \(discountResult)%")
        } catch GeneratorError.missingInformation(let description) {
            print(description)
        } catch(let error) {
            print(error)
        }
        // Do any additional setup after loading the view, typically from a nib.
    }


}

