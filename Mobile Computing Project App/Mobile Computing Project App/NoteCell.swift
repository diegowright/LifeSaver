//
//  NoteCell.swift
//  Mobile Computing Project App
//
//  Created by Diego Wright on 4/16/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit

class NoteCell: UITableViewCell {

    @IBOutlet weak var noteText: UITextField!
    
    static let noteDescription = "Small comment about your pain or ailment."
    
    var row:Int?
    
    @IBAction func sendNoteNotification(_ sender: Any) {
        let dataDict:Dictionary<String, Any> = ["data":noteText.text!,
                                                "row":self.row!]
        NotificationCenter.default.post(name: Notification.Name(rawValue: addDataKey),
                                        object: nil,
                                        userInfo: dataDict)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        noteText.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControlEvents.editingDidEnd)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func textFieldDidChange (_ noteText: UITextField) {
        self.sendNoteNotification(self)
    }
}
