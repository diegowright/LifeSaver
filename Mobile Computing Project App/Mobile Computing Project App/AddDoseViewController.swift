//
//  AddDoseViewController.swift
//  Mobile Computing Project App
//
//  Created by Robin Stewart on 4/17/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit
import UserNotifications

class AddDoseViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var medPicker: UIPickerView!
    @IBOutlet weak var consumeTimePicker: UIDatePicker!
    @IBOutlet weak var stepperOutlet: UIStepper!
    @IBOutlet weak var quantityTaken: UILabel!
    
    var medArray = DataManager.shared.loadMedicine()
    var alertController:UIAlertController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        medPicker.dataSource = self
        medPicker.delegate = self
        
        stepperOutlet.autorepeat = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent: Int) -> Int {
        return medArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return medArray[row].name!
    }
    
    @IBAction func stepperAction(_ sender: Any) {
        quantityTaken.text = "\(Double(stepperOutlet.value))"
    }
    
    @IBAction func saveAction(_ sender: Any) {
        let medValue:String = medArray[medPicker.selectedRow(inComponent: 0)].name!
        
        if medValue == "" {
            self.alertController = UIAlertController(title: "Error", message: "You must enter a value for all fields.", preferredStyle: UIAlertControllerStyle.alert)
            let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action:UIAlertAction) in
                return
            }
            self.alertController!.addAction(OKAction)
            self.present(self.alertController!, animated: true, completion:nil)
        }
        else {
            DataManager.shared.saveDose(med: medValue, quantity: Double(stepperOutlet.value), time: consumeTimePicker.date)
        }
        
        self.alertController = UIAlertController(title: "Saved!", message: "Your information is saved!", preferredStyle: UIAlertControllerStyle.alert)
        let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action:UIAlertAction) in
            print("Saved a dose.")
            _ = self.navigationController?.popViewController(animated: true)
        }
        self.alertController!.addAction(OKAction)
        self.present(self.alertController!, animated: true, completion:nil)
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
