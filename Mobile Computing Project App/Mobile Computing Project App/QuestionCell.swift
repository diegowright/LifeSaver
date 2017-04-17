//
//  QuestionCell.swift
//  Mobile Computing Project App
//
//  Created by Diego Wright on 4/15/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit

class QuestionCell: UITableViewCell {
    
    private var questionLabel:UILabel!
    private var questionSegControl:UISegmentedControl!
    
    static let questionDescription = "A yes or no question that you can define."

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Spacing constants
        let cellHeight: CGFloat = 100
        let gap: CGFloat = 5
        let labelHeight: CGFloat = 30
        let labelWidth: CGFloat = 150
        
        // Set size of cell
        let frameSize = CGSize(width: self.frame.size.width, height: cellHeight)
        self.frame = CGRect(origin: self.frame.origin, size: frameSize)
        
        // Setup label attributes
        questionLabel = UILabel()
        questionLabel.frame = CGRect(x:gap, y:gap, width:labelWidth, height:labelHeight)
        
        // Setup segmented control answers, Yes or No
        questionSegControl = UISegmentedControl()
        questionSegControl.frame = CGRect(x:gap, y:gap+labelHeight, width:labelWidth, height:labelHeight)
        questionSegControl.insertSegment(withTitle: "No", at: 0, animated: true)
        questionSegControl.insertSegment(withTitle: "Yes", at: 1, animated: true)
        
        // Add subviews to cell view
        self.contentView.addSubview(questionLabel)
        self.contentView.addSubview(questionSegControl)
    }
    
    // Set label text of a cell
    func setLabelText(labelText: String) {
        self.questionLabel.text! = labelText
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
