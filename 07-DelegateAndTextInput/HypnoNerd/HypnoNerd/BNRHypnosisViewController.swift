//
//  BNRHypnosisViewController.swift
//  HypnoNerd
//
//  Created by David Kobilnyk on 7/7/14.
//  Copyright (c) 2014 David Kobilnyk. All rights reserved.
//

import UIKit

class BNRHypnosisViewController: UIViewController, UITextFieldDelegate {
    // ^ protocol is listed together with superclass, but superclass must be listed first
    init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        // Set the tab bar item's title
        self.tabBarItem.title = "Hypnotize"
        
        // Create a UIImage from a file
        // This will use Hypno@2x on retina display devices
        let image = UIImage(named: "Hypno.png")
        // "'imageNamed is unavailable: use object construction 'UIImage(named:)'"
        
        // Put that image on the tab bar item
        self.tabBarItem.image = image
    }
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    override func loadView()  {
        // Create a view
        let frame = UIScreen.mainScreen().bounds
        let backgroundView = BNRHypnosisView(frame: frame)
        
        let textFieldRect = CGRectMake(40, 70, 240, 30)
        let textField = UITextField(frame: textFieldRect)
        
        // Setting the border style on the text field will allow us to see it more easily
        textField.borderStyle = .RoundedRect // Swift infers UITextBorderStyle.RoundedRect
        textField.placeholder = "Hypnotize me"
        textField.returnKeyType = .Done // Swift infers UIReturnKeyType.Done
        backgroundView.addSubview(textField)
        
        textField.delegate = self
        
        // Set it as *the* view of this view controller
        self.view = backgroundView
    }
    
    override func viewDidLoad() {
        // Always call the super implementation of viewDidLoad
        super.viewDidLoad()
        
        println("BNRHypnosisViewController loaded its view")
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.drawHypnoticMessage(textField.text)
        
        textField.text = ""
        textField.resignFirstResponder()
        
        return true
    }
    
    func drawHypnoticMessage(message: NSString) {
        for _ in 0..<20 { // use _ since we don't need the value anywhere
            let messageLabel = UILabel()
            
            // Configure the label's colors and text
            messageLabel.backgroundColor = UIColor.clearColor()
            messageLabel.textColor = UIColor.whiteColor()
            messageLabel.text = message
            
            // This method resizes the label, which will be relative
            // to the text that it is displaying
            messageLabel.sizeToFit()
            
            // Get a random x value that fits within the hypnosis view's width
            let width = UInt32(self.view.bounds.size.width - messageLabel.bounds.size.width)
            let x = arc4random_uniform(width)
            
            // Get a random y value that fits within the hypnosis view's height
            let height = UInt32(self.view.bounds.size.height - messageLabel.bounds.size.height)
            let y = arc4random_uniform(height)
            
            // Update the label's frame
            var frame = messageLabel.frame
            frame.origin = CGPointMake(CGFloat(x), CGFloat(y));
            messageLabel.frame = frame
            
            // Add the label to the hierarchy
            self.view.addSubview(messageLabel)
            
            var motionEffect = UIInterpolatingMotionEffect(keyPath: "center.x", type: .TiltAlongHorizontalAxis)
            // Swift infers UIInterpolatingMotionEffectType.TiltAlongHorizontalAxis
            motionEffect.minimumRelativeValue = -25
            motionEffect.maximumRelativeValue = 25
            messageLabel.addMotionEffect(motionEffect)
            
            motionEffect = UIInterpolatingMotionEffect(keyPath: "center.y", type: .TiltAlongVerticalAxis)
            motionEffect.minimumRelativeValue = -25
            motionEffect.maximumRelativeValue = 25
            messageLabel.addMotionEffect(motionEffect)
        }
    }
}