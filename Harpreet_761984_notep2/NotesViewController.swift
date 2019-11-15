//
//  NotesViewController.swift
//  Harpreet_761984_notep2
//
//  Created by Megha Mahna on 2019-11-14.
//  Copyright © 2019 harpreet. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController {
    var text_string: String?
    
    @IBOutlet weak var noteText: UITextView!
    weak var taskTable: taskTableViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        noteText.text = text_string ?? ""
        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
        taskTable?.update(text: noteText.text)
    }
}
