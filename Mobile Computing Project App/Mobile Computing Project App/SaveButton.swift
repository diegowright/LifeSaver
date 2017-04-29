//
//  SaveButton.swift
//  Mobile Computing Project App
//
//  Created by Diego Wright on 4/29/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit

class SaveButton: UIButton {

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        self.frame = CGRect(x: 160, y: 100, width: 50, height: 50)
        self.layer.cornerRadius = 0.5 * self.bounds.size.width
        self.clipsToBounds = true
    }
}
