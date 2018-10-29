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
        let birthDateString = "09/10/1991"
        guard let birthDate = DateEditor.createDateOfBirthDate(fromString: birthDateString) else {
            return
        }
        let foodEmployee = Entrant(firstName: "Josh", streetAddress: "10156 Deere Drive", city: "Davison", zipCode: "48423", dob: birthDate)
        do {
            let pass = try EmployeePass(entrant: foodEmployee, employeeType: .food)
            let result = pass.swipe(for: .maintenance)
            let secondResult = pass.swipe(for: .kitchen)
            let discountResult = pass.swipe(discountOn: .food)
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

