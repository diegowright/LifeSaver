//
//  ThirdViewController.swift
//  Mobile Computing Project App
//
//  Created by Diego Wright on 3/24/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit

class CalendarVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Instantiate the separate storyboard for Third section and load it
        let storyboard = UIStoryboard(name: "Calendar", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "CalendarNav") as UIViewController
        addChildViewController(controller)
        view.addSubview(controller.view)
        controller.didMove(toParentViewController: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
