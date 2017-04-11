//
//  MedicalEventCell.swift
//  Mobile Computing Project App
//
//  Created by Diego Wright on 3/20/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit

class MedicalEventCell: UITableViewCell {

    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var editEventButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Move edit button off screen for now
        var editOrigin = editEventButton.frame.origin
        editOrigin = CGPoint(x: editOrigin.x-100, y: editOrigin.y)
        editEventButton.frame.origin = editOrigin
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
