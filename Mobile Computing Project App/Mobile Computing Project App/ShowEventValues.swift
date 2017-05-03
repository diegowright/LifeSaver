//
//  ShowEventValues.swift
//  Mobile Computing Project App
//
//  Created by Diego Wright on 4/18/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit

class ShowEventValues: UITableViewController {

    var event:Event?
    var eventType:String?
    var attributes:[Dictionary<String, Any>]?  // make function in data manager that gets attributes of an event of some type
    var questionIdx:Int = 0 // This keeps track of the questions
    
    let white:UIColor = UIColor.white
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.event!.eventType!
        
        // Load attributes for the given event
        self.attributes = DataManager.shared.getEventAttributeData(event: self.event!)
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
        return self.attributes!.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Configure the cell...
        let identifier = self.attributes![indexPath.row]["id"]! as! String
        switch identifier {
            
        case "Date & Time":
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! DateTimeCell
            cell.backgroundColor = white
            cell.row = indexPath.row
            
            // Set proper date value
            cell.datePicker!.date = self.attributes![indexPath.row]["value"]! as! Date
            // Disable date picker
            cell.datePicker!.isEnabled = false
            
            return cell
            
        case "Note":
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! NoteCell
            cell.backgroundColor = white
            cell.row = indexPath.row
            
            // Set proper value
            cell.noteText!.text = self.attributes![indexPath.row]["value"]! as? String
            // Disable note text
            cell.noteText!.isEnabled = false
            
            return cell
            
        case "Pain Location":
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! PainLocationCell
            cell.backgroundColor = white
            cell.row = indexPath.row
            
            // Add correct segments to location control
            cell.locationControl.removeAllSegments()
            let template:Template = self.event!.template! 
            let locAtt = Array(template.painLocAtts!)[0]    // Ideally there should only be one of these
            let val:TemplatePainLocAtt = locAtt as! TemplatePainLocAtt
            
            let loc0:String = val.loc0!
            let loc1:String = val.loc1!
            let loc2:String = val.loc2!
            let loc3:String = val.loc3!
            let loc4:String = val.loc4!
            
            if loc0 != "" { cell.locationControl.insertSegment(withTitle: loc0, at: 0, animated: false) }
            if loc1 != "" { cell.locationControl.insertSegment(withTitle: loc1, at: 1, animated: false) }
            if loc2 != "" { cell.locationControl.insertSegment(withTitle: loc2, at: 2, animated: false) }
            if loc3 != "" { cell.locationControl.insertSegment(withTitle: loc3, at: 3, animated: false) }
            if loc4 != "" { cell.locationControl.insertSegment(withTitle: loc4, at: 4, animated: false) }

            // select proper value
            let idx16:Int16 = self.attributes![indexPath.row]["value"]! as! Int16
            cell.locationControl.selectedSegmentIndex = Int(idx16)
            // disable location control
            cell.locationControl.isEnabled = false
            
            return cell
            
        case "Pain Type":
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! PainTypeCell
            cell.backgroundColor = white
            cell.row = indexPath.row
            
            // Set proper pain type value
            let idx16:Int16 = self.attributes![indexPath.row]["value"]! as! Int16
            cell.painTypeControl.selectedSegmentIndex = Int(idx16)
            // Disable pain type control
            cell.painTypeControl.isEnabled = false
            
            return cell
            
        case "Pain Duration":
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! PainDurationCell
            cell.backgroundColor = white
            cell.row = indexPath.row
            // Set proper pain duration value
            cell.durationInput.text = self.attributes![indexPath.row]["value"]! as? String
            let unit:Int16 = self.attributes![indexPath.row]["unit"]! as! Int16
            cell.unitControl.selectedSegmentIndex = Int(unit)
            // disable text input and segmented control
            cell.durationInput.isEnabled = false
            cell.unitControl.isEnabled = false
            
            return cell
            
        case "Pain Level":
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! PainLevelCell
            cell.backgroundColor = white
            cell.row = indexPath.row
            
            // Set proper pain level
            let lvl:Int16 = self.attributes![indexPath.row]["value"]! as! Int16
            cell.painSlider.value = Float(lvl)
            cell.painLevel.text = String(describing: self.attributes![indexPath.row]["value"]!)
            // disable pain slider
            cell.painSlider.isEnabled = false
            
            return cell
            
        case "Question":
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! QuestionCell
            cell.backgroundColor = white
            cell.row = indexPath.row
            
            // Set question label from template
            let template:Template = self.event!.template!
            let questionAtt = template.questionAtts!.object(at: self.questionIdx) as! TemplateQuestionAtt
            self.questionIdx += 1
            cell.questionText.text = questionAtt.id!
            
            //set questionanswer to correct value
            let idx16:Int16 = self.attributes![indexPath.row]["value"]! as! Int16
            cell.answer.selectedSegmentIndex = Int(idx16)
            cell.questionText.text = self.attributes![indexPath.row]["question"]! as? String
            // disable answer selector
            cell.answer.isEnabled = false
            return cell
            
        default:
            print("Default case, something went wrong.")
            let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
            return cell
        }
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
