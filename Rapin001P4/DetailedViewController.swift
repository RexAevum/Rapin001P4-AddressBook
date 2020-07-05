//
//  ViewController.swift
//  Rapin001P4
//
//  Created by Rolans Apinis on 7/1/20.
//  Copyright © 2020 Rolans Apinis. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController, UITextFieldDelegate {

    var detailedContact: Contact!{
        didSet{
            navigationItem.title = detailedContact.firstName + " " + detailedContact.lastName
        }
    }
    
    
    @IBOutlet var firstNameField: UITextField!
    @IBOutlet var lastNameField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var addressField: UITextField!
    @IBOutlet var phoneNumberField: UITextField!
    @IBOutlet var birthDateField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //set keyboards
        emailField.keyboardType = .emailAddress
        phoneNumberField.keyboardType = .phonePad
        
        //set clear button
        firstNameField.clearButtonMode = .whileEditing
        lastNameField.clearButtonMode = .whileEditing
        emailField.clearButtonMode = .whileEditing
        addressField.clearButtonMode = .whileEditing
        phoneNumberField.clearButtonMode = .whileEditing
        
        //disable date field for now
        birthDateField.isUserInteractionEnabled = false
    
    }
    
    // what to do when user presses return on the keyboard during editing
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        //self.view.endEditing(true)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        if (detailedContact.firstName != "First Name"){
             firstNameField.text = detailedContact.firstName
        }else{
            firstNameField.placeholder = detailedContact.firstName
        }
       
        if(detailedContact.lastName != "Last Name"){
            lastNameField.text = detailedContact.lastName
        }else{
            lastNameField.placeholder = detailedContact.lastName
        }
        
        if(detailedContact.email != "Add Email"){
            emailField.text = detailedContact.email
        }else{
            emailField.placeholder = detailedContact.email
        }
        
        if(detailedContact.address != "Add Address"){
            addressField.text = detailedContact.address
        }else{
            addressField.placeholder = detailedContact.address
        }
        
        if(detailedContact.phoneNumber != "Add Phone Number"){
            phoneNumberField.text = detailedContact.phoneNumber
        }else{
            phoneNumberField.placeholder = detailedContact.phoneNumber
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .medium
        dateFormatter.dateStyle = .long
        
        birthDateField.text = dateFormatter.string(from: detailedContact.birthDate!)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // action that is done right before the top view is poped and deleted
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // can dismiss editng to make the transition smoother, otherwise the keyboard will just disapear without an animation which is not as nice to the user
        self.view.endEditing(true)
        
        //save the all the fields to DB
        //works since item is passed as a reference, not value!!!! Would not work with struct
        if(firstNameField.text! != ""){
            detailedContact.firstName = firstNameField.text!}
        if(lastNameField.text! != ""){
            detailedContact.lastName = lastNameField.text!}
        if(emailField.text! != ""){
            detailedContact.email = emailField.text!}
        if(addressField.text != ""){
            detailedContact.address = addressField.text!}
        if(phoneNumberField.text != ""){
            detailedContact.phoneNumber = phoneNumberField.text!}
        if(birthDateField != nil){
            detailedContact.birthDate = Date()}
        
        
    }
 
}

