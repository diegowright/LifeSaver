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
    var alertController:UIAlertController? = nil
    @IBOutlet weak var segCtrl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Settings"
        //self.view.backgroundColor
        //self.view.backgroundColor = BGColorUser.bgColor()
    }
    
    @IBAction func segAction(_ sender: Any) {
        currentAction = self.segCtrl.selectedSegmentIndex
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        if currentAction == 0{
            //Appearance.updateBackgroundColor(color: UIColor.white)
            Appearance.updateLabelColor(color: UIColor.black)
            
            Appearance.updateButtonFont(font: UIFont(name: "Arial" , size: 20)!)
            
            self.alertController = UIAlertController(title: "Setting", message: "Font Color Changed to Black", preferredStyle: UIAlertControllerStyle.alert)
            
            let settingAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel) { (action:UIAlertAction) in
                print("Setting Button Pressed 1");
            }
            self.alertController!.addAction(settingAction)
            self.present(self.alertController!, animated: true, completion:nil)
            //BGColorUser.setBGC(UIColor.white)
            
        }else if currentAction == 1{
            //Appearance.updateBackgroundColor(color: UIColor.orange)
            Appearance.updateLabelColor(color: UIColor.orange)
            Appearance.updateButtonFont(font: UIFont(name: "HelveticaNeue-Bold" , size: 20)!)
            
            self.alertController = UIAlertController(title: "Setting", message: "Font Color Changed to Orange", preferredStyle: UIAlertControllerStyle.alert)
            
            let settingAction2 = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel) { (action:UIAlertAction) in
                print("Setting Button Pressed 2");
            }
            self.alertController!.addAction(settingAction2)
            self.present(self.alertController!, animated: true, completion:nil)
            //BGColorUser.setBGC(UIColor.orange)
            
        }else{
            //Appearance.updateBackgroundColor(color: UIColor.blue)
            Appearance.updateLabelColor(color: UIColor.blue)
            Appearance.updateButtonFont(font: UIFont(name: "AmericanTypewriter-Bold" , size: 20)!)
            
            self.alertController = UIAlertController(title: "Setting", message: "Font Color Changed to Blue", preferredStyle: UIAlertControllerStyle.alert)
            
            let settingAction3 = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel) { (action:UIAlertAction) in
                print("Setting Button Pressed 1");
            }
            self.alertController!.addAction(settingAction3)
            self.present(self.alertController!, animated: true, completion:nil)
            //BGColorUser.setBGC(UIColor.blue)
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
