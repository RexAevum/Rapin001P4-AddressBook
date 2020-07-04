//
//  ViewController.swift
//  Rapin001P4
//
//  Created by Rolans Apinis on 7/1/20.
//  Copyright © 2020 Rolans Apinis. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController, UITextFieldDelegate {

    var detailedContact: Contact!
    
    
    @IBOutlet var firstNameField: UITextField!
    @IBOutlet var lastNameField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var addressField: UITextField!
    @IBOutlet var phoneNumberField: UITextField!
    @IBOutlet var birthDateField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        emailField.keyboardType = .emailAddress
        phoneNumberField.keyboardType = .namePhonePad
    
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        firstNameField.text = detailedContact.firstName
        lastNameField.text = detailedContact.lastName
        emailField.text = detailedContact.email
        addressField.text = detailedContact.address
        phoneNumberField.text = detailedContact.phoneNumber
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .long
        
        birthDateField.text = dateFormatter.string(from: detailedContact.birthDate!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //save the all the fields to DB
        
    }
 
}

