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

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
