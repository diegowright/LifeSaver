//
//  QuestionCell.swift
//  Mobile Computing Project App
//
//  Created by Diego Wright on 4/15/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit

class QuestionCell: UITableViewCell {
    
    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var answer: UISegmentedControl!
    
    static let questionDescription = "A yes or no question that you can define."
    
    var row:Int?
    
    @IBAction func sendQuestionNotification(_ sender: Any) {
        let idx:Int16 = Int16(answer.selectedSegmentIndex)
        let dataDict:Dictionary<String, Any> = ["data":[idx, questionText.text!],
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
