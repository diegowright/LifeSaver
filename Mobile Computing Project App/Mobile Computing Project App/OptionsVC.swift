//
//  FifthViewController.swift
//  Mobile Computing Project App
//
//  Created by Diego Wright on 3/24/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit

class OptionsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Instantiate the separate storyboard for Options section and load it
        let storyboard = UIStoryboard(name: "optionsStoryboard", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "OptionsNav") as UIViewController
        addChildViewController(controller)
        view.addSubview(controller.view)
        controller.didMove(toParentViewController: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
