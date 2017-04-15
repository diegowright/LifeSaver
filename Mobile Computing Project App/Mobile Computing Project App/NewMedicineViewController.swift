//
//  NewMedicineViewController.swift
//  Mobile Computing Project App
//
//  Created by Robin Stewart on 4/14/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit

class NewMedicineViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var medNameOutlet: UITextField!
    @IBOutlet weak var doseStrengthOutlet: UITextField!
    @IBOutlet weak var unitsOutlet: UIPickerView!
    
    let unitData = ["mg", "mcg", "mL", "pill(s)"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        unitsOutlet.dataSource = self
        unitsOutlet.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveAction(_ sender: Any) {
        let unitsValue:String = unitData[unitsOutlet.selectedRow(inComponent: 0)]
        DataManager.shared.saveMedicine(name: medNameOutlet.text!, dose: Float(doseStrengthOutlet.text!)!, unit: unitsValue)
    }
  
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent: Int) -> Int {
        return unitData.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return unitData[row]
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
