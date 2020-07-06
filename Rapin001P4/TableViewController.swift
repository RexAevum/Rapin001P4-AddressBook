//  PROGRAMMER: Rolans Apinis
//  PANTHERID: 6044121
//  CLASS: COP 465501 TR 5:00
//  INSTRUCTOR: Steve Luis ECS 282
//  ASSIGNMENT: Programming Assignment #4
//  DUE: Thursday 07/05/2020 //

import UIKit

class TableViewController: UITableViewController {
    var contactDB: ContactDB!
    var imageDB: ImageDB!
    

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        navigationItem.leftBarButtonItem = editButtonItem
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        
         //self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        //account for the status bar
       // let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        // insets acan be created and then other elements of the the tableView can follow the same insets
        /*
            let inset = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
            tableView.contentInset = inset
            tableView.scrollIndicatorInsets = inset
        */
        navigationItem.title = "Contacts"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    // MARK: - Table view data source
    // displays the designated number of
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    // handles how many cells need to be created
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contactDB.allContacts.count
    }

    // handles what each cell will print
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        
        let name = contactDB.allContacts[indexPath.row]
        let printName = name.firstName + "\t" + name.lastName
        print(printName)
        cell.textLabel?.text = printName

        return cell
    }
    
    /*
    //add new contact buton - is later done by segue
    @IBAction func addNewContact(_ sender: Any) {
        //create new contact
        let new = contactDB.createNew(firstName: nil, lastName: nil)
        
        //get the index number of the new contact
        if let newIndex = contactDB.allContacts.index(of: new){
            // create an IndexPath using the index of the new item
            // row: index; section: which section does it go into
            let indexPath = IndexPath(row: newIndex, section: 0)
            
            //lastly add the row for the new entry
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
        tableView.reloadData()
    }
 */
 
    /*
    // when you press edit, table view goes into editing mode, when you press done it exits editing mode
    // not needed when using navigation controll with editButtonItem
    @IBAction func toggelEditingMode(_ sender: UIButton) {
        //update button based on if is editing
        if isEditing{
            sender.setTitle("Edit", for: .normal)
            setEditing(false, animated: true)
        }
        else{
            sender.setTitle("Done", for: .normal)
            setEditing(true, animated: true)
        }
    }
    */
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // function that allows for you to change 
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Bye!"
    }
    
    
    // Override to support editing the table view.
    //actualy enables the editing and what it can do
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            //get the contact to be deleted
            let contactToDelete = contactDB.allContacts[indexPath.row]
            
            //set up an alert to make sure the user wants to delete the contact
            let title = "Delete Contact"
            let message = "Are you sure you want to delet \(contactToDelete.firstName) \(contactToDelete.lastName)"
            //create the alert (.alert or .actionSheet)
            let alertControllerDelete = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            
            //add actions to the the allert
            // style affects the way the button text is displayed
            //handler is the action that happens when the option is selected form the UIAlertController
            let acCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertControllerDelete.addAction(acCancel)
            
            //add action to delete the item from collection and delete the row
            //the handler gets a closure that deletes the contact and row
            // {(action) -> Void in //delete lines, calls with self becasue closure
            let acDelete = UIAlertAction(title: "Delete For Ever", style: .destructive, handler: {(action) -> Void in
                // in closures need to add self. in front of all the calls
                self.imageDB.deleteImage(forKey: contactToDelete.imageKey!)
                self.contactDB.deleteContact(item: contactToDelete)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            })
            alertControllerDelete.addAction(acDelete)
            
            //need to presetn the alert after creating it, otherwise will just do logic without displaying anything or allowing for input
            
            present(alertControllerDelete, animated: true, completion: nil)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    
    // Override to support rearranging the table view.
    // allows you to move the objects around in the array in an interactive way
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
            contactDB.moveContact(from: fromIndexPath.row, to: to.row)
        
    }
 

    /*
    // Override to support conditional rearranging of the table view.
    // can make some rows unable to be moved
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        if (indexPath.row == contactDB.allContacts.count-1){
            return false
        }
        else{
            return true
        }
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        switch segue.identifier {
        case "showContactDetails"?:
            if let index = tableView.indexPathForSelectedRow?.row{
            
            let selectedContact = contactDB.allContacts[index]
            let detailView = segue.destination as! DetailedViewController
                
            detailView.detailedContact = selectedContact
            detailView.imageDB = imageDB
            }
        case "addNew"?:
            let new = Contact(firstName: nil, lastName: nil)
            contactDB.allContacts.append(new)
            
            let detailView = segue.destination as! DetailedViewController
            
            detailView.detailedContact = new
            detailView.imageDB = imageDB
            
        default:
            preconditionFailure("Unknown Segue")
        }
    }
    

}
