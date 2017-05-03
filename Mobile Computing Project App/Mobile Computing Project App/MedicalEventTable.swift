//
//  MedicalEventTable.swift
//  Mobile Computing Project App
//
//  Created by Diego Wright on 3/20/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit

class MedicalEventTable: UITableViewController {

    fileprivate var definedEvents:[Template] = DataManager.shared.loadAllTemplates()
    
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
        self.definedEvents = DataManager.shared.loadAllTemplates()
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
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
        
        // For each seque set the destination template as the correct one from the list
        if segue.identifier == "eventSegue" {
            if let destination = segue.destination as? EventInputTable {
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
        print("Current events saved: ")
        //print all recorded events for testing purposes
        print(DataManager.shared.loadAllEvents())
    }
}
