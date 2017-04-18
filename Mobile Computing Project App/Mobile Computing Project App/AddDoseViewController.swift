//
//  AddDoseViewController.swift
//  Mobile Computing Project App
//
//  Created by Robin Stewart on 4/17/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

class AddDoseViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var medPicker: UIPickerView!
    @IBOutlet weak var consumeTimePicker: UIDatePicker!
    @IBOutlet weak var stepperOutlet: UIStepper!
    @IBOutlet weak var quantityTaken: UILabel!
    
    var medArray = [NSManagedObject]()
    var alertController:UIAlertController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        medArray = DataManager.shared.loadMedicine()
        
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
        return medArray[row].value(forKey: "name") as? String
    }
    
    @IBAction func stepperAction(_ sender: Any) {
        let quantTemp:Double = Double(quantityTaken.text!)!
        quantityTaken.text = String(quantTemp + 0.5)
    }
    
    @IBAction func saveAction(_ sender: Any) {
        let medValue:String = (medArray[medPicker.selectedRow(inComponent: 0)].value(forKey: "name") as? String)!
        let quantityValue:Double = Double(quantityTaken.text!)!
        
        if medValue == "" || quantityValue > 0.0 {
            self.alertController = UIAlertController(title: "Error", message: "You must enter a value for all fields.", preferredStyle: UIAlertControllerStyle.alert)
            let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action:UIAlertAction) in
                print("Ok Button Pressed 1");
            }
            self.alertController!.addAction(OKAction)
            self.present(self.alertController!, animated: true, completion:nil)
        }
        else {
            DataManager.shared.saveDose(med: medValue, quantity: quantityValue, time: Date())
        }
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
