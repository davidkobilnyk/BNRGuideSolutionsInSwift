//
//  BNRItemsViewController.swift
//  HomePwner
//
//  Created by David Kobilnyk on 7/8/14.
//  Copyright (c) 2014 David Kobilnyk. All rights reserved.
//

import UIKit

class BNRItemsViewController: UITableViewController {
    
    let itemStore = BNRItemStore()
    // Declaring itemStore here because class variables are not supported yet.
    // See BNRItemStore for more info.
    
    // Need to add this init in in Swift, or you get "fatal error: use of unimplemented initializer 'init(nibName:bundle:)' for class"
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    init() {
        super.init(style: UITableViewStyle.Plain)
        for _ in 0..<5 {
            itemStore.createItem()
        }
        println("sizeof(Int) = \(sizeof(Int))")
    }
    
    convenience init(style: UITableViewStyle) {
        self.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use .self to get the class. It's equivalent to [UITableViewCell class] in Objective-C.
        tableView!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    }
    
    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int)->Int {
        return itemStore.allItems.count
    }
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        // Get a new or recycled cell
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell") as UITableViewCell
        
        // Set the text on the cell with the description of the item
        // that is at the nth index of items, where n = row this cell
        // will appear in on the tableview
        
        let item = itemStore.allItems[indexPath.row]
        
        cell.textLabel.text = item.description
        
        return cell
    }
}

