//
//  MedicalEventTable.swift
//  Mobile Computing Project App
//
//  Created by Diego Wright on 3/20/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit

class MedicalEventTable: UITableViewController {

    fileprivate let definedEvents:[String] = ["Headache", "Stomach Pain", "Chest Pain"]
    
    func defineButton() {
        print("define button")
        let storyboard:UIStoryboard = UIStoryboard(name: "MedicalEvent", bundle: nil)
        let eventVC = storyboard.instantiateViewController(withIdentifier: "DefineEvent")
        self.navigationController!.pushViewController(eventVC, animated: true)
    }
    func editButton() {
        print("edit button")
        let name: String = "Migraine"
        let atts: [(String, String)] = [("pain_level", "slider"), ("date", "date_picker")]
        DataManager.shared.saveEventTemplate(name: name, atts: atts)
        
        // let storyboard: UIStoryboard = UIStoryboard(name: "MedicalEvent", bundle: nil)
        // let nextVC = storyboard.instantiateViewController(withIdentifier: "DefineEvent")
        // present(nextVC, animated: true, completion: nil)
    }
    
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
        cell.cellTitle.text = definedEvents[indexPath.row]
        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
        
        if segue.identifier == "eventSegue" {
            if let destination = segue.destination as? EventInput {
                if let idx = tableView.indexPathForSelectedRow?.row {
                    destination.eTitle = definedEvents[idx]
                }
            }
        }
    }
}
