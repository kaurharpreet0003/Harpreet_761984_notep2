//
//  moveViewController.swift
//  Harpreet_761984_notep2
//
//  Created by Megha Mahna on 2019-11-14.
//  Copyright © 2019 harpreet. All rights reserved.
//

import UIKit

class moveViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var notesDeligate : taskTableViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return note_Folder.folder1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard note_Folder.folder1.count != 0 else{
            return UITableViewCell()
        }
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "")
        cell.textLabel?.text = note_Folder.folder1[indexPath.row].folder_name
        cell.backgroundColor = UIColor.systemGray
        return cell

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let alertController1 = UIAlertController(title: " move to \(note_Folder.folder1[indexPath.row].folder_name)", message: "Are  you sure", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "No", style: .default, handler: nil)
        let okAction = UIAlertAction(title: "Move", style: .default)
        { (action) in
            
            self.notesDeligate?.move(index: indexPath.row)
             self.presentingViewController?.dismiss(animated: true, completion: nil)
            
        }
            
        alertController1.addAction(okAction)
        alertController1.addAction(cancelAction)
        self.present(alertController1, animated: true, completion:  nil)
                           
    }
    

    @IBAction func cancelButton(_ sender: UIButton) {
              self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


}
