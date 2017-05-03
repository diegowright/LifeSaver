//
//  PainDurationCell.swift
//  Mobile Computing Project App
//
//  Created by Diego Wright on 4/16/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit

class PainDurationCell: UITableViewCell {
    
    @IBOutlet weak var durationInput: UITextField!
    @IBOutlet weak var unitControl: UISegmentedControl!

    static let painDurDescription = "Duration of your pain in hours, minutes, or seconds."
    
    var row:Int?
    
    @IBAction func sendDurationNotification(_ sender: Any) {
        self.sendNotification()
    }
    
    @IBAction func sendUnitNotification(_ sender: Any) {
        self.sendNotification()
    }
    
    func sendNotification() {
        let unit:Int = unitControl.selectedSegmentIndex
        let value:String = durationInput.text!
        var duration:Float = 0
        
        // Modify duration value to be in seconds
        if let floatValue = Float(value) {
            if floatValue > 0 {
                switch unit {
                case 0:
                    duration = floatValue * 24 * 60
                case 1:
                    duration = floatValue * 60
                case 2:
                    duration = floatValue
                default:
                    print("Default, something went wrong.")
                }
            } else {
                // send notification that pops up alert controller
                print("Need to enter a numerical value greater than 0")
                durationInput.text = ""
                return
            }
        } else {
            // send notification that pops up alert controller to tell them to not mess up next time
            print("Need to enter a numerical value greater than 0")
            durationInput.text = ""
            return
        }
        
        let dataDict:Dictionary<String, Any> = ["data":[duration, unitControl.selectedSegmentIndex],
                                                "row":self.row!]
        NotificationCenter.default.post(name: Notification.Name(rawValue: addDataKey),
                                        object: nil,
                                        userInfo: dataDict)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        durationInput.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControlEvents.editingDidEnd)
    }
    
    func textFieldDidChange (_ noteText: UITextField) {
        self.sendDurationNotification(self)
    }
}
