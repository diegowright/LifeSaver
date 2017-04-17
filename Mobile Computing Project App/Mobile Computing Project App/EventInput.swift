//
//  EventInput.swift
//  Mobile Computing Project App
//
//  Created by Diego Wright on 3/21/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit

class EventInput: UIViewController {

    @IBOutlet weak var eventTitle: UILabel!
    
    var template:Template?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.template!.name

        // Test to see what is in template attributes
        var atext:String = ""
        
        /*
        let atts:[TemplateAttribute] = Array(self.template!.attributes!) as! [TemplateAttribute]
        print("Count of atts: ", atts.count)
        for att in atts {
            atext.append("Name: ")
            atext.append(att.name!)
            atext.append(", ")
        }
        */
        
        self.eventTitle.text = atext
        
        // Programatically add views based on template attributes, ugh...
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}
