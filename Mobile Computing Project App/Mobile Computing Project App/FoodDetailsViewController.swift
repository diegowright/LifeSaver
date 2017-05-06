//
//  FoodDetailsViewController.swift
//  Mobile Computing Project App
//
//  Created by Robin Stewart on 5/5/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit

class FoodDetailsViewController: UIViewController {
    
    @IBOutlet weak var dateOutlet: UILabel!
    @IBOutlet weak var typeOutlet: UILabel!
    @IBOutlet weak var foodOutlet: UILabel!
    @IBOutlet weak var beverageOutlet: UILabel!
    @IBOutlet weak var commentsOutlet: UITextView!

    var meal:Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm"
        dateFormatter.locale = NSLocale.autoupdatingCurrent
        
        dateOutlet.text = dateFormatter.string(from: meal?.date as! Date)
        typeOutlet.text = meal?.type
        foodOutlet.text = meal?.food
        beverageOutlet.text = meal?.beverage
        commentsOutlet.text = meal?.comment
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
