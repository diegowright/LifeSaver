//
//  MealWaterSummaryTableViewController.swift
//  Mobile Computing Project App
//
//  Created by Robin Stewart on 5/5/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit

class MealWaterSummaryTableViewController: UITableViewController {
    
    var meals:[Meal] = []
    var todayMeals:[Meal] = []
    var water:[WaterLog] = []
    var todayWater:[WaterLog] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Food/Water Summary"
        
        meals = DataManager.shared.loadMeal()
        water = DataManager.shared.loadWater()
        
        for val in meals {
            let theTime = val.date! as Date
            print ("\(theTime)")
            let calendar = Calendar.current
            let day = calendar.component(.day, from: theTime)
        
            let currentDay = calendar.component(.day, from: Date())
            
            if day == currentDay {
                todayMeals.append(val)
            }
        }
        
        for val in water {
            let theTime = val.date! as Date
            print ("\(theTime)")
            let calendar = Calendar.current
            let day = calendar.component(.day, from: theTime)
            
            let currentDay = calendar.component(.day, from: Date())
            
            if day == currentDay {
                todayWater.append(val)
            }
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        print (todayMeals.count)
        return todayMeals.count + todayWater.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < todayMeals.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "foodcell", for: indexPath)
            
            cell.textLabel?.text = todayMeals[indexPath.row].food!
            cell.detailTextLabel?.text = todayMeals[indexPath.row].type!
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "watercell", for: indexPath)
            
            cell.textLabel?.text = String(todayWater[indexPath.row-todayMeals.count].amount) + " oz of"
            cell.detailTextLabel?.text = todayWater[indexPath.row-todayMeals.count].type!
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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     if segue.identifier == "displayFood" {
        let destinationVC = segue.destination as! FoodDetailsViewController
        let rowID = self.tableView.indexPath(for: sender as! UITableViewCell)
        destinationVC.meal = todayMeals[rowID!.row]
     }
    }


}
