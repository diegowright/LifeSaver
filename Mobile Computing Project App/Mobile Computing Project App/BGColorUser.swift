//
//  BGColorUser.swift
//  Mobile Computing Project App
//
//  Created by Zhenyu Zhang on 4/16/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import Foundation
import UIKit

class BGColorUser: NSObject {
    // Define keys for the values to store

    fileprivate static let cColor = "bgc"
    
    class func setBGC(_ bgColor: UIColor){
        UserDefaults.standard.set(bgColor, forKey: cColor)
        UserDefaults.standard.synchronize()
    }
    
    class func bgColor() -> UIColor{
        if UserDefaults.standard.object(forKey: cColor) == nil {
            BGColorUser.setBGC(UIColor.white)
            return UserDefaults.standard.object(forKey: cColor) as! UIColor
        } else{
            return UserDefaults.standard.object(forKey: cColor) as! UIColor
        }
    }
}
