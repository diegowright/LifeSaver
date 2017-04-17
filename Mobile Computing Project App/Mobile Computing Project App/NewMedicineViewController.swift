//
//  NewMedicineViewController.swift
//  Mobile Computing Project App
//
//  Created by Robin Stewart on 4/14/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit
import UserNotifications

class NewMedicineViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var medNameOutlet: UITextField!
    @IBOutlet weak var doseStrengthOutlet: UITextField!
    @IBOutlet weak var unitsOutlet: UIPickerView!
    @IBOutlet weak var myTableView: UITableView!
    
    let unitData = ["mg", "mcg", "mL", "pill(s)"]
    var notify:Array = [[String(),Date()]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        unitsOutlet.dataSource = self
        unitsOutlet.delegate = self
        self.myTableView.dataSource = self
        self.myTableView.delegate = self
        
        let center = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert, .sound];
        center.requestAuthorization(options: options) {
            (granted, error) in
            if !granted {
                print("Something went wrong")
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(displayDaily(notification:)), name: NSNotification.Name(rawValue: "displayDaily"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //medArray = DataManager.shared.loadMedicine()
        self.myTableView.reloadData()
        self.myTableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveAction(_ sender: Any) {
        let unitsValue:String = unitData[unitsOutlet.selectedRow(inComponent: 0)]
        DataManager.shared.saveMedicine(name: medNameOutlet.text!, dose: Float(doseStrengthOutlet.text!)!, unit: unitsValue)
        
        // create a corresponding local notification
        let notification = UILocalNotification()
        notification.alertBody = "Todo Item Is Overdue" // text that will be displayed in the notification
        notification.alertAction = "open" // text that is displayed after "slide to..." on the lock screen - defaults to "slide to view"
        notification.fireDate = notify[0][1] as? Date // todo item due date (when notification will be fired) notification.soundName = UILocalNotificationDefaultSoundName // play default sound
        notification.userInfo = [:] // assign a unique identifier to the notification so that we can retrieve it later
        
        UIApplication.shared.scheduleLocalNotification(notification)
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
