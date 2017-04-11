//
//  Style.swift
//  Mobile Computing Project App
//
//  Created by Zhenyu Zhang on 3/24/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import Foundation
import UIKit

struct Style{
    //this is an attempt to do a style struct, currently not working :(
    
    static func whiteTheme(){
        var BackgroundColor = UIColor.white
    }
    
    static func orangeTheme(){
        var BackgroundColor = UIColor.orange
    }
    
    static func blueTheme(){
        var BackgroundColor = UIColor.blue
    }
    
    static let availableThemes = ["white","orange","blue"]
    static func loadTheme(){
        let defaults = UserDefaults.standard
        if let name = defaults.string(forKey: "Theme"){
            // Select the Theme
            if name == "white"		{ whiteTheme()	}
            if name == "orange" 	{ orangeTheme()	}
            if name == "blue" 		{ blueTheme()	}
            
        }else{
            defaults.set("white", forKey: "Theme")
            whiteTheme()
        }
    }
}
