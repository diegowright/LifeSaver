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
    
    //load the CoreData of Users
    fileprivate var userList:[User] = DataManager.shared.loadUsers()
    
    func validUser(userName: String,passWord: String) -> Bool{
        print(userList)
        for user in userList{
            if userName == user.userName && passWord == user.passWord{
                print("TRE")
                return true
            }
        }
        print("FA")
        return false
    }
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        self.userList = DataManager.shared.loadUsers()
    }
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "LoginSeg"{
            //if userName?.text == "CS329E" && passWord?.text == "123456"{
            print("Check")
            if userName.text != "" && passWord.text != ""{
                var a = validUser(userName: userName.text!, passWord: passWord.text!)
                if a == true{
                    checkLogin.text = "Login Success"
                    print("Login Success")
                    
                    return true

                    
                  
                    
                    
                }else{
                    self.alertController = UIAlertController(title: "Login", message: "Wrong Username Password Combo", preferredStyle: UIAlertControllerStyle.alert)
                    
                    let denyAction = UIAlertAction(title: "Fail", style: UIAlertActionStyle.cancel) { (action:UIAlertAction) in
                        print("Login invalid");
                    }
                    self.alertController!.addAction(denyAction)
                    self.present(self.alertController!, animated: true, completion:nil)

                    print("Wrong USERNAME PASSWORD Combo")
                }
            }else{
                checkLogin.text = "Login Fail"
                self.alertController = UIAlertController(title: "Login", message: "Empty Username and/or Password", preferredStyle: UIAlertControllerStyle.alert)
                
                let denyAction2 = UIAlertAction(title: "Fail", style: UIAlertActionStyle.cancel) { (action:UIAlertAction) in
                    print("Login invalid");
                }
                self.alertController!.addAction(denyAction2)
                self.present(self.alertController!, animated: true, completion:nil)
                print("UN PW CAN'T BE EMPTY")
                return false
            }
        }else{
            return true
        }
        return false
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}
