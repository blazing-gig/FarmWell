//
//  SignUpViewController.swift
//  FarmWell
//
//  Created by Aditya on 3/19/16.
//  Copyright © 2016 VinCorp. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var successLabel: UILabel!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var mailId: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.usernameField.delegate = self
        self.passwordField.delegate = self
        self.confirmPassword.delegate = self
        self.mailId.delegate = self

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func check() -> Bool
    {
        if usernameField.text == "" || passwordField.text == "" || confirmPassword.text == ""
        {
            callAlert("please fill the mandatory fields")
            return false
        }
        if passwordField.text != confirmPassword.text
        {
            callAlert("password entries do not match")
            return false
        }
        return true
    }
    func callAlert(errorMessage: String)
    {
        let alert = UIAlertController(title: "Alert", message: errorMessage , preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }

    
    @IBAction func signUp(sender: UIButton)
    {
        
            let flag = self.check()
            print("flag is \(flag)")
            if flag
            {
                let user = PFUser()
                user.username = self.usernameField.text!
                user.password = self.confirmPassword.text!
                user.email = self.mailId.text!
                let uuid = NSUUID().UUIDString
                user["user_id"] = uuid
                
                // other fields can be set just like with PFObject
                
                user.signUpInBackgroundWithBlock {
                    (succeeded: Bool, error: NSError?) -> Void in
                    if let error = error {
                        let errorString = error.userInfo["error"] as? NSString
                        print("error is \(errorString)")
                        self.callAlert(String(errorString))
                        // Show the errorString somewhere and let the user try again.
                    } else {
                        // Hooray! Let them use the app now.
                        self.successLabel.text = "Success!!"
                    }
                }
            }
            
        

    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0
        {
            if indexPath.row == 0
            {
                self.usernameField.becomeFirstResponder()
            }
            else if indexPath.row == 1
            {
                self.passwordField.becomeFirstResponder()
            }
            else if indexPath.row == 2
            {
                self.confirmPassword.becomeFirstResponder()
            }
            else if indexPath.row == 3
            {
                self.mailId.becomeFirstResponder()
            }
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }


    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
