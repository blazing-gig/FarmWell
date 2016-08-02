//
//  LoginViewController.swift
//  FarmWell
//
//  Created by Aditya on 3/19/16.
//  Copyright © 2016 VinCorp. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.usernameField.delegate = self
        self.passwordField.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func callAlert(errorMessage: String)
    {
        let alert = UIAlertController(title: "Alert", message: errorMessage , preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func validateUserFields() -> Bool
    {
        if self.usernameField.text! == "" || self.passwordField.text! == ""
        {
            callAlert("please fill the mandatory fields")
            return false
        }
        else
        {
            return true
        }
    }
    
    @IBAction func cancel(segue: UIStoryboardSegue)
    {
        
    }
    
    @IBAction func login(sender: UIButton)
    {
        PFUser.logInWithUsernameInBackground(usernameField.text!, password:passwordField.text!) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                // Do stuff after successful login.
                print("the user is \(user!.username)")
                self.performSegueWithIdentifier("showMainScreen", sender: self)
                
            } else {
                print("login failed")
                print(error)
                print("error is \(error?.userInfo["error"])")
                self.callAlert((error?.userInfo["error"])! as! String)
                // The login failed. Check error to see why.
            }
        }
 
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        if textField.tag == 0
        {
            textField.resignFirstResponder()
            return true
        }
        else
        {
            textField.resignFirstResponder()
            return true
        }
    }

    
}
