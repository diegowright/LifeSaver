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
    var attributeList:[(String, String)] = []          // This will contain attributes added, starts with none when defining new event
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var attributeTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Define Event"
        
        let save = UIBarButtonItem(title: "Save", style: UIBarButtonItemStyle.done, target: self, action: #selector(DefineEventView.saveEvent))
        //save.title = "Save"
        //save.action = #selector(DefineEventView.saveEvent)
        self.navigationItem.rightBarButtonItem = save
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addAttributeSegue" {
            let backItem = UIBarButtonItem()
            backItem.title = "Cancel"
            navigationItem.backBarButtonItem = backItem
            
            if let destination = segue.destination as? AttributeInformationView {
                destination.currentAttibuteList = self.attributeList
            }
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
        
        print("Event type Saved!")
        // save function for event goes HERE
        
        // Return to previous view which is Medical Event Table
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.attributeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        
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
