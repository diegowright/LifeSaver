//
//  CalendarWaterLogCell.swift
//  Mobile Computing Project App
//
//  Created by Diego Wright on 5/6/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit

class CalendarWaterLogCell: UITableViewCell {

    @IBOutlet weak var beverage: UILabel!
    @IBOutlet weak var quantity: UILabel!
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
