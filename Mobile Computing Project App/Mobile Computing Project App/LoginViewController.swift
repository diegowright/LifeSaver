//
//  LoginViewController.swift
//  Project - William
//
//  Created by Zhenyu Zhang on 3/24/17.
//  Copyright © 2017 CS 329E. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var passWord: UITextField!
    @IBOutlet weak var checkLogin: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Login"
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "LoginSeg"{
            if userName?.text == "CS329E" && passWord?.text == "123456"{
                checkLogin.text = "Login Success"
                return true
            }else{
                checkLogin.text = "Login Fail"
                return false
            }
        }
        return true
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}
