//
//  DisplayMedViewController.swift
//  Mobile Computing Project App
//
//  Created by Robin Stewart on 4/17/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit

class DisplayMedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var med:Medicine?
    var remindArray:[Reminder] = DataManager.shared.loadReminder()
    var remindSelect:[Reminder] = []
    
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
        
        name.text = med!.name!
        let tempDose:Float = med!.dose
        doseUnit.text = String(tempDose) + " " + med!.unit!
        instructOutlet.text = med!.instruct!
        
        self.myTableView.dataSource = self
        self.myTableView.delegate = self
        
        for object in remindArray {
            if object.name! == med!.name! {
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
        
        let theTime = remindSelect[indexPath.row].time! as Date
        print ("\(theTime)")
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: theTime)
        let minute = calendar.component(.minute, from: theTime)
        
        cell.textLabel?.text = remindSelect[indexPath.row].freq!
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

