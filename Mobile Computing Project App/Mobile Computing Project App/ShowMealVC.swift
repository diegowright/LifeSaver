//
//  ShowMealVC.swift
//  Mobile Computing Project App
//
//  Created by Diego Wright on 5/6/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit

class ShowMealVC: UIViewController {

    var meal:Meal?
    var cellDateFormatter:DateFormatter = DateFormatter()
    
    @IBOutlet weak var datetime: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var food: UILabel!
    @IBOutlet weak var beverage: UILabel!
    @IBOutlet weak var details: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cellDateFormatter.dateFormat = "hh:mm:ss"
        self.cellDateFormatter.locale = NSLocale.autoupdatingCurrent
        
        self.title = "Meal"
        
        self.datetime.text = self.cellDateFormatter.string(from: self.meal!.date! as Date)
        self.type.text = self.meal!.type!
        self.food.text = self.meal!.food!
        self.beverage.text = self.meal!.beverage!
        self.details.text = self.meal!.comment!

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
