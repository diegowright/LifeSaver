//
//  Apperance.swift
//  Mobile Computing Project App
//
//  Created by Zhenyu Zhang on 4/14/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import Foundation
import UIKit

class Appearance: NSObject {
    
    class func setInitialAppTheme() {
        Appearance.setMyCustomLabelColor()
        Appearance.setMyCustomButtonFont()
        //Appearance.setMyBackGroundColor()
    }
    
    class func setMyCustomLabelColor() {
        //MyCustomLabel.appearance().textColor = Config.myCustomLabelColor
        UILabel.appearance().textColor = Config.myCustomLabelColor
    }
    
    class func setMyCustomButtonFont() {
        MyCustomButton.appearance().titleLabelFont = Config.myCustomButtonFont
    }
    
    /*
    class func setMyBackGroundColor() {
        if UserDefaults.standard.object(forKey: cColor) == nil {
            BGColorUser.setBGC(UIColor.white)
        BGColorUser.setBGC(UIColor.white)
        
    }
    
    class func updateBackgroundColor(color: UIColor){
        Config.myCustomBackground = color
        Appearance.setMyBackgroundColor()
    }
    */
    
    class func updateLabelColor(color: UIColor) {
        Config.myCustomLabelColor = color
        Appearance.setMyCustomLabelColor()
    }
    
    class func updateButtonFont(font: UIFont) {
        Config.myCustomButtonFont = font
        Appearance.setMyCustomButtonFont()
    }
    
}
