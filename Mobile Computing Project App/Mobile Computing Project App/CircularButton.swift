//
//  CircularButton.swift
//  Mobile Computing Project App
//
//  Created by Diego Wright on 4/29/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit

class CircularButton: UIButton {

    override func draw(_ rect: CGRect) {
        self.frame = CGRect(x: self.frame.origin.x,
                            y: self.frame.origin.y,
                            width: self.frame.height,
                            height: self.frame.height)
        self.layer.cornerRadius = 0.5 * self.bounds.size.width
        self.clipsToBounds = true
    }
}
