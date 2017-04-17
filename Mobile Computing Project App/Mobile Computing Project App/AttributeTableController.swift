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
    
    fileprivate let attributeTypes = [["Date & Time", addDateTimeAtt, DatePickerCell.dateDescription],
                                      ["Question", addQuestionAtt, QuestionCell.questionDescription],
                                      ["Pain Duration", addPainDurAtt, PainDurationCell.painDurDescription],
                                      ["Note", addNoteAtt, NoteCell.noteDescription],
                                      ["Pain Level", addPainLvlAtt, PainLevelCell.painLvlDescription],
                                      ["Pain Location", addPainLocAtt, PainLocationCell.painLocDescription],
                                      ["Pain Type", addPainTypeAtt, PainTypeCell.painTypeDescription]]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Select Attribute"

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        
        let alertController = UIAlertController(title: "Title",
                                                message: "",
                                                preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Save",
                                                style: .default,
                                                handler:
        {
            alert -> Void in
            let textField = alertController.textFields![0] as UITextField
            let textField2 = alertController.textFields![1] as UITextField
            let textField3 = alertController.textFields![2] as UITextField
            
            let questionText = textField.text
            
            if (questionText! == "") {
                
            }
            
            let dataDict = ["questionText":questionText]
            
            // Send notification with data
            NotificationCenter.default.post(name: Notification.Name(rawValue: addQuestionAtt),
                                            object: nil,
                                            userInfo: dataDict)
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alertController.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
            textField.placeholder = "Search1"
        })
        alertController.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
            textField.placeholder = "Search2"
        })
        alertController.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
            textField.placeholder = "Search3"
        })
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func painLocAction(_ row: Int) {
        print("Pain Location", row)
        // Present UIAlertController asking to enter up to 5 locations then
        
        let alertController = UIAlertController(title: "Title",
                                                message: "",
                                                preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Save",
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

                if (location0 == "") {
                    
                }
                
                let dataDict = ["loc0":location0]
                
                // Send notification with data
                NotificationCenter.default.post(name: Notification.Name(rawValue: addQuestionAtt),
                                                object: nil,
                                                userInfo: dataDict)
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
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
        self.present(alertController, animated: true, completion: nil)
    }
    
    func otherAction(_ row: Int) {
        print("Other", row)
    }
}
