//
//  MealWaterSummaryTableViewController.swift
//  Mobile Computing Project App
//
//  Created by Robin Stewart on 5/5/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit

class MealWaterSummaryTableViewController: UITableViewController {
    
    var meals:[Meal] = DataManager.shared.loadMeal()
    var water:[WaterLog] = DataManager.shared.loadWater()
    var todayMeals:[Meal] = []
    var todayWater:[WaterLog] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Food & Water Summary"
        self.reloadMealAndWater()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.reloadMealAndWater()
        self.tableView.reloadData()
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
        return self.todayMeals.count + self.todayWater.count
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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     if segue.identifier == "displayFood" {
        let destinationVC = segue.destination as! FoodDetailsViewController
        let rowID = self.tableView.indexPath(for: sender as! UITableViewCell)
        destinationVC.meal = todayMeals[rowID!.row]
        }
    }
    
    func reloadMealAndWater() {
        for val in self.meals {
            let theTime = val.date! as Date
            print ("\(theTime)")
            let calendar = Calendar.current
            let day = calendar.component(.day, from: theTime)
            
            let currentDay = calendar.component(.day, from: Date())
            
            if day == currentDay {
                todayMeals.append(val)
            }
        }
        
        for val in self.water {
            let theTime = val.date! as Date
            print ("\(theTime)")
            let calendar = Calendar.current
            let day = calendar.component(.day, from: theTime)
            
            let currentDay = calendar.component(.day, from: Date())
            
            if day == currentDay {
                todayWater.append(val)
            }
        }
    }
}
