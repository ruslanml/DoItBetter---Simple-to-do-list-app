//
//  ViewController.swift
//  DoItBetter
//
//  Created by Ruslan Mursalzade on 7/5/16.
//  Copyright © 2016 Ruslan Mursalzade. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {
    
    var itemListArray = [String]()
    
    @IBOutlet var item: UITextField!
    
    @IBAction func addItem(sender: AnyObject) {
        itemListArray.append(item.text!)
        item.text = ""
        toDoListTable.reloadData()
        NSUserDefaults.standardUserDefaults().setObject(itemListArray, forKey: "itemListArray")
    }
    
    @IBOutlet var toDoListTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Look for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        //If there is no permanent data saved
        if NSUserDefaults.standardUserDefaults().objectForKey("itemListArray") != nil {
            //Save our data to permanent memory
            itemListArray = NSUserDefaults.standardUserDefaults().objectForKey("itemListArray") as! [String]
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemListArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Items")
        cell.textLabel?.text=itemListArray[indexPath.row]
        return cell
    }
    override func viewDidAppear(animated: Bool) {
        toDoListTable.reloadData()
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        //if we left swipe to delete
        if editingStyle == UITableViewCellEditingStyle.Delete {
            //Delete the item from the array
            itemListArray.removeAtIndex(indexPath.row)
            //Save latest changes to permanent memory
            NSUserDefaults.standardUserDefaults().setObject(itemListArray, forKey: "itemListArray")
            //Update the table to remove the recently deleted item
            toDoListTable.reloadData()
        }
    }
    
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textfield:UITextField!)-> Bool {
        item.resignFirstResponder()
        return true
    }

}