//
//  ThemeViewController.swift
//  Mobile Computing Project App
//
//  Created by Diego Wright on 4/29/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit

class ThemeViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    var alertController:UIAlertController? = nil
    
    @IBOutlet weak var bgColorButton: UIButton!
    @IBOutlet weak var navBarColorButton: UIButton!
    @IBOutlet weak var labelTextColorButton: UIButton!
    @IBOutlet weak var buttonColorButton: UIButton!
    @IBOutlet weak var buttonTextColorButton: UIButton!
    @IBOutlet weak var tabBarColorButton: UIButton!
    @IBOutlet weak var themeName: UITextField!
    
    @IBAction func chooseColor(_ sender: UIButton) {
        let popoverVC = storyboard?.instantiateViewController(withIdentifier: "colorPickerPopover") as! ColorPickerViewController
        popoverVC.modalPresentationStyle = .popover
        popoverVC.preferredContentSize = CGSize(width: 284, height: 446)
        if let popoverController = popoverVC.popoverPresentationController {
            popoverController.sourceView = sender
            popoverController.sourceRect = CGRect(x: 0, y: 0, width: 300, height: 75)
            popoverController.permittedArrowDirections = .right
            popoverController.delegate = self
            popoverVC.delegate = sender
        }
        present(popoverVC, animated: true, completion: nil)
    }
    
    @IBAction func saveTheme(_ sender: CircularButton) {
        // Save the theme using data manager class
        let bgColor:UIColor = self.bgColorButton.backgroundColor!
        let navBarColor:UIColor = self.navBarColorButton.backgroundColor!
        let lblTxtColor:UIColor = self.labelTextColorButton.backgroundColor!
        let buttonColor:UIColor = self.buttonColorButton.backgroundColor!
        let buttonTxtColor:UIColor = self.buttonTextColorButton.backgroundColor!
        let tabBarColor:UIColor = self.tabBarColorButton.backgroundColor!
        let themeName:String = self.themeName.text!
        
        if themeName != "" {
            print("There is a valid name \(themeName).")
            // Save theme
            DataManager.shared.saveTheme(backgroundColor: bgColor,
                                         buttonColor: buttonColor,
                                         buttonTxtColor: buttonTxtColor,
                                         lblTxtColor: lblTxtColor,
                                         navBarColor: navBarColor,
                                         tabBarColor: tabBarColor,
                                         themeName: themeName)
            
            // Update currently selected theme
            //Appearance.updateTheme()
            
            // return to previous viewcontroller
            _ = self.navigationController?.popViewController(animated: true)
        } else {
            //alert controller that a theme name is not entered
            self.displayMessage("Theme must be assigned a name before it can be saved.")
            return
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Create a Theme"
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Override the iPhone behavior that presents a popover as fullscreen
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    func displayMessage(_ message: String) {
        DispatchQueue.main.async {
            self.alertController =
                UIAlertController(title: self.title!, message: message, preferredStyle: UIAlertControllerStyle.alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action:UIAlertAction) in
            }
            
            self.alertController!.addAction(okAction)
            
            self.present(self.alertController!, animated: true, completion:nil)
        }
    }
    
    // dismisses keyboard on touch outside of keyboard
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}
