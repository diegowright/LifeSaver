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
    }
    
    @IBAction func segAction(_ sender: Any) {
        currentAction = self.segCtrl.selectedSegmentIndex
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        if currentAction == 0{
            Appearance.updateBackgroundColor(color: UIColor.white)
            //Style.whiteTheme()
            //Style.setColor("white")
            
        }else if currentAction == 1{
            Appearance.updateBackgroundColor(color: UIColor.orange)
            //Style.orangeTheme()
            //Style.setColor("orange")
 
        }else{
            Appearance.updateBackgroundColor(color: UIColor.blue)
            //Style.blueTheme()
            //Style.setColor("blue")

        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
