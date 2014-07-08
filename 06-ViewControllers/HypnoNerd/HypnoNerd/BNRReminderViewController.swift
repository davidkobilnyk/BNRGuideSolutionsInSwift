//
//  BNRReminderViewController.swift
//  HypnoNerd
//
//  Created by David Kobilnyk on 7/7/14.
//  Copyright (c) 2014 David Kobilnyk. All rights reserved.
//

import UIKit

class BNRReminderViewController: UIViewController {
    @IBOutlet var datePicker: UIDatePicker
    
    init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        // Set the tab bar item's title
        self.tabBarItem.title = "Reminder";
        
        // Create a UIImage from a file
        // This will use Time@2x.png on retina display devices
        let image = UIImage(named: "Time.png")
        
        // Put that image on the tab bar item
        self.tabBarItem.image = image;
    }
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("BNRReminderViewController loaded its view")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.datePicker.minimumDate = NSDate(timeIntervalSinceNow: 60)
    }
    
    @IBAction func addReminder(sender: AnyObject) {
        let date = self.datePicker.date
        println("Setting a reminder for \(date)")
        
        let note = UILocalNotification()
        note.alertBody = "Hypnotize me!"
        note.fireDate = date
        
        UIApplication.sharedApplication().scheduleLocalNotification(note)
    }
}