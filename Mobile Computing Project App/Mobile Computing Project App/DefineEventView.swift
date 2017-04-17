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
    var attributeList = ["Question":[], "Pain Duration":[], "Pain Level":[], "Pain Type":[],
                         "Pain Location":[], "Note":[], "DateTime":[]]
    var attributeNames:[String] = []
    
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
        
        // Add observers that look for attribute save notifications
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(questionHandler(_:)),
                                               name: NSNotification.Name(rawValue: addQuestionAtt),
                                               object: nil)
        
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
    
    func questionHandler(_ notification: Notification) {
        print("Adding attribute to current event.")
        
        // extract the data that was sent in the notification
        let dataDict:Dictionary<String,String> = notification.userInfo as! Dictionary<String,String>
        
        let questionText = dataDict["question"]!
        print("Question: ", questionText)
        
        // Add attribute to data list and reload table
        let questionAtt:TemplateQuestionAtt = TemplateQuestionAtt()
        questionAtt.question = questionText
        questionAtt.id = questionText
        
        attributeList["Question"]?.append(questionText)
        self.attributeNames.append(questionText)
        self.attributeTable.reloadData()
        
        print("Question attribute added to current event.")
    }
    
    func painLocHandler(_ notification: Notification) {
        print("Adding attribute to current event.")
        
        // extract the data that was sent in the notification
        let dataDict:Dictionary<String,String> = notification.userInfo as! Dictionary<String,String>
        
        let id = dataDict["id"]!
        let loc0 = dataDict["loc0"]!
        let loc1 = dataDict["loc1"]!
        let loc2 = dataDict["loc2"]!
        let loc3 = dataDict["loc3"]!
        let loc4 = dataDict["loc4"]!
        
        print("Id: ", id, "Locations: ", loc0, loc1, loc2, loc3 ,loc4)
        
        // Add attribute to data list and reload table
        let painLocAtt:TemplatePainLocAtt = TemplatePainLocAtt()
        painLocAtt.id = id
        painLocAtt.loc0 = loc0
        painLocAtt.loc1 = loc1
        painLocAtt.loc2 = loc2
        painLocAtt.loc3 = loc3
        painLocAtt.loc4 = loc4
        
        //attributeList.append((name, type))
        self.attributeTable.reloadData()
        self.attributeNames.append(id)
        print("Note attribute added to current event.")
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
        //DataManager.shared.saveTemplate(templateName: self.eventName.text!,
        //                                attributeList: self.attributeList)
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
        return self.attributeNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "attributeCell", for: indexPath)
        
        let cellLabel:String = self.attributeNames[indexPath.row]
        cell.textLabel?.text = cellLabel
        
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
