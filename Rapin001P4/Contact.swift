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
    var firstName:String
    var lastName:String
    var email:String?
    var address:String?
    var phoneNumber:String?
    var birthDate:Date?
    var imageKey: String?
    
    init(firstName: String, lastName: String, email: String, address: String, phoneNumber: String, bDate: Date) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.address = address
        self.phoneNumber = phoneNumber
        self.birthDate = bDate
        self.imageKey = UUID().uuidString // creates a uniqe ID as a string
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
    
    
}
