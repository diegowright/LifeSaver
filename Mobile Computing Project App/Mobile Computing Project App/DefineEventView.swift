//
//  DefineEventView.swift
//  Mobile Computing Project App
//
//  Created by Diego Wright on 3/20/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit

class DefineEventView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var alertController:UIAlertController? = nil
    
    @IBOutlet weak var eventName: UITextField!  // This will be the name of the medical event
    var attributeList:[(String, String)] = []   // This will contain attributes added, starts with none when defining new event
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var attributeTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Define Event"
        
        // Set attribute table datasource and delegate
        attributeTable.dataSource = self
        attributeTable.delegate = self
        
        // Define save bar and its action
        let save = UIBarButtonItem(title: "Save", style: UIBarButtonItemStyle.done, target: self, action: #selector(DefineEventView.saveEvent))
        self.navigationItem.rightBarButtonItem = save
        
        // Add observer that looks for attribute save notifications
        NotificationCenter.default.addObserver(self, selector: #selector(notifyHandler(_:)), name: NSNotification.Name(rawValue: addAttKey), object: nil)
        
        // function that dismisses keyboard on tap
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        // You need to remove the observer before this object goes away.
        // This removes all registered observers for this object.
        NotificationCenter.default.removeObserver(self)
    }
    
    func notifyHandler(_ notification: Notification) {
        print("Adding attribute to current event.")
        
        // extract the data that was sent in the notification
        let dataDict:Dictionary<String,String> = notification.userInfo as! Dictionary<String,String>
        
        let name = dataDict["name"]!
        let type = dataDict["type"]!
        
        print("name: ", name, "\ntype: ", type)
        
        // Add attribute to data list and reload table
        attributeList.append((name, type))
        self.attributeTable.reloadData()
        print("attribute added to current event.")
        print(self.attributeList)
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addAttributeSegue" {
            let backItem = UIBarButtonItem()
            backItem.title = "Cancel"
            navigationItem.backBarButtonItem = backItem
        }
    }
    
    func saveEvent() {
        // Check to see if there are any attributes or if an event name is entered
        if self.eventName.text == "" {
            let message: String = "You must have a name for your attribute to save"
            displayMessage(message)
            return
        } else if self.attributeList.count == 0 {
            let message: String = "You must have at least one attribute defined to save"
            displayMessage(message)
            return
        }
        
        // Save template
        DataManager.shared.saveTemplate(templateName: self.eventName.text!,
                                        attributeList: self.attributeList)
        print("Event type Saved!")
        
        // Return to previous view which is Medical Event Table
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Count of attribute list: ", self.attributeList.count)
        return self.attributeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "attributeCell", for: indexPath)
        
        // Configure the cell...
        let index:Int = indexPath.row
        let attributeName: String = self.attributeList[index].0
        let attributeType: String = self.attributeList[index].1
        cell.textLabel?.text = attributeName
        cell.detailTextLabel?.text = attributeType
        
        return cell
    }
    
    func displayMessage(_ message: String) {
        DispatchQueue.main.async {
            self.alertController =
                UIAlertController(title: "Whoa", message: message, preferredStyle: UIAlertControllerStyle.alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action:UIAlertAction) in
            }
            
            self.alertController!.addAction(okAction)
            
            self.present(self.alertController!, animated: true, completion:nil)
        }
    }

    // dismisses keyboard on touch outside of keyboard
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}
