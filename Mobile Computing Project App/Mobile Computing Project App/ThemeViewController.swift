//
//  ThemeViewController.swift
//  Mobile Computing Project App
//
//  Created by Diego Wright on 4/29/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit

class ThemeViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var colorPickerButton: UIButton!
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Override the iPhone behavior that presents a popover as fullscreen
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        // Return no adaptive presentation style, use default presentation behaviour
        //return .overFullScreen
        return .none
    }
}
