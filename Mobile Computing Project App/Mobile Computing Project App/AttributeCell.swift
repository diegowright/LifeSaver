//
//  AttributeCell.swift
//  Mobile Computing Project App
//
//  Created by Diego Wright on 4/16/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit

class AttributeCell: UITableViewCell {

    var tapAction: ((UITableViewCell) -> Void)?
    
    @IBOutlet weak var cellLabel: UIButton!
    @IBOutlet weak var attributeDescription: UILabel!
    
    @IBAction func cellTap(_ sender: Any) {
        tapAction?(self)  // this excecutes whatever closure is associated with tapAction
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
