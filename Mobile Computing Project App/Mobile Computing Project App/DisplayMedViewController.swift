//
//  DisplayMedViewController.swift
//  Mobile Computing Project App
//
//  Created by Robin Stewart on 4/17/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit
import CoreData

class DisplayMedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var med = NSManagedObject()
    var remindArray = [NSManagedObject]()
    var remindSelect = [NSManagedObject]()
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var doseUnit: UILabel!
    @IBOutlet weak var instructOutlet: UITextView!
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Medicine Details"
        let barButton = UIBarButtonItem()
        barButton.title = "Back"
        navigationController!.navigationBar.topItem!.backBarButtonItem = barButton
        
        name.text = med.value(forKey: "name") as? String
        let tempDose:Float = (med.value(forKey: "dose") as? Float)!
        doseUnit.text = String(tempDose) + " " + (med.value(forKey: "unit") as? String)!
        instructOutlet.text = med.value(forKey: "instruct") as? String
        
        self.myTableView.dataSource = self
        self.myTableView.delegate = self
        
        remindArray = DataManager.shared.loadReminder()
        
        for object in remindArray {
            if object.value(forKey: "name") as? String == med.value(forKey: "name") as? String {
                remindSelect.append(object)
            }
        }
        
        // Add keyboard dismiss
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return remindSelect.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "displayMedCell", for: indexPath)
        
        
        let theTime = remindSelect[indexPath.row].value(forKey: "time") as! Date
        print ("\(theTime)")
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: theTime)
        let minute = calendar.component(.minute, from: theTime)
        
        cell.textLabel?.text = remindSelect[indexPath.row].value(forKey: "freq") as? String
        cell.detailTextLabel?.text = "\(hour):\(minute)"
        return cell
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
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

