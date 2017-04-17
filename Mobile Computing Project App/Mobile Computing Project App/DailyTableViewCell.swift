//
//  DailyTableViewCell.swift
//  Mobile Computing Project App
//
//  Created by Robin Stewart on 4/14/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit

class DailyTableViewCell: UITableViewCell {

    @IBOutlet weak var timePickerOutlet: UIDatePicker!
    @IBOutlet weak var pickerHeightConstraint: NSLayoutConstraint!
    
    @IBAction func pickerAction(_ sender: Any) {
        let dataDict:Dictionary = ["Daily":timePickerOutlet.date]
        NotificationCenter.default.post(name: Notification.Name(rawValue: "dailyPickerTime"), object: nil, userInfo: dataDict)
    }
    
    var isExpanded:Bool = false {
        didSet {
            if !isExpanded {
                self.pickerHeightConstraint.constant = 0
            } else {
                self.pickerHeightConstraint.constant = 111.0
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
