//
//  BNRDetailViewController.swift
//  HomePwner
//
//  Created by David Kobilnyk on 7/20/14.
//  Copyright (c) 2014 David Kobilnyk. All rights reserved.
//

import Foundation
import UIKit

class BNRDetailViewController: UIViewController,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate,
    UITextFieldDelegate {
    
    var item: BNRItem? = nil
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var serialNumberField: UITextField!
    @IBOutlet var valueField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var toolbar: UIToolbar!
    
    override init() {
        super.init(nibName: "BNRDetailViewController", bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder!) {
        fatalError("NSCoding not supported")
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
                    if _dateFormatter == nil {
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
            
            let itemKey = self.item!.itemKey
            let imageToDisplay = BNRImageStore.sharedStore.imageForKey(itemKey)
            
            // Use that image to put on the screen in imageView
            self.imageView.image = imageToDisplay
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
    
    @IBAction func takePicture(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        
        // If the device ahs a camera, take a picture, otherwise,
        // just pick from the photo library
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            imagePicker.sourceType = .Camera
        } else {
            imagePicker.sourceType = .PhotoLibrary
        }
        
        imagePicker.delegate = self
        
        // Place image picker on the screen
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func backgroundTapped(sender: UIView) {
        self.view.endEditing(true)
    }
    
    func imagePickerController(picker: UIImagePickerController!,
        didFinishPickingMediaWithInfo info: [NSObject : AnyObject]!) {
            
        let oldKey = self.item!.itemKey
        
        // Delete the old image
        BNRImageStore.sharedStore.deleteImageForKey(oldKey)

        // Get picked image from info dictionary
        let image = info[UIImagePickerControllerOriginalImage] as UIImage?
        
        // Store the image in the BNRImageStore for this key
        BNRImageStore.sharedStore.setImage(image, forKey: self.item!.itemKey)
        
        // Put that image onto the screen in our image view
        self.imageView.image = image
        
        // Take image picker off the screen -
        // you must call this dismiss method
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
