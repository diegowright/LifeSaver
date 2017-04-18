//
//  DateTimeCell.swift
//  Mobile Computing Project App
//
//  Created by Diego Wright on 4/15/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit

class DateTimeCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    static let dateDescription = "Select the time and date that your pain occurred on."
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
