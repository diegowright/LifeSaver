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
    
    static let painLvlDescription = "Rating of your pain from scale of 0 - 10."
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
