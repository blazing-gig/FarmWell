//
//  UpdateRecordTableViewController.swift
//  FarmWell
//
//  Created by Aditya on 3/20/16.
//  Copyright © 2016 VinCorp. All rights reserved.
//

import UIKit
import Parse

class UpdateRecordTableViewController: UITableViewController,UITextFieldDelegate {

    @IBOutlet weak var areaField: UITextField!
    @IBOutlet weak var seedVarietyField: UITextField!
    @IBOutlet weak var waterRequiredField: UITextField!
    @IBOutlet weak var cropTypeField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.areaField.delegate = self
        self.seedVarietyField.delegate = self
        self.waterRequiredField.delegate = self
        self.cropTypeField.delegate = self

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
    func validateFields() -> Bool
    {
        if self.waterRequiredField.text == "" || self.areaField.text == "" || self.seedVarietyField.text == "" || self.cropTypeField.text == ""
        {
            self.callAlert("Please fll in the mandatory fields")
            return false
        }
        if (Int(self.waterRequiredField.text!) == nil || Int(self.areaField.text!) == nil)
        {
            self.callAlert("invalid type validation")
            return false
        }
        
        
        return true
    }
    
    @IBAction func updateRecord(sender: UIButton)
    {
        let flag = self.validateFields()
        if flag
        {
            
            let u_id = PFUser.currentUser()!["user_id"] as! String
            print("uid is \(u_id) and crop type is \(self.cropTypeField.text!)")
            let query = PFQuery(className:"Data")
            query.whereKey("user_id", equalTo:u_id)
            query.whereKey("crop_type", equalTo:self.cropTypeField.text!)
            
            query.findObjectsInBackgroundWithBlock {
                (results: [PFObject]?, error: NSError?) -> Void in
                if error == nil {
                    if let retrievedList = results as [PFObject]! {
                        print("retrived list count to delete \(retrievedList.count)")
                        if retrievedList.count > 0
                        {
                            for object in retrievedList {
                                object["water_required"] = Int(self.waterRequiredField.text!)
                                object["seed_variety"] = self.seedVarietyField.text!
                                object["area"] = Int(self.areaField.text!)
                                object.saveInBackground()
                            }
                            self.callAlert("Updation successful")
                            
                        }
                        else
                        {
                            self.callAlert("Sorry no matching records found")
                        }
                    }
                    
                }
                
            }
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0
        {
            self.cropTypeField.becomeFirstResponder()
            
        }
        else if indexPath.section == 1
        {
            if indexPath.row == 0
            {
                self.waterRequiredField.becomeFirstResponder()
            }
            else if indexPath.row == 1
            {
                self.seedVarietyField.becomeFirstResponder()
            }
            else if indexPath.row == 2
            {
                self.areaField.becomeFirstResponder()
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
