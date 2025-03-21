//
//  TableViewController.swift
//  NotesApp
//
//  Created by Artem on 10.01.25.
//

import UIKit

class TableViewController: UITableViewController, UISearchBarDelegate {

    @IBAction func editAction(_ sender: Any) {
        tableView.setEditing(!tableView.isEditing, animated: true)
    }
    
    @IBAction func addAction(_ sender: Any) {
        let alertController = UIAlertController(title: "Create new notes", message: "Enter your text", preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "Enter text"
        }
        
        let alertCreate = UIAlertAction(title: "Create", style: .default) { button in
            let createNewNote = alertController.textFields?[0].text
            
            if createNewNote!.isEmpty {
                let errorMessage = UIAlertController(title: "Error", message: "You need to enter text", preferredStyle: .alert)
                let okErrorAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                errorMessage.addAction(okErrorAction)
                self.present(errorMessage, animated: true, completion: nil)
            } else {
                addItem(nameItem: createNewNote!)
            }
            
            self.tableView.reloadData()
        }
        alertController.addAction(alertCreate)
        
        let alertCancel = UIAlertAction(title: "Cancel", style: .destructive){ button in }
        alertController.addAction(alertCancel)
        
        present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.systemGray6
    
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notesApp.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let currentItem = notesApp[indexPath.row]
        cell.textLabel?.text = currentItem["Name"] as? String
        
        if (currentItem["Status"] as? Bool) == true {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }

        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            removeItem(index: indexPath.row)
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if changeStatus(item: indexPath.row) {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
    }

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        moveRow(fromIndex: fromIndexPath.row, toIndex: to.row)
        
        tableView.reloadData()
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
