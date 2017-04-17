//
//  SettingsVC.swift
//  Mobile Computing Project App
//
//  Created by Zhenyu Zhang on 3/24/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {
    var currentAction = 0
    @IBOutlet weak var segCtrl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Settings"
        //self.view.backgroundColor
        self.view.backgroundColor = BGColorUser.bgColor()
    }
    
    @IBAction func segAction(_ sender: Any) {
        currentAction = self.segCtrl.selectedSegmentIndex
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        if currentAction == 0{
            //Appearance.updateBackgroundColor(color: UIColor.white)
            Appearance.updateLabelColor(color: UIColor.purple)
            BGColorUser.setBGC(UIColor.white)
            
        }else if currentAction == 1{
            //Appearance.updateBackgroundColor(color: UIColor.orange)
            Appearance.updateLabelColor(color: UIColor.orange)
            Appearance.updateButtonFont(font: UIFont(name: "HelveticaNeue-Bold" , size: 24.0)!)
            BGColorUser.setBGC(UIColor.orange)
            
        }else{
            //Appearance.updateBackgroundColor(color: UIColor.blue)
            Appearance.updateLabelColor(color: UIColor.red)
            Appearance.updateButtonFont(font: UIFont(name: "HelveticaNeue-Bold" , size: 15.0)!)
            BGColorUser.setBGC(UIColor.blue)
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
