//
//  EventInputTable.swift
//  Mobile Computing Project App
//
//  Created by Diego Wright on 4/17/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit

class EventInputTable: UITableViewController {
    
    var template:Template?
    var attributeInfo:[Dictionary<String, Any>]?
    
    let white:UIColor = UIColor.white

    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.viewDidLoad()
        print("Template: ", self.template ?? "No template :(")
        self.title = self.template!.name!
        self.attributeInfo = DataManager.shared.getTemplateAttributeData(template: self.template!)
        
        // Add save button to top right of nav controller
        let save = UIBarButtonItem(title: "Save", style: UIBarButtonItemStyle.done,
                                   target: self, action: #selector(EventInputTable.saveEvent))
        self.navigationItem.rightBarButtonItem = save
        
        // Add observer that looks for data posting
        NotificationCenter.default.addObserver(self, selector: #selector(self.addData(_:)),
                                               name: NSNotification.Name(rawValue: addDataKey),
                                               object: nil)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.attributeInfo!.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure the cell...
        let identifier = self.attributeInfo![indexPath.row]["id"]! as! String
        switch identifier {
            
        case "Date & Time":
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! DateTimeCell
            cell.backgroundColor = white
            cell.row = indexPath.row
            cell.sendDateNotification(cell)
            return cell
            
        case "Note":
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! NoteCell
            cell.backgroundColor = white
            cell.row = indexPath.row
            cell.sendNoteNotification(cell)
            return cell
            
        case "Pain Location":
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! PainLocationCell
            cell.backgroundColor = white
            cell.row = indexPath.row
            
            let locs:[String] = [self.attributeInfo![indexPath.row]["loc0"]! as! String,
                                 self.attributeInfo![indexPath.row]["loc1"]! as! String,
                                 self.attributeInfo![indexPath.row]["loc2"]! as! String,
                                 self.attributeInfo![indexPath.row]["loc3"]! as! String,
                                 self.attributeInfo![indexPath.row]["loc4"]! as! String]
            
            // Add segments to location segment control
            var locationCount:Int = 0
            cell.locationControl.removeAllSegments()
            for loc in locs {
                if loc != "" {
                    cell.locationControl.insertSegment(withTitle: loc, at: locationCount, animated: false)
                    locationCount += 1
                }
            }
            cell.locationControl.selectedSegmentIndex = 0
            cell.sendLocationNotification(cell)
            
            return cell
            
        case "Pain Type":
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! PainTypeCell
            cell.backgroundColor = white
            cell.row = indexPath.row
            cell.sendPainTypeNotification(cell)
            return cell
            
        case "Pain Duration":
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! PainDurationCell
            cell.backgroundColor = white
            cell.row = indexPath.row
            cell.durationInput.text = "1"
            cell.sendUnitNotification(cell)
            return cell
            
        case "Pain Level":
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! PainLevelCell
            cell.backgroundColor = white
            cell.row = indexPath.row
            cell.sendPainLevelNotification(cell)
            return cell
            
        case "Question":
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! QuestionCell
            cell.backgroundColor = white
            cell.row = indexPath.row
            
            cell.questionText.text = self.attributeInfo![indexPath.row]["question"]! as? String
            cell.sendQuestionNotification(cell)
            return cell
            
        default:
            print("Default case, something went wrong.")
            let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
            return cell
        }
    }

    func addData(_ notification: Notification) {
        let data = notification.userInfo as! Dictionary<String, Any>
        let row = data["row"]! as! Int
        self.attributeInfo![row]["data"] = data["data"]!
    }
    
    func saveEvent() {
        DataManager.shared.saveEvent(template: self.template!, data: self.attributeInfo!)
        print("Event type Saved!")
        
        // Return to previous view which is Medical Event Table
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}
