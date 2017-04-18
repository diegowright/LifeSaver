//
//  ShowNoteVC.swift
//  Mobile Computing Project App
//
//  Created by Diego Wright on 3/24/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit

class ShowNoteVC: UIViewController {

    @IBOutlet weak var eventType: UILabel!
    @IBOutlet weak var recordDate: UILabel!
    
    @IBOutlet weak var textView: UITextView!
    
    var noteText: String?
    var date: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Event View"
        
        self.eventType.text = "Note"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        dateFormatter.locale = NSLocale.autoupdatingCurrent
        self.recordDate.text = dateFormatter.string(from: self.date!)
        self.textView.text = self.noteText!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
