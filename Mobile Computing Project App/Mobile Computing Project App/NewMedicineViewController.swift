//
//  NewMedicineViewController.swift
//  Mobile Computing Project App
//
//  Created by Robin Stewart on 4/14/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit
import UserNotifications

class NewMedicineViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDataSource, UITableViewDelegate, UNUserNotificationCenterDelegate {
    
    @IBOutlet weak var medNameOutlet: UITextField!
    @IBOutlet weak var doseStrengthOutlet: UITextField!
    @IBOutlet weak var unitsOutlet: UIPickerView!
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var instructionsOutlet: UITextView!
    
    let unitData = ["mg", "mcg", "mL", "pill(s)"]
    var notify:Array = [["Frequency",Date()]]
    let center = UNUserNotificationCenter.current()
    var alertController:UIAlertController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        unitsOutlet.dataSource = self
        unitsOutlet.delegate = self
        self.myTableView.dataSource = self
        self.myTableView.delegate = self
        
        self.title = "New Medicine"
        
        let options: UNAuthorizationOptions = [.alert, .sound];
        center.requestAuthorization(options: options) {
            (granted, error) in
            if !granted {
                print("Something went wrong")
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(displayDaily(notification:)),
                                               name: NSNotification.Name(rawValue: "displayDaily"),
                                               object: nil)
        
        UNUserNotificationCenter.current().requestAuthorization(options: [[.alert, .sound, .badge]],
                                                                completionHandler: { (granted, error) in /* Handle Error */ })
        UNUserNotificationCenter.current().delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.myTableView.reloadData()
        self.myTableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveAction(_ sender: Any) {
        let unitsValue:String = unitData[unitsOutlet.selectedRow(inComponent: 0)]
        
        if medNameOutlet.text! == "" || doseStrengthOutlet.text! == "" || unitsValue == "" || Int(doseStrengthOutlet.text!) == nil || instructionsOutlet.text! == "" {
            self.alertController = UIAlertController(title: "Error", message: "You must enter a value for all fields. Make sure the dose is an integer.", preferredStyle: UIAlertControllerStyle.alert)
            let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action:UIAlertAction) in
                return
            }
            self.alertController!.addAction(OKAction)
            self.present(self.alertController!, animated: true, completion:nil)
        }
        else {
            DataManager.shared.saveMedicine(name: medNameOutlet.text!,
                                            dose: Float(doseStrengthOutlet.text!)!,
                                            unit: unitsValue,
                                            instruct: instructionsOutlet.text!)
        }
        
        for object in notify {
            if String(describing: object[0]) == "Frequency" {
            } else {
                let selectedDate = object[1]
                print("Selected date: \(selectedDate)")
                let delegate = UIApplication.shared.delegate as? AppDelegate
                delegate?.scheduleNotification(at: selectedDate as! Date,
                                               name: medNameOutlet.text!,
                                               dose: doseStrengthOutlet.text!,
                                               unit: unitsValue)
                DataManager.shared.saveReminder(name: medNameOutlet.text!,
                                                freq: "Daily",
                                                time: selectedDate as! Date)
            }
        }
        
        self.alertController = UIAlertController(title: "Saved!", message: "Your information is saved!", preferredStyle: UIAlertControllerStyle.alert)
        let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action:UIAlertAction) in
            print("Saved medicine.")
            _ = self.navigationController?.popViewController(animated: true)
        }
        self.alertController!.addAction(OKAction)
        self.present(self.alertController!, animated: true, completion:nil)
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
    
    func displayDaily (notification: Notification) {
        let tempDict:Dictionary<String,Date> = notification.userInfo as! Dictionary<String,Date>
        let tempDate:Date = tempDict["Daily"]!
        notify.append(["Daily",tempDate])
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notify.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newNotifyCell", for: indexPath)
        if indexPath.row == 0 {
             cell.textLabel?.text = "Frequency"
             cell.detailTextLabel?.text = "Time"
             return cell
        }
        else {
            let theTime = notify[indexPath.row][1] as! Date
            print ("\(theTime)")
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: theTime)
            let minute = calendar.component(.minute, from: theTime)
        
            cell.textLabel?.text = String(describing: notify[indexPath.row][0])
            cell.detailTextLabel?.text = "\(hour):\(minute)"
            return cell
        }
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

}
