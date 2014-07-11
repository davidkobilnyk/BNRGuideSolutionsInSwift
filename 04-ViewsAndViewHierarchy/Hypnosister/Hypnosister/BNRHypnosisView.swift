//
//  BNRHypnosisView.swift
//  Hypnosister
//
//  Created by David Kobilnyk on 7/5/14.
//  Copyright (c) 2014 David Kobilnyk. All rights reserved.
//

import UIKit

class BNRHypnosisView: UIView {
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
        var maxRadius = hypotf(Float(bounds.size.width), Float(bounds.size.height)) / 2.0
        
        let path = UIBezierPath()
        
        for var currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20 {
            path.moveToPoint(CGPointMake(center.x + CGFloat(currentRadius), center.y))
            
            path.addArcWithCenter(center, radius: CGFloat(currentRadius), startAngle: 0.0, endAngle: CGFloat(M_PI) * 2.0, clockwise: true)
        }
        
        // Configure line width to 10 points
        path.lineWidth = 10
        
        // Configure the drawing color to light gray
        UIColor.lightGrayColor().setStroke()
        
        // Draw the line!
        path.stroke()
    }
}

