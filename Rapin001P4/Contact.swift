//
//  Contact.swift
//  Rapin001P4
//
//  Created by Rolans Apinis on 7/1/20.
//  Copyright © 2020 Rolans Apinis. All rights reserved.
//

import Foundation
import UIKit

class Contact: NSObject{
    private var firstName:String
    private var lastName:String
    private var email:String?
    private var address:String?
    private var phoneNumber:String?
    private var birthDate:Date?
    
    init(firstName: String, lastName: String, email: String, address: String, phoneNumber: String, bDate: Date) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.address = address
        self.phoneNumber = phoneNumber
        self.birthDate = bDate
        super.init()
    }
    // make a convenience init as requered - will use only first, last
    convenience init(firstName: String?, lastName: String?){
        if (firstName != nil || lastName != nil){
        self.init(firstName: firstName!, lastName: lastName!, email: "Add Email", address: "Add Address", phoneNumber: "Add Phone Number", bDate: Date())
        }
        else{
            self.init(firstName: "First Name", lastName: "Last Name", email: "Add Email", address: "Add Address", phoneNumber: "Add Phone Number", bDate: Date())
        }
    }
    
    
    //getters
    func getFirstName() -> String {
        return firstName
    }
    func getLastName() -> String {
        return lastName
    }
    func getEmail() -> String {
        return email ?? "Add Email"
    }
    func getAddress() -> String {
        return address ?? "Add Address"
    }
    func getPhoneNumber() -> String {
        return phoneNumber ?? "Add Number"
    }
    func getBirthDate() -> Date {
        return birthDate!
    }
}
