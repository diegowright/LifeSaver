//
//  NoteVC.swift
//  Mobile Computing Project App
//
//  Created by Diego Wright on 3/24/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit

class NoteVC: UIViewController {
    
    var alertController:UIAlertController? = nil

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var noteText: UITextView!
    
    var selectedDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Note"
        
        if let givenDate = self.selectedDate {
            self.datePicker.date = givenDate
        }

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveNote(_ sender: Any) {
        if self.noteText.text == "" {
            self.alertController = UIAlertController(title: "Hey!", message: "You must enter some text for this note",
                                                     preferredStyle: UIAlertControllerStyle.alert)
            let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                (action:UIAlertAction) in print("Ok pressed");
            }
            self.alertController!.addAction(OKAction)
            self.present(self.alertController!, animated: true, completion:nil)
            return
        }
        
        let date: Date = self.datePicker.date
        let noteText: String = self.noteText.text
        print(date, noteText)
        DataManager.saveNoteRecord(date: date, noteText: noteText)
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}
