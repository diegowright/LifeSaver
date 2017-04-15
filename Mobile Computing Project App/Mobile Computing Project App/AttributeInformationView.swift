//
//  AttributeInformationView.swift
//  Mobile Computing Project App
//
//  Created by Diego Wright on 3/20/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit

class AttributeInformationView: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    var alertController:UIAlertController? = nil
    
    fileprivate let attributeTypes:[String] = ["Text Field", "Slider", "Segmented Control", "Switch", "Stepper", "Date Picker", "Text View"]
    
    @IBOutlet weak var attributeName: UITextField!
    @IBOutlet weak var attributePicker: UIPickerView!

    // Save attribute to event by sending a notification that the event will listen for
    @IBAction func saveAttribute(_ sender: Any) {
        if self.attributeName.text == "" {
            self.alertController = UIAlertController(title: "Hey!", message: "You must have a name for your attribute",
                                                     preferredStyle: UIAlertControllerStyle.alert)
            let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                (action:UIAlertAction) in print("Ok pressed");
            }
            self.alertController!.addAction(OKAction)
            self.present(self.alertController!, animated: true, completion:nil)
            return
        } else {
            print("Saving attribute, about to send notification")
            let name = self.attributeName.text!
            let type = self.attributeTypes[self.attributePicker.selectedRow(inComponent: 0)]

            // package the data into a dictionary
            let dataDict = ["name":name, "type":type];
            
            // Post notification to add attribute
            NotificationCenter.default.post(name: Notification.Name(rawValue: addAttKey), object: nil, userInfo: dataDict)
            
            print("Add attribute notification sent. Exit.")

            _ = self.navigationController?.popViewController(animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Create an Attribute"
        
        // Setup picker attribute values
        self.attributePicker.dataSource = self
        self.attributePicker.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // This function adds some UI element that can take in data to view
    private func addElementToView(element: AnyObject) {
        
    }
 
    // Functions to satisfy UIPickerView delegate protocol ////////////////////////////////////////////////////
    func numberOfComponents(in: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.attributeTypes.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.attributeTypes[row]
    }
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    // function that is called when a row is selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if row == 0 {
            print(0)
        } else if row == 1 {
            print(1)
        } else if row == 2 {
            print(2)
        } else if row == 3 {
            print(3)
        } else {
            print(4)
        }
    }

    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}
