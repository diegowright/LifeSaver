//
//  PainLevelCell.swift
//  Mobile Computing Project App
//
//  Created by Diego Wright on 4/16/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit

class PainLevelCell: UITableViewCell {

    @IBOutlet weak var painSlider: UISlider!
    @IBOutlet weak var painLevel: UILabel!
    
    static let painLvlDescription = "Rating of your pain from scale of 0 - 10."
    
    var row:Int?
    
    @IBAction func sendPainLevelNotification(_ sender: Any) {
        let roundedVal:Int16 = Int16(roundf(self.painSlider.value))
        self.painLevel.text = String(roundedVal)
        self.painSlider.value = Float(roundedVal)
        let dataDict:Dictionary<String, Any> = ["data":roundedVal,
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
