//
//  BNRDetailViewController.swift
//  HomePwner
//
//  Created by David Kobilnyk on 7/20/14.
//  Copyright (c) 2014 David Kobilnyk. All rights reserved.
//

import Foundation
import UIKit

class BNRDetailViewController: UIViewController {
    var item: BNRItem? = nil
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var serialNumberField: UITextField!
    @IBOutlet var valueField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let item = self.item {
            self.nameField.text = item.itemName
            self.serialNumberField.text = item.serialNumber
            self.valueField.text = "\(item.valueInDollars)"
            
            // You need a NSDateFormatter that will turn a date into a simple date string
            // Objective-C: static NSDateFormatter *dateFormatter;
            struct StaticDateFormatter {
                // This is probably overkill, but this code is a way to implement a static
                // variable in the middle of a function. class variables aren't available yet.
                static var _dateFormatter: NSDateFormatter?
                static var dateFormatter: NSDateFormatter {
                if !_dateFormatter {
                    _dateFormatter = NSDateFormatter()
                    // _dateFormatter is guaranteed to be non-nil here because we just
                    // initialized it. So we can use ! to force unwrap it.
                    _dateFormatter!.dateStyle = .MediumStyle
                    _dateFormatter!.timeStyle = .NoStyle
                    }
                    // _dateFormatter is now guaranteed to be non-nil, either because it
                    // was already non-nil, or because we just initialized it.
                    return _dateFormatter!
                }
                
            }
            let dateFormatter = StaticDateFormatter.dateFormatter
            
            // Use filtered NSDate object to set dateLabel contents
            self.dateLabel.text = dateFormatter.stringFromDate(item.dateCreated)
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Clear first responder
        self.view.endEditing(true)
        
        self.item!.itemName = ""
        
        // "Save" changes to item
        if var item = self.item {
            item.itemName = self.nameField.text;
            item.serialNumber = self.serialNumberField.text;
            // Let's play it safe and check if the valueField actually has an int.
            if let integer = self.valueField.text.toInt() {
                item.valueInDollars = integer
            }
        }
    }
}
