//
//  MyCustomButton.swift
//  Mobile Computing Project App
//
//  Created by Zhenyu Zhang on 4/16/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit

class MyCustomButton: UIButton {
    
    // It turns out that only some properties are accessible via a UIAppearance proxy,
    // and UIButton's titleLabel is not one of them. This problem can be solved in our
    // custom subclasses by adding the following.
    //
    // The "dynamic" keyword makes this accessible via Objective-C code, which is
    // needed for UIAppearance to set it.
    dynamic var titleLabelFont: UIFont! {
        get { return self.titleLabel?.font }
        set { self.titleLabel?.font = newValue }
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
}
