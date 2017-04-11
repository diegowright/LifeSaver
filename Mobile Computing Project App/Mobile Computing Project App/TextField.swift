//
//  TextField.swift
//  Mobile Computing Project App
//
//  Created by Diego Wright on 3/22/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import Foundation

class TextField: Attribute {
    var name:String
    var inputType:AnyObject
    
    init(name:String, inputType:AnyObject) {
        self.name = name
        self.inputType = inputType
    }
}
