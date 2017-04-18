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
    var data:Dictionary<String, [Any]>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.viewDidLoad()
        print("Template: ", self.template ?? "No template :(")
        self.title = self.template!.name!
        self.attributeInfo = DataManager.shared.getTemplateAttributeNames(template: self.template!)
        
        // Add save button to top right of nav controller
        let save = UIBarButtonItem(title: "Save", style: UIBarButtonItemStyle.done,
                                   target: self, action: #selector(EventInputTable.saveEvent))
        self.navigationItem.rightBarButtonItem = save
        
        // Add observer that looks for data posting
        NotificationCenter.default.addObserver(self, selector: #selector(self.addData(_:)),
                                               name: NSNotification.Name(rawValue: addQuestionData),
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
            print()
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! DateTimeCell
            cell.frame = CGRect(origin: cell.frame.origin, size: CGSize(width: cell.frame.size.width, height: CGFloat(100)))
            return cell
            
        case "Note":
            print()
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! NoteCell
            cell.frame = CGRect(origin: cell.frame.origin, size: CGSize(width: cell.frame.size.width, height: CGFloat(100)))
            return cell
            
        case "Pain Location":
            print()
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! PainLocationCell
            cell.frame = CGRect(origin: cell.frame.origin, size: CGSize(width: cell.frame.size.width, height: CGFloat(100)))
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
            
            return cell
            
        case "Pain Type":
            print()
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! PainTypeCell
            cell.frame = CGRect(origin: cell.frame.origin, size: CGSize(width: cell.frame.size.width, height: CGFloat(100)))
            return cell
            
        case "Pain Duration":
            print()
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! PainDurationCell
            cell.frame = CGRect(origin: cell.frame.origin, size: CGSize(width: cell.frame.size.width, height: CGFloat(100)))
            return cell
            
        case "Pain Level":
            print()
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! PainLevelCell
            cell.frame = CGRect(origin: cell.frame.origin, size: CGSize(width: cell.frame.size.width, height: CGFloat(100)))
            return cell
            
        case "Question":
            print()
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! QuestionCell
            cell.frame = CGRect(origin: cell.frame.origin, size: CGSize(width: cell.frame.size.width, height: CGFloat(100)))
            cell.questionText.text = self.attributeInfo![indexPath.row]["question"]! as? String
            return cell
            
        default:
            print("Default case, something went wrong.")
            let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
            return cell
        }
    }

    func addData(_ notification: Notification) {
        print("")
    }
    
    func saveEvent() {
        // Save Record
        //DataManager.shared.saveRecord(stuff)
        print("Event type Saved!")
        
        // Return to previous view which is Medical Event Table
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}
