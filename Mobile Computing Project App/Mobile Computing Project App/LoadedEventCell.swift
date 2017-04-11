//
//  loadedEventCell.swift
//  Mobile Computing Project App
//
//  Created by Diego Wright on 3/24/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit

class LoadedEventCell: UITableViewCell {

    @IBOutlet weak var event: UILabel!
    @IBOutlet weak var date: UILabel!
    
    var exactDate: Date?    // this will be used to exactly identify a note from another
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
