//
//  MainFoodViewController.swift
//  Mobile Computing Project App
//
//  Created by Robin Stewart on 5/4/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit
import UserNotifications

class MainFoodViewController: UIViewController {
    
    var goal:Int = 64

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addGoalAction(_ sender: Any) {
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Daily Goal (oz)", message: "Please only enter an integer.", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.text = String(self.goal)
        }
    
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
        self.goal = Int((alert?.textFields![0].text)!)!
        print("Text field: \(self.goal)")}))
        
        self.present(alert, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
