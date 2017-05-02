//
//  AttributeTableController.swift
//  Mobile Computing Project App
//
//  Created by Diego Wright on 4/16/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit

class AttributeTableController: UITableViewController {
    
    var alertController:UIAlertController? = nil
    
    fileprivate let attributeTypes = [["Date & Time", addOtherAtt, DateTimeCell.dateDescription],
                                      ["Question", addQuestionAtt, QuestionCell.questionDescription],
                                      ["Pain Duration", addOtherAtt, PainDurationCell.painDurDescription],
                                      ["Note", addOtherAtt, NoteCell.noteDescription],
                                      ["Pain Level", addOtherAtt, PainLevelCell.painLvlDescription],
                                      ["Pain Location", addPainLocAtt, PainLocationCell.painLocDescription],
                                      ["Pain Type", addOtherAtt, PainTypeCell.painTypeDescription]]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Select Attribute"
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
        return self.attributeTypes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> AttributeCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "attributeCell", for: indexPath) as! AttributeCell

        // Set cell label and action
        let cellLabel:String = self.attributeTypes[indexPath.row][0]
        cell.rowLabel.text = cellLabel
        cell.attributeDescription.text = self.attributeTypes[indexPath.row][2]
        
        if (cellLabel == "Question") {
            cell.tapAction = {
                (cell) in self.questionAction(tableView.indexPath(for: cell)!.row)
            }
        } else if (cellLabel == "Pain Location") {
            cell.tapAction = {
                (cell) in self.painLocAction(tableView.indexPath(for: cell)!.row)
            }
        } else {
            cell.tapAction = {
                (cell) in self.otherAction(tableView.indexPath(for: cell)!.row)
            }
        }
        return cell
    }
    
    // Dummy functions for now
    func questionAction(_ row: Int) {
        print("Question", row)
        // Present UIAlertController asking to enter question and then a confirm or back
        
        let alertController = UIAlertController(title: "Add Attribute",
                                                message: "Enter in the question you would like to ask yourself.",
                                                preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Add",
                                                style: .default,
                                                handler:
        {
            alert -> Void in
            let textField = alertController.textFields![0] as UITextField
            
            let questionText:String = textField.text!
            
            if (questionText == "") {
                self.showMessage("Need to enter in a question!")
                return
            }
            
            let dataDict = ["question":questionText, "id":"Question"]
            // Send notification with data
            NotificationCenter.default.post(name: Notification.Name(rawValue: addQuestionAtt),
                                            object: nil,
                                            userInfo: dataDict)
            _ = self.navigationController?.popViewController(animated: true)
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alertController.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
            textField.placeholder = "Your question"
        })
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func painLocAction(_ row: Int) {
        print("Pain Location", row)
        // Present UIAlertController asking to enter up to 5 locations then
        
        let alertController = UIAlertController(title: "Add Attribute",
                                                message: "Enter the locations you want to keep track of (blank boxes will not appear).",
                                                preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Add",
                                                style: .default,
                                                handler:
            {
                alert -> Void in
                let textField0 = alertController.textFields![0] as UITextField
                let textField1 = alertController.textFields![1] as UITextField
                let textField2 = alertController.textFields![2] as UITextField
                let textField3 = alertController.textFields![3] as UITextField
                let textField4 = alertController.textFields![4] as UITextField
                
                let location0 = textField0.text
                let location1 = textField1.text
                let location2 = textField2.text
                let location3 = textField3.text
                let location4 = textField4.text

                if (location0 == "" || location1 == "") {
                    self.showMessage("Must have at least two locations entered")
                    return
                }
                
                let dataDict = ["id":self.attributeTypes[row][0],
                                "loc0":location0,
                                "loc1":location1,
                                "loc2":location2,
                                "loc3":location3,
                                "loc4":location4,]
                
                // Send notification with data
                NotificationCenter.default.post(name: Notification.Name(rawValue: addPainLocAtt),
                                                object: nil,
                                                userInfo: dataDict)
                _ = self.navigationController?.popViewController(animated: true)
        }))
        
        // Add cancel button
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        // Add 5 text inputs
        alertController.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
            textField.placeholder = "Location 1"
        })
        alertController.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
            textField.placeholder = "Location 2"
        })
        alertController.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
            textField.placeholder = "Location 3"
        })
        alertController.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
            textField.placeholder = "Location 4"
        })
        alertController.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
            textField.placeholder = "Location 5"
        })
        
        // Present the alert controller
        self.present(alertController, animated: true, completion: nil)
    }
    
    // The other attributes all have only an id value so no special work is needed to send their notification
    func otherAction(_ row: Int) {
        print("Other", row)
        
        let alertController = UIAlertController(title: "Add Attribute",
                                                message: "Add this attribute?",
                                                preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Add",
                                                style: .default,
                                                handler:
            {
                alert -> Void in
                let dataDict = ["id":self.attributeTypes[row][0]]
                NotificationCenter.default.post(name: Notification.Name(rawValue: self.attributeTypes[row][1]),
                                                                 object: nil,
                                                                 userInfo: dataDict)
                _ = self.navigationController?.popViewController(animated: true)
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func showMessage(_ message: String) {
        let alertController = UIAlertController(title: self.title!,
                                                message: message,
                                                preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Ok",
                                                style: .default,
                                                handler: {Void in print("Ok pressed")}))
        
        self.present(alertController, animated: true, completion: nil)
    }
}
