//
//  DatePickerCell.swift
//  Mobile Computing Project App
//
//  Created by Diego Wright on 4/15/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit

class DatePickerCell: UITableViewCell {

    private var dateLabel:UILabel!
    private var datePicker:UIDatePicker!
    
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
        dateLabel = UILabel()
        dateLabel.text = "Select date & time:"
        dateLabel.frame = CGRect(x:gap, y:gap, width:labelWidth, height:labelHeight)
        
        // Setup datepicker attributes
        datePicker = UIDatePicker()
        datePicker.date = Date()
        
        // Add subviews to cell view
        self.contentView.addSubview(dateLabel)
        self.contentView.addSubview(datePicker)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
}
