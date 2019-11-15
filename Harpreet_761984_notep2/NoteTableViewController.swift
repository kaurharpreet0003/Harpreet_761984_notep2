//
//  NoteTableViewController.swift
//  Harpreet_761984_notep2
//
//  Created by Megha Mahna on 2019-11-14.
//  Copyright © 2019 harpreet. All rights reserved.
//

import UIKit

class NoteTableViewController: UITableViewController {
   
     var array1 : [String]?
       var currentIndex = -1
       var flag = false
       @IBOutlet var table_view: UITableView!
       override func viewDidLoad() {
           super.viewDidLoad()
           array1 = [String]()
           // Uncomment the following line to preserve selection between presentations
           // self.clearsSelectionOnViewWillAppear = false

           // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
            self.navigationItem.rightBarButtonItem = self.editButtonItem
           self.navigationItem.rightBarButtonItem?.tintColor = UIColor.black
        self.navigationController?.toolbar.barTintColor = UIColor.lightGray
           
       }

       // MARK: - Table view data source

       override func numberOfSections(in tableView: UITableView) -> Int {
           // #warning Incomplete implementation, return the number of sections
           return 1
       }

       override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           // #warning Incomplete implementation, return the number of rows
           return note_Folder.folder1.count
       }

   
    @IBAction func NewFolder(_ sender: UIBarButtonItem) {
           
           let alert = UIAlertController(title: "New Folder", message: "Enter a name for this folder", preferredStyle: .alert)
           
           let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
           
           cancel.setValue(UIColor.brown, forKey: "titleTextColor")
           
           alert.addTextField { (UITextField) in
               UITextField.placeholder = "Name"
           }
           
           let addItem = UIAlertAction(title: "Add Item", style: .default) { (AlertAction) in
              let name = alert.textFields?.first?.text
              let folder = note_Folder(folder_name: name!, notes1: [])
                            
               for item in note_Folder.folder1{
                                    let temp = folder.folder_name
                                    if temp == item.folder_name{
                                        self.flag = true
                                        break
                                    }
                                }
                                if self.flag{
                                    let alertController = UIAlertController(title: "Name Taken", message: "Please choose a different name", preferredStyle: .alert)
                                    let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                                    alertController.addAction(ok)
                                    self.present(alertController, animated: true, completion: nil)
                                }
                                    
                                else{
                                   note_Folder.folder1.append(folder)
                                    self.table_view.reloadData()
                                }
                        }
               
           addItem.setValue(UIColor.black, forKey: "titleTextColor")
           alert.addAction(cancel)
           alert.addAction(addItem)
           self.present(alert, animated: true, completion: nil)
           
       }

       override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
           if let cell = tableView.dequeueReusableCell(withIdentifier: "reuse"){
               let cell1 = note_Folder.folder1[indexPath.row].folder_name
               cell.imageView?.image = UIImage(named: "folder-icon")
               cell.textLabel!.text = cell1
               cell.detailTextLabel?.text = "\(note_Folder.folder1[indexPath.row].notes1.count)"
               cell.detailTextLabel?.textColor = UIColor.white

               return cell
           }
           

           // Configure the cell...

           return UITableViewCell()
       }
      

       /*
       // Override to support conditional editing of the table view.
       override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
           // Return false if you do not want the specified item to be editable.
           return true
       }
       */

       
       // Override to support editing the table view.
       override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           if editingStyle == .delete {
               // Delete the row from the data source
               //tableView.deleteRows(at: [indexPath], with: .fade)
               note_Folder.folder1.remove(at: indexPath.row)
               table_view.reloadData()
           }
           //else if editingStyle == .insert {
               // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
           }
     
       

     
        //Override to support rearranging the table view.
       override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

       }
       
       override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {

           if tableView.isEditing{
               return .none
           }
           else{
               return .delete
           }
       }
       
       override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
           
           return false
       }
       
       func folder_reload(){
              tableView.reloadData()
          }

       /*
       // Override to support conditional rearranging of the table view.
       override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
           // Return false if you do not want the item to be re-orderable.
           return true
       }
       */

       
       // MARK: - Navigation

       // In a storyboard-based application, you will often want to do a little preparation before navigation
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           // Get the new view controller using segue.destination.
           // Pass the selected object to the new view controller.
           if let detailView = segue.destination as? taskTableViewController {
               detailView.folderDeligate = self
               if let tableViewCell = sender as? UITableViewCell {
                   if let index = tableView.indexPath(for: tableViewCell)?.row {
                    //detailView.text = Folder.folders[index]
                            currentIndex = index
                   }
               }
           }
       }
       

}
