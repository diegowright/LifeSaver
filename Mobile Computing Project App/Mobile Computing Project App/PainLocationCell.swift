//
//  PainLocationCell.swift
//  Mobile Computing Project App
//
//  Created by Diego Wright on 4/16/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit

class PainLocationCell: UITableViewCell {
    
    @IBOutlet weak var locationControl: UISegmentedControl!
    
    static let painLocDescription = "Can choose up to 5 user-defined areas where pain originates."

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
