//
//  ContactDB.swift
//  Rapin001P4
//
//  Created by Rolans Apinis on 7/1/20.
//  Copyright © 2020 Rolans Apinis. All rights reserved.
//

import Foundation
import UIKit

class ContactDB{
    
    var allContacts: [Contact] = []
    
    init() {
        createNew(firstName: "C", lastName: "C")
        createNew(firstName: "Faust", lastName: "D")
        createNew(firstName: "Foot", lastName: "Man")
    }

    //discardable result let's the returned value be ignored; do not need to asighn to variable
    @discardableResult func createNew(firstName: String?, lastName: String?) -> Contact {
        let new = Contact(firstName: firstName, lastName: lastName)
        allContacts.append(new)
        return new
    }
    
    // a function that will delete an element at an index
    func deleteContact(item: Contact) -> Void {
        // get index of
        if let index = allContacts.index(of: item){
            allContacts.remove(at: index)
        }
    }
    
    // function to allow the moving of items in the array
    func moveContact(from fromIndex: Int, to toIndex: Int) -> Void{
        if (fromIndex == toIndex) {return}
        
        let movingContact = allContacts[fromIndex]
        
        allContacts.remove(at: fromIndex)
        
        allContacts.insert(movingContact, at: toIndex)
    }
    
}
