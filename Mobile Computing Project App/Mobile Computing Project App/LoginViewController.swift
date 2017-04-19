//
//  LoginViewController.swift
//  Project - William
//
//  Created by Zhenyu Zhang on 3/24/17.
//  Copyright © 2017 CS 329E. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    var alertController:UIAlertController? = nil
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var passWord: UITextField!
    @IBOutlet weak var checkLogin: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Login"

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "LoginSegue"{
            print(identifier)
            
            let isValid = DataManager.shared.isValidUser(userName: userName.text!, passWord: passWord.text!)
            
            if isValid == true {
                checkLogin.text = "Login Success"
                print("Login Success")
                
                // Set current user
                let currentUser:User = DataManager.shared.getUser(username: userName.text!, password: passWord.text!)
                if let _ = currentUser.userName {
                    DataManager.shared.setCurrentUser(user: currentUser)
                    return true
                } else {
                    print("User not found.")
                    return false
                }
            }else{
                self.alertController = UIAlertController(title: "Login",
                                                         message: "Username and/or password not found. Login invalid.",
                                                         preferredStyle: UIAlertControllerStyle.alert)
                
                let denyAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel) {
                    (action:UIAlertAction) in print("Login invalid");
                }
                self.alertController!.addAction(denyAction)
                self.present(self.alertController!, animated: true, completion:nil)
            }
        } else if identifier == "registerSegue" {
            return true
        }
        return false
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}
