//
//  CellView.swift
//  Mobile Computing Project App
//
//  Created by Robin Stewart on 3/24/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CellView: JTAppleDayCellView {
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var selectedView: UIView!
    var date:Date?
    
}
