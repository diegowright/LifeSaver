//
//  QuestionCell.swift
//  Mobile Computing Project App
//
//  Created by Diego Wright on 4/15/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit

class QuestionCell: UITableViewCell {
    
    var questionLabel:UILabel!
    var questionSegControl:UISegmentedControl!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Set size of cell
        let frameSize = CGSize(width: self.frame.size.width, height: CGFloat(50))
        self.frame = CGRect(origin: self.frame.origin, size: frameSize)
        
        // Spacing constants
        let gap: CGFloat = 5
        let labelHeight: CGFloat = 30
        let labelWidth: CGFloat = 150
        let black: UIColor = UIColor.black  // Saves some processing time
        
        // Setup label attributes
        questionLabel = UILabel()
        questionLabel.frame = CGRect(x:gap, y:gap, width:labelWidth, height:labelHeight)
        questionLabel.textColor = black
        
        // Setup segmented control answers, Yes or No
        questionSegControl = UISegmentedControl()
        questionSegControl.frame = CGRect(x:gap, y:gap+labelHeight, width:labelWidth, height:labelHeight)
        questionSegControl.insertSegment(withTitle: "No", at: 0, animated: true)
        questionSegControl.insertSegment(withTitle: "Yes", at: 1, animated: true)
        
        // Add subviews to cell view
        self.contentView.addSubview(questionLabel)
        self.contentView.addSubview(questionSegControl)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    /*
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    */
}
