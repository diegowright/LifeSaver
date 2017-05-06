//
//  CalendarMedDoseCell.swift
//  Mobile Computing Project App
//
//  Created by Diego Wright on 5/6/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit

class CalendarMedDoseCell: UITableViewCell {

    @IBOutlet weak var medName: UILabel!
    @IBOutlet weak var dose: UILabel!
    @IBOutlet weak var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
