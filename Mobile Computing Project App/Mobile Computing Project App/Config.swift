//
//  Config.swift
//  Mobile Computing Project App
//
//  Created by Zhenyu Zhang on 4/14/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import Foundation
import UIKit

class Config {
    
    // Set current system theme to the value specified by current user
    static var currentTheme = DataManager.shared.getCurrentUser().theme!
    
    //static var myCustomBackground = UIColor.white
    static var myCustomLabelColor = UIColor.black
    static var myCustomButtonFont = UIFont.systemFont(ofSize: 15.0)
    static var systemBackgroundColor = UIColor.white
    
}
