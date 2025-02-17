//  PROGRAMMER: Rolans Apinis
//  PANTHERID: 6044121
//  CLASS: COP 465501 TR 5:00
//  INSTRUCTOR: Steve Luis ECS 282
//  ASSIGNMENT: Programming Assignment #4
//  DUE: Thursday 07/05/2020 //

import UIKit

class DetailedViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    // variables for needed objects - contact and images
    var detailedContact: Contact!{
        // did set will run code once the variable is modefied
        didSet{
            navigationItem.title = detailedContact.firstName + " " + detailedContact.lastName
        }
    }
    
    var imageDB: ImageDB!
    
    
    @IBOutlet var firstNameField: UITextField!
    @IBOutlet var lastNameField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var addressField: UITextField!
    @IBOutlet var phoneNumberField: UITextField!
    @IBOutlet var birthDateField: UITextField!
    @objc var localDatePicker: UIDatePicker!
    
    @IBOutlet var userPhoto: UIImageView!
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // add date picker to view when it initaly loads
        localDatePicker = UIDatePicker()
        localDatePicker.datePickerMode = .date
        
        //add toolbar to keyboard
        let tool = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 20))
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(DetailedViewController.exitInput))
        let x = [doneButton]
        
        tool.items = x
        tool.sizeToFit()
        
        //set views for date picker
        birthDateField.inputView = localDatePicker
        birthDateField.inputAccessoryView = tool
       
        
        localDatePicker.addTarget(self, action: #selector(DetailedViewController.getDate(x:)), for: .valueChanged)
        
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
        //birthDateField.isUserInteractionEnabled = false
    
    }
    
    //MARK: Date Picker
    @objc func getDate(x: UIDatePicker) -> Void{
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MM/dd/yyyy"
        
        let newDate = dateFormat.string(from: x.date)
        birthDateField.text = newDate
        detailedContact.birthDate = x.date
        //self.view.endEditing(true)
    }
    
    @objc func exitInput(){
        self.resignFirstResponder()
        self.view.endEditing(true)
    }
  
    //MARK: Text Field Delegates
    // what to do when user presses return on the keyboard during editing
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        //self.view.endEditing(true)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    

    //MARK: Setting up View
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        //set image
        
        userPhoto.image = imageDB.returnImage(forKey: detailedContact.imageKey!)
        
        // populate teh text fields
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
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
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
        if(birthDateField.text != ""){
            detailedContact.birthDate = localDatePicker.date}
        
        
    }

    
    
    //----------------------------------------------------------
    //MARK: Image Handeling
    @IBAction func takePicture(_ sender: UIBarButtonItem) {
        
        let imagePicker = UIImagePickerController()
        
        // select source type
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            imagePicker.sourceType = .camera
        }else{
            imagePicker.sourceType = .photoLibrary
        }
        
        // have to import both UINavigationControllerDelegate and UIImagePickerControllerDelegate
        imagePicker.delegate = self
        
        //by calling present you are moving a view to be displayed, transition between views
        present(imagePicker, animated: true, completion: nil)
    }
    
    // returns image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // get image
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        //set the imageView as the selected image
        
        userPhoto.image = image
        imageDB.setImage(image, forKey: detailedContact.imageKey!)
        
        // need to dismiss once an image has been seleted
        
        dismiss(animated: true, completion: nil)
    }
    
}

