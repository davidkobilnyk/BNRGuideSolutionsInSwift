//
//  BNRHypnosisView.swift
//  HypnoNerd
//
//  Created by David Kobilnyk on 7/7/14.
//  Copyright (c) 2014 David Kobilnyk. All rights reserved.
//

import UIKit

class BNRHypnosisView: UIView {
    var circleColor: UIColor = UIColor.lightGrayColor() {
    didSet { // didSet replaces the need for writing a custom setCircleColor (in obj-c)
        self.setNeedsDisplay()
    }
    }
    
    init(frame: CGRect) {
        super.init(frame: frame)
        // All BNRHypnosisViews start with a clear background color
        self.backgroundColor = UIColor.clearColor()
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        let bounds = self.bounds
        
        // Figure out the center of the bounds rectangle
        var center = CGPoint()
        center.x = bounds.origin.x + bounds.size.width / 2.0
        center.y = bounds.origin.y + bounds.size.height / 2.0
        
        // The largest circle will circumscribe the view
        var maxRadius = hypotf(bounds.size.width, bounds.size.height) / 2.0
        
        let path = UIBezierPath()
        
        for var currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20 {
            path.moveToPoint(CGPointMake(center.x + currentRadius, center.y))
            
            path.addArcWithCenter(center, radius: currentRadius, startAngle: 0.0, endAngle: Float(M_PI) * 2.0, clockwise: true)
        }
        
        // Configure line width to 10 points
        path.lineWidth = 10
        
        // Configure the drawing color
        self.circleColor.setStroke()
        
        // Draw the line!
        path.stroke()
    }
    
    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
        println("Touch began on \(self)")
        
        // Get 3 random numbers between 0 and 1
        func randomNumber() -> Float { return Float(arc4random() % 100) / 100.0 }
        let red = randomNumber()
        let green = randomNumber()
        let blue = randomNumber()
        
        let randomColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        // UIColor.colorWithRed "is unavailable: use object
        //construction 'UIColor(red:green:blue:alpha:)'"
        
        self.circleColor = randomColor
    }
}