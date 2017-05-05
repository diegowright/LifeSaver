//
//  AddWaterViewController.swift
//  Mobile Computing Project App
//
//  Created by Robin Stewart on 5/4/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit
import UserNotifications

class AddWaterViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    @IBOutlet weak var amountOutlet: UITextField!
    @IBOutlet weak var typePickerOutlet: UIPickerView!
    @IBOutlet weak var dateOutlet: UIDatePicker!
    
    let pickerData = ["Water", "Tea", "Coffee", "Milk", "Soda", "Juice", "Beer", "Wine", "Misc. Alchoholic", "Energy Drink", "Other"]
    var pickerSelection = "Water"
    var alertController:UIAlertController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Log a Drink"
        
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
        
        if amountOutlet.text == "" {
            self.alertController = UIAlertController(title: "Error", message: "You must enter a value for amount.", preferredStyle: UIAlertControllerStyle.alert)
            let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action:UIAlertAction) in
                print("Ok Button Pressed 1");
            }
            self.alertController!.addAction(OKAction)
            self.present(self.alertController!, animated: true, completion:nil)
        }
        else {
            DataManager.shared.saveWater(date: dateOutlet.date, type: pickerSelection, amount: Int(amountOutlet.text!)!)
        }
        
        self.alertController = UIAlertController(title: "Saved!", message: "Your information is saved!", preferredStyle: UIAlertControllerStyle.alert)
        let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action:UIAlertAction) in
            print("Ok Button Pressed 1");
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

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
