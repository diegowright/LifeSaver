//
//  PlotCell.swift
//  Mobile Computing Project App
//
//  Created by Diego Wright on 5/3/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit

class PlotCell: UITableViewCell {

    var tapAction: ((UITableViewCell) -> Void)?
    
    @IBOutlet weak var plotNameButton: UIButton!
    
    @IBAction func plotCellTapped(_ sender: Any) {
        tapAction?(self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
