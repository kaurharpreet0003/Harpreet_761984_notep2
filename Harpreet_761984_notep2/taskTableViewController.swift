//
//  taskTableViewController.swift
//  Harpreet_761984_notep2
//
//  Created by Megha Mahna on 2019-11-14.
//  Copyright © 2019 harpreet. All rights reserved.
//

import UIKit

class taskTableViewController: UITableViewController {

    @IBOutlet weak var trashButton: UIBarButtonItem!
    @IBOutlet weak var trayArrow: UIBarButtonItem!
    var folderDeligate : NoteTableViewController?
    var rowSelection : [IndexPath]?
       
       //var note : [String]?
       var currentIndex = -1
       override func viewDidLoad() {
           super.viewDidLoad()

           // Uncomment the following line to preserve selection between presentations
           // self.clearsSelectionOnViewWillAppear = false

           // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
           // self.navigationItem.rightBarButtonItem = self.editButtonItem
       //note = []
           trashButton.isEnabled = false
           trayArrow.isEnabled = false

       // MARK: - Table view data source
       
       }
       override func numberOfSections(in tableView: UITableView) -> Int {
           // #warning Incomplete implementation, return the number of sections
           return 1
       }

       override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           // #warning Incomplete implementation, return the number of rows
           return note_Folder.folder1[(folderDeligate?.currentIndex)!].notes1.count
       }

     
       override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           if let cell = tableView.dequeueReusableCell(withIdentifier: "folder") {
               cell.textLabel?.text = note_Folder.folder1[(folderDeligate?.currentIndex)!].notes1[indexPath.row]
           cell.accessoryType = .detailButton
           cell.backgroundColor = .systemGray
           // Configure the cell...

           return cell
           }
           return UITableViewCell()
       }
       
       override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
       }
       /*
       // Override to support conditional editing of the table view.
       override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
           // Return false if you do not want the specified item to be editable.
           return true
       }
       */
       override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
           tableView.cellForRow(at: indexPath)?.accessoryType = .detailButton
       }
    
    
    @IBAction func threeDotsButton(_ sender: UIBarButtonItem) {
        if trashButton.isEnabled == true && trayArrow.isEnabled == true{
                      trashButton.isEnabled = false
                      trayArrow.isEnabled = false
                  }
                  else if trashButton.isEnabled == false && trayArrow.isEnabled == false{
                      trashButton.isEnabled = true
                      trayArrow.isEnabled = true
                  }
    }
    
    @IBAction func trash(_ sender: UIBarButtonItem) {
        let alert2 = UIAlertController(title: "Delete ", message: "Are you sure", preferredStyle: .alert)
                          
                  let Cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                  
                  Cancel.setValue(UIColor.brown, forKey: "titleTextColor")
                  let trash = UIAlertAction(title: "Delete", style: .default)
                  {
                  (action) in
                                 
                      if let row_selected = self.tableView.indexPathsForSelectedRows {
                              
                                 var item = [String]()
                                 for indexPath in row_selected  {
                                     item.append(note_Folder.folder1[(self.folderDeligate?.currentIndex)!].notes1[indexPath.row])
                                 }
                                 for n in item {
                                     if let index = note_Folder.folder1[(self.folderDeligate?.currentIndex)!].notes1.index(of: n) {
                                      note_Folder.folder1[(self.folderDeligate?.currentIndex)!].notes1.remove(at: index)
                                     }
                                 }
                                     self.tableView.deleteRows(at: row_selected, with: .automatic)
                                     self.tableView.reloadData()
                                 }
                                 }
                                              trash.setValue(UIColor.red, forKey: "titleTextColor")
                                              alert2.addAction(Cancel)
                                              alert2.addAction(trash)
                                              self.present(alert2, animated: true, completion: nil)
    }
    
      

       /*
       // Override to support editing the table view.
       override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           if editingStyle == .delete {
               // Delete the row from the data source
               tableView.deleteRows(at: [indexPath], with: .fade)
           } else if editingStyle == .insert {
               // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
           }
       }
       */

       /*
       // Override to support rearranging the table view.
       override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

       }
       */

       /*
       // Override to support conditional rearranging of the table view.
       override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
           // Return false if you do not want the item to be re-orderable.
           return true
       }
       */
       
    
    func move(index: Int){
        
        rowSelection = tableView.indexPathsForSelectedRows!
        
        for i in rowSelection!{
            let move = note_Folder.folder1[(folderDeligate?.currentIndex)!].notes1[i.row]
            note_Folder.folder1[index].notes1.append(move)
        }
        
        deleteRows()
    }
    
    
       // MARK: - Navigation

       // In a storyboard-based application, you will often want to do a little preparation before navigation
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           // Get the new view controller using segue.destination.
           // Pass the selected object to the new view controller.
           
                   if let detailView = segue.destination as? NotesViewController {
                                  detailView.taskTable = self
                                  if let tableviewcell = sender as? UITableViewCell {
                                             if let index = tableView.indexPath(for: tableviewcell)?.row {
                                                 detailView.text_string = note_Folder.folder1[(folderDeligate?.currentIndex)!].notes1[index]
                                                 currentIndex = index
                                             }
                                         }
           }
       }
    func update(text : String){
           if currentIndex != -1 {
             note_Folder.folder1[(folderDeligate?.currentIndex)!].notes1[currentIndex] = text
               let indexPath = IndexPath(item: currentIndex, section: 0)
               tableView.reloadRows(at: [indexPath], with: .none)
               currentIndex = -1
           }
           else if currentIndex == -1 {
               note_Folder.folder1[(folderDeligate?.currentIndex)!].notes1.append(text)
               tableView.reloadData()
               folderDeligate?.folder_reload()

           }
          
        }
    func deleteRows(){
            
            rowSelection = tableView.indexPathsForSelectedRows!
            var items = [String]()
            for indexpath in rowSelection!{
                
                items.append(note_Folder.folder1[(folderDeligate?.currentIndex)!].notes1[indexpath.row])
                
            
            for value in items{
                
                if let index = note_Folder.folder1[(folderDeligate?.currentIndex)!].notes1.firstIndex(of: value)
                {
                    note_Folder.folder1[(folderDeligate?.currentIndex)!].notes1.remove(at: index)
                }
            }
            tableView.reloadData()
            folderDeligate?.tableView.reloadData()
        }
    }
}
