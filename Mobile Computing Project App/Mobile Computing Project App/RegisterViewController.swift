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
    
    @IBAction func cfmBtn(_ sender: Any) {
        if userN?.text == "" || passW?.text == "" {
            
            self.alertController = UIAlertController(title: "Registration Error", message: "Username and/or Password can't be empty", preferredStyle: UIAlertControllerStyle.alert)
            
            let cancelAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel) { (action:UIAlertAction) in
                print("Ok Button Pressed 1");
            }
            self.alertController!.addAction(cancelAction)
            self.present(self.alertController!, animated: true, completion:nil)
            
        }else if userN?.text != "" && passW.text != ""{
            
            DataManager.shared.saveUser(userN: userN.text!, passW: passW.text!)
            print("It works")
            
            self.alertController = UIAlertController(title: "Registration", message: "Registration Successful", preferredStyle: UIAlertControllerStyle.alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel) { (action:UIAlertAction) in
                print("Ok Button Pressed 2");
            }
            self.alertController!.addAction(okAction)
            self.present(self.alertController!, animated: true, completion:nil)
            
        }
    }
    
    @IBAction func backBtn(_ sender: Any) {
        
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
