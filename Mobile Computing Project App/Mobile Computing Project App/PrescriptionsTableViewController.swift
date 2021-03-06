//
//  PrescriptionsTableViewController.swift
//  Mobile Computing Project App
//
//  Created by Robin Stewart on 4/14/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit

class PrescriptionsTableViewController: UITableViewController {
    
    var medArray:[Medicine] = DataManager.shared.loadMedicine()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Prescriptions"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        medArray = DataManager.shared.loadMedicine()
        self.tableView.reloadData()
        self.tableView.delegate = self
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
        return medArray.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> PrescriptionTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath) as! PrescriptionTableViewCell
        
        let med = medArray[indexPath.row]
        let name = med.name!
        let dose = med.dose
        let unit = med.unit!
        cell.nameOutlet.text = "\(name) (\(String(dose)) \(unit))"

        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "displayMed" {
            let destinationVC = segue.destination as! DisplayMedViewController
            let rowID = self.tableView.indexPath(for: sender as! UITableViewCell)
            destinationVC.med = medArray[rowID!.row]
        }
    }


}
