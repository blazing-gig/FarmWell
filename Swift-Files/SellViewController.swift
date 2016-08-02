//
//  SellViewController.swift
//  FarmWell
//
//  Created by Aditya on 3/20/16.
//  Copyright © 2016 VinCorp. All rights reserved.
//

import UIKit
import Parse

class SellViewController: UITableViewController,UITextFieldDelegate {

    @IBOutlet weak var expectedPriceField: UITextField!
    @IBOutlet weak var quantityField: UITextField!
    @IBOutlet weak var harvestDateField: UITextField!
    @IBOutlet weak var productField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.expectedPriceField.delegate = self
        self.quantityField.delegate = self
        self.harvestDateField.delegate = self
        self.productField.delegate = self
        
        
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
        if self.productField.text == "" || self.harvestDateField.text == "" || self.quantityField.text == ""||self.expectedPriceField.text == ""
        {
            self.callAlert("Please fll in the mandatory fields")
            return false
        }
        else
        {
            return true
        }
        
    }
    
    @IBAction func uploadInfo(sender: UIButton)
    {
        let flag = self.validateFields()
        if flag
        {
            let currentUserId = PFUser.currentUser()!.objectForKey("user_id") as! String
            
            let tableViewObject = PFObject(className:"Sell")
            tableViewObject["user_id"] = currentUserId
            tableViewObject["product"] = self.productField.text!
            tableViewObject["harvest_date"] = self.harvestDateField.text!
            tableViewObject["quantity"] = Int(self.quantityField.text!)
            tableViewObject["expected_price"] = Int(self.expectedPriceField.text!)
            tableViewObject.saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    // The object has been saved.
                    print("successfully added")
                } else {
                    self.callAlert(String(error))
                    // There was a problem, check error.description
                }
            }
            print("all success")
        }

    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0
        {
            if indexPath.row == 0
            {
                self.productField.becomeFirstResponder()
            }
            else if indexPath.row == 1
            {
                self.harvestDateField.becomeFirstResponder()
            }
            else if indexPath.row == 2
            {
                self.quantityField.becomeFirstResponder()
            }
            else if indexPath.row == 3
            {
                self.expectedPriceField.becomeFirstResponder()
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
