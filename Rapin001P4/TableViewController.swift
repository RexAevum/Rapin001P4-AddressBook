//
//  TableViewController.swift
//  Rapin001P4
//
//  Created by Rolans Apinis on 7/2/20.
//  Copyright © 2020 Rolans Apinis. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    var contactDB: ContactDB!
    

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        
         //self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        //account for the status bar
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        // insets acan be created and then other elements of the the tableView can follow the same insets
        let inset = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = inset
        tableView.scrollIndicatorInsets = inset
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contactDB.allContacts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        
        let name = contactDB.allContacts[indexPath.row]
        let printName = name.getFirstName() + "\t" + name.getLastName()
        print(printName)
        cell.textLabel?.text = printName

        return cell
    }
    
    //add new contact buton
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
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let contactToDelete = contactDB.allContacts[indexPath.row]
            contactDB.deleteContact(item: contactToDelete)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        contactDB.moveContact(from: fromIndexPath.row, to: to.row)
    }
 

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
     */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
