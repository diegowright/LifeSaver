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
    
    class func updateTheme() {
        //do something
        let currentTheme:Theme = DataManager.shared.getCurrentTheme()
        UIView.appearance().backgroundColor = currentTheme.backgroundColor as? UIColor
        UIButton.appearance().backgroundColor = currentTheme.buttonColor as? UIColor
        UIButton.appearance().tintColor = currentTheme.buttonTxtColor as? UIColor
        UILabel.appearance().tintColor = currentTheme.lblTxtColor as? UIColor
        UINavigationBar.appearance().backgroundColor = currentTheme.navBarColor as? UIColor
        UITabBar.appearance().backgroundColor = currentTheme.tabBarColor as? UIColor
    }
    
    class func setTheme(theme: Theme) {
        UIView.appearance().backgroundColor = theme.backgroundColor as? UIColor
        UIButton.appearance().backgroundColor = theme.buttonColor as? UIColor
        UIButton.appearance().tintColor = theme.buttonTxtColor as? UIColor
        UILabel.appearance().tintColor = theme.lblTxtColor as? UIColor
        UINavigationBar.appearance().backgroundColor = theme.navBarColor as? UIColor
        UITabBar.appearance().backgroundColor = theme.tabBarColor as? UIColor
    }
}
