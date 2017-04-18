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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
