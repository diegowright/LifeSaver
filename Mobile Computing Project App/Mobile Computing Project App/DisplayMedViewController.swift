//
//  DisplayMedViewController.swift
//  Mobile Computing Project App
//
//  Created by Robin Stewart on 4/17/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit
import CoreData

class DisplayMedViewController: UIViewController {
    
    var med = NSManagedObject()
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var doseUnit: UILabel!
    @IBOutlet weak var instructOutlet: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Medicine Details"
        let barButton = UIBarButtonItem()
        barButton.title = "Back"
        navigationController!.navigationBar.topItem!.backBarButtonItem = barButton
        
        name.text = med.value(forKey: "name") as? String
        let tempDose:Float = (med.value(forKey: "dose") as? Float)!
        doseUnit.text = String(tempDose) + " " + (med.value(forKey: "unit") as? String)!
        instructOutlet.text = med.value(forKey: "instruct") as? String
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
