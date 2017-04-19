//
//  PainTypeCell.swift
//  Mobile Computing Project App
//
//  Created by Diego Wright on 4/16/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit

class PainTypeCell: UITableViewCell {

    @IBOutlet weak var painTypeControl: UISegmentedControl!
    
    static let painTypeDescription = "Indicates which of four pain types your pain was most like."
    
    var row:Int?
    
    @IBAction func sendPainTypeNotification(_ sender: Any) {
        let idx:Int16 = Int16(painTypeControl.selectedSegmentIndex)
        let dataDict:Dictionary<String, Any> = ["data":idx,
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
    }
}
