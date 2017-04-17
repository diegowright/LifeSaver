//
//  AttributeTableController.swift
//  Mobile Computing Project App
//
//  Created by Diego Wright on 4/16/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit

class AttributeTableController: UITableViewController {
    
    fileprivate let attributeTypes = [["Date & Time", addDateTimeAtt, DatePickerCell.dateDescription],
                                      ["Question", addQuestionAtt, QuestionCell.questionDescription],
                                      ["Pain Duration", addPainDurAtt, PainDurationCell.painDurDescription],
                                      ["Note", addNoteAtt, NoteCell.noteDescription],
                                      ["Pain Level", addPainLvlAtt, PainLevelCell.painLvlDescription],
                                      ["Pain Location", addPainLocAtt, PainLocationCell.painLocDescription],
                                      ["Pain Type", addPainTypeAtt, PainTypeCell.painTypeDescription]]
    
    fileprivate let attDict = ["Date & Time":addDateTimeAtt,
                               "Question":addQuestionAtt,
                               "Pain Duration":addPainDurAtt,
                               "Note":addNoteAtt,
                               "Pain Level":addPainLvlAtt,
                               "Pain Location":addPainLocAtt,
                               "Pain Type":addPainTypeAtt]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Select Attribute"

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        cell.cellLabel.setTitle(cellLabel, for: .normal)
        cell.cellLabel.setTitleColor(UIColor.black, for: .normal)
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
    }
    
    func painLocAction(_ row: Int) {
        print("Pain Location", row)
        // Present UIAlertController asking to enter up to 5 locations then
    }
    
    func otherAction(_ row: Int) {
        print("Other", row)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
    }
    */

}
