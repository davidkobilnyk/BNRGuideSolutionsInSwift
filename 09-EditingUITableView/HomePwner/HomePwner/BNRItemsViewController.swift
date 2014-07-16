//
//  BNRItemsViewController.swift
//  HomePwner
//
//  Created by David Kobilnyk on 7/8/14.
//  Copyright (c) 2014 David Kobilnyk. All rights reserved.
//

import UIKit

class BNRItemsViewController: UITableViewController {
    
    @IBOutlet var headerView: UIView
    
    // Need to add this init in in Swift, or you get "fatal error: use of unimplemented initializer 'init(nibName:bundle:)' for class"
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    init() {
        super.init(style: UITableViewStyle.Plain)
    }
    
    convenience init(style: UITableViewStyle) {
        self.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use .self to get the class. It's equivalent to [UITableViewCell class] in Objective-C.
        tableView!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        
        if !self.headerView {
            // Load HeaderView.xib
            NSBundle.mainBundle().loadNibNamed("HeaderView", owner: self, options: nil)
        }
        
        let header: UIView = self.headerView
        tableView.tableHeaderView = header
    }
    
    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int)->Int {
        return BNRItemStore.sharedStore.allItems.count
    }
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        // Get a new or recycled cell
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell") as UITableViewCell
        
        // Set the text on the cell with the description of the item
        // that is at the nth index of items, where n = row this cell
        // will appear in on the tableview
        
        let item = BNRItemStore.sharedStore.allItems[indexPath.row]
        
        cell.textLabel.text = item.description
        
        return cell
    }
    
    override func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        // If the table view is asking to commit a delete command...
        if (editingStyle == .Delete) {
            var items = BNRItemStore.sharedStore.allItems
            var item = items[indexPath.row]
            BNRItemStore.sharedStore.removeItem(item)
            
            // Also remove that row from the table view with an animation
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    override func tableView(tableView: UITableView!, moveRowAtIndexPath sourceIndexPath: NSIndexPath!, toIndexPath destinationIndexPath: NSIndexPath!) {
        BNRItemStore.sharedStore.moveItemAtIndex(sourceIndexPath.row, toIndex: destinationIndexPath.row)
    }
    
    @IBAction func addNewItem(sender: UIButton) {
        // Create a new BNRItem and add it to the store
        var newItem = BNRItemStore.sharedStore.createItem()

        // Figure out where that item is in the array
        var lastRow: Int = 0
        for i in 0..<BNRItemStore.sharedStore.allItems.count {
            if BNRItemStore.sharedStore.allItems[i] === newItem {
                lastRow = i
                break
            }
        } // I wonder why BNR does it like this -- searching through the array for the new
          // element instead of just using count-1 for lastRow
        
        var indexPath = NSIndexPath(forRow: lastRow, inSection: 0)

        // Insert this new row into the table.
        tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Top)
    }
    
    @IBAction func toggleEditingMode(sender: UIButton) {
        // If you are currently in editing mode...
        if editing {
            // Change text of button to inform user of state
            sender.setTitle("Edit", forState: .Normal)
            
            // Turn off editing mode
            setEditing(false, animated: true)
        } else {
            // Change tet of button to inform user of state
            sender.setTitle("Done", forState: .Normal)
            
            // Enter editing mode
            setEditing(true, animated: true)
        }
    }
}

