//
//  Attributes.swift
//  Mobile Computing Project App
//
//  Created by Diego Wright on 3/21/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import Foundation

protocol Attribute {
    // this protocol is simple and sets up the basic needs for a medical event attribute
    var name:String {get set}  // Name of the attribute
    var inputType:AnyObject {get set} // Some UI that takes in data e.g. a text input
}
