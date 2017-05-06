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
        let currentTheme:Theme = DataManager.shared.getCurrentTheme()
        
        // Background color
        let bgColor:UIColor = currentTheme.backgroundColor as! UIColor
        LSView.appearance().backgroundColor = bgColor
        UITableView.appearance().backgroundColor = bgColor
        // jbchart maybe
        
        // Label text color
        UILabel.appearance().tintColor = currentTheme.lblTxtColor as? UIColor
        
        // TableViewCell Color
        UITableViewCell.appearance().backgroundColor = currentTheme.buttonColor as? UIColor
        
        // Tabbar and Navbar Color
        let barColor:UIColor = currentTheme.navBarColor as! UIColor
        UITabBar.appearance().backgroundColor = barColor
        UINavigationBar.appearance().backgroundColor = barColor
    }
    
    class func setTheme(theme: Theme) {
        let bgColor:UIColor = theme.backgroundColor as! UIColor
        LSView.appearance().backgroundColor = bgColor
        UITableView.appearance().backgroundColor = bgColor
        // jbchart maybe
        
        // Label text color
        UILabel.appearance().tintColor = theme.lblTxtColor as? UIColor
        
        // TableViewCell Color
        UITableViewCell.appearance().backgroundColor = theme.buttonColor as? UIColor
        
        // Tabbar and Navbar Color
        let barColor:UIColor = theme.navBarColor as! UIColor
        UITabBar.appearance().backgroundColor = barColor
        UINavigationBar.appearance().backgroundColor = barColor
    }
}
