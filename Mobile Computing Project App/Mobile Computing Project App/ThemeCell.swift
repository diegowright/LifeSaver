//
//  ThemeCell.swift
//  Mobile Computing Project App
//
//  Created by Diego Wright on 5/2/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit

class ThemeCell: UITableViewCell {

    var tapAction: ((UITableViewCell) -> Void)?
    
    @IBOutlet weak var themeButton: UIButton!
    
    @IBAction func cellTap(_ sender: Any) {
        tapAction?(self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
