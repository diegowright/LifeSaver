//
//  QuestionCell.swift
//  Mobile Computing Project App
//
//  Created by Diego Wright on 4/15/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit

class QuestionCell: UITableViewCell {
    
    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var answer: UISegmentedControl!
    
    static let questionDescription = "A yes or no question that you can define."
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
