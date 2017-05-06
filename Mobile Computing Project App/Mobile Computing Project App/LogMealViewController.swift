//
//  LogMealViewController.swift
//  Mobile Computing Project App
//
//  Created by Robin Stewart on 5/4/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit
import UserNotifications

class LogMealViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    @IBOutlet weak var dateOutlet: UIDatePicker!
    @IBOutlet weak var typePickerOutlet: UIPickerView!
    @IBOutlet weak var foodOutlet: UITextField!
    @IBOutlet weak var beverageOutlet: UITextField!
    @IBOutlet weak var commentOutlet: UITextView!
    
    let pickerData = ["Breakfast", "Lunch", "Dinner", "Snack"]
    var pickerSelection = "Breakfast"
    var alertController:UIAlertController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Log a Meal"
        
        let navigationBar = navigationController!.navigationBar
        navigationBar.tintColor = UIColor.blue
        let rightButton = UIBarButtonItem(title: "Save", style: UIBarButtonItemStyle.plain, target: self, action: #selector(buttonAction))
        navigationItem.rightBarButtonItem = rightButton
        
        typePickerOutlet.delegate = self
        typePickerOutlet.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buttonAction(sender: UIButton!) {
        print("Button tapped")
        
        if foodOutlet.text == "" {
            self.alertController = UIAlertController(title: "Error", message: "You must enter a value for food.", preferredStyle: UIAlertControllerStyle.alert)
            let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action:UIAlertAction) in
                return
            }
            self.alertController!.addAction(OKAction)
            self.present(self.alertController!, animated: true, completion:nil)
        }
        else {
            DataManager.shared.saveMeal(date: dateOutlet.date, type: pickerSelection, food: foodOutlet.text!, beverage: beverageOutlet.text!, comment: commentOutlet.text)
        }
        
        self.alertController = UIAlertController(title: "Saved!", message: "Your information is saved!", preferredStyle: UIAlertControllerStyle.alert)
        let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action:UIAlertAction) in
            print("Food log saved.")
            _ = self.navigationController?.popViewController(animated: true)
        }
        self.alertController!.addAction(OKAction)
        self.present(self.alertController!, animated: true, completion:nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerSelection = pickerData[row]
    }
}
