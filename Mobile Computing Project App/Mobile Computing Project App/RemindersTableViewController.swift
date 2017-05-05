//
//  RemindersTableViewController.swift
//  Mobile Computing Project App
//
//  Created by Robin Stewart on 4/14/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit
import UserNotifications

class RemindersTableViewController: UITableViewController {
    
    var expandedRows = Set<Int>()
    var time:Dictionary<String,Date> = ["Daily":Date()]
    var alertController:UIAlertController? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Pick Reminder Frequency"
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        NotificationCenter.default.addObserver(self, selector: #selector(handlerDaily(notification:)),
                                               name: NSNotification.Name(rawValue: "dailyPickerTime"),
                                               object: nil)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExpandableCell", for: indexPath) as! DailyTableViewCell
        
        cell.isExpanded = self.expandedRows.contains(indexPath.row)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 111.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        guard let cell = tableView.cellForRow(at: indexPath) as? DailyTableViewCell
            else { return }
        
        switch cell.isExpanded {
        case true:
            self.expandedRows.remove(indexPath.row)
        case false:
            self.expandedRows.insert(indexPath.row)
        }
        
        cell.isExpanded = !cell.isExpanded
        
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }
    
    func handlerDaily (notification: Notification) {
        time = notification.userInfo as! Dictionary<String,Date>
    }
    
    
    @IBAction func saveAction(_ sender: Any) {
        
        //var rowID:Array = Array(expandedRows)
        //let cell = tableView.cellForRow(at: rowID[0]) as? DailyTableViewCell
        
        let theTime = time["Daily"]
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: theTime!)
        let minute = calendar.component(.minute, from: theTime!)
        print ("Notification Date: \(hour):\(minute)")
        let dataDict:Dictionary = ["Daily":theTime]
        NotificationCenter.default.post(name: Notification.Name(rawValue: "displayDaily"),
                                        object: nil,
                                        userInfo: dataDict)
        
        self.alertController = UIAlertController(title: "Saved!", message: "Your information is saved!", preferredStyle: UIAlertControllerStyle.alert)
        let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action:UIAlertAction) in
            print("Ok Button Pressed 1");
        }
        self.alertController!.addAction(OKAction)
        self.present(self.alertController!, animated: true, completion:nil)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation
/*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 */
    
}
