//
//  MedicalEventTable.swift
//  Mobile Computing Project App
//
//  Created by Diego Wright on 3/20/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit

class MedicalEventTable: UITableViewController {

    fileprivate var definedEvents:[Template] = DataManager.shared.loadTemplates()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Medical Events"
        
        let edit_button:UIBarButtonItem = UIBarButtonItem(title:"Edit",
                                                          style: .plain,
                                                          target: self,
                                                          action: #selector(MedicalEventTable.editButton))
        let define_button:UIBarButtonItem = UIBarButtonItem(title:"Define New",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(MedicalEventTable.defineButton))
        
        self.navigationItem.leftBarButtonItem = edit_button
        self.navigationItem.rightBarButtonItem = define_button
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // reload events when page is opened again
        super.viewWillAppear(animated)
        self.definedEvents = DataManager.shared.loadTemplates()
        self.tableView.reloadData()
        self.tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // There will only be one section for this table, each event will be a cell in this section
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // This should return the number of defined events
        return definedEvents.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> MedicalEventCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "event_cell", for: indexPath) as! MedicalEventCell
        // Set cell title as name attribute from EventTemplate object associated with the current row
        cell.cellTitle.text = definedEvents[indexPath.row].name
        return cell
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
        
        // For each seque set the destination template as the correct one from the list
        if segue.identifier == "eventSegue" {
            if let destination = segue.destination as? EventInput {
                if let idx = tableView.indexPathForSelectedRow?.row {
                    destination.template = definedEvents[idx]
                }
            }
        }
    }
    
    func defineButton() {
        let storyboard:UIStoryboard = UIStoryboard(name: "MedicalEvent", bundle: nil)
        let eventVC = storyboard.instantiateViewController(withIdentifier: "DefineEvent")
        self.navigationController!.pushViewController(eventVC, animated: true)
    }
    
    func editButton() {
        print("Current user: ", DataManager.shared.getCurrentUser())
        //let name: String = "Migraine"
        //let atts: [(String, String)] = [("pain_level", "slider"), ("date", "date_picker")]
        //DataManager.shared.saveEventTemplate(name: name, atts: atts)
        
        // let storyboard: UIStoryboard = UIStoryboard(name: "MedicalEvent", bundle: nil)
        // let nextVC = storyboard.instantiateViewController(withIdentifier: "DefineEvent")
        // present(nextVC, animated: true, completion: nil)
    }
}
