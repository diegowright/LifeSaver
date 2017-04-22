//
//  RegisterViewController.swift
//  Mobile Computing Project App
//
//  Created by Zhenyu Zhang on 4/16/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController {

    var alertController:UIAlertController? = nil
    @IBOutlet weak var userN: UITextField!
    @IBOutlet weak var passW: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Register"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func confirmButton(_ sender: Any) {
        if userN?.text == "" || passW?.text == "" {
            
            self.alertController = UIAlertController(title: "Registration Error", message: "Username and/or Password can't be empty", preferredStyle: UIAlertControllerStyle.alert)
            
            let cancelAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel) { (action:UIAlertAction) in
                print("Ok Button Pressed 1");
            }
            self.alertController!.addAction(cancelAction)
            self.present(self.alertController!, animated: true, completion:nil)
            
        }else if userN?.text != "" && passW.text != ""{
            
            let saved = DataManager.shared.saveUser(userN: userN.text!, passW: passW.text!, theme: "light")
            
            if saved == true {
                print("New user saved with username \(userN) and password \(passW).")
                
                self.alertController = UIAlertController(title: "Registration", message: "Registration Successful", preferredStyle: UIAlertControllerStyle.alert)
                
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel) { (action:UIAlertAction) in
                    print("Ok Button Pressed 2")
                    // pop back to login view
                    _ = self.navigationController?.popViewController(animated: true)
                }
                self.alertController!.addAction(okAction)
                self.present(self.alertController!, animated: true, completion:nil)
            } else {
                print("User already exists.")
                
                self.alertController = UIAlertController(title: "Registration", message: "User already exists.", preferredStyle: UIAlertControllerStyle.alert)
                
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel) { (action:UIAlertAction) in
                    print("Ok Button Pressed")
                }
                self.alertController!.addAction(okAction)
                self.present(self.alertController!, animated: true, completion:nil)
            }
        }
    }
}
