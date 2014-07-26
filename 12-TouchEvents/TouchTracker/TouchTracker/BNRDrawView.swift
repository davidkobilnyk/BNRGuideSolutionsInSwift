//
//  BNRDrawView.swift
//  TouchTracker
//
//  Created by David Kobilnyk on 7/26/14.
//  Copyright (c) 2014 David Kobilnyk. All rights reserved.
//

import Foundation
import UIKit

class BNRDrawView: UIView {
    var linesInProgress = [NSValue: BNRLine]()
    var finishedLines = [BNRLine]()
    
    init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.grayColor()
        multipleTouchEnabled = true
    }
    
    func strokeLine(line: BNRLine) {
        let bp = UIBezierPath()
        bp.lineWidth = 10
        bp.lineCapStyle = kCGLineCapRound
        
        bp.moveToPoint(line.begin)
        bp.addLineToPoint(line.end)
        bp.stroke()
    }
    
    override func drawRect(rect: CGRect) {
        // Draw finished lines in black
        UIColor.blackColor().set()
        for line in finishedLines {
            strokeLine(line)
        }
        
        UIColor.redColor().set()
        for (key, line) in linesInProgress {
            strokeLine(line)
        }
    }
    
    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
        // Let's put in a log statement to see the order of events
        NSLog("%@", __FUNCTION__) // no _cmd in Swift; use __FUNCTION__ instead
        
        for t in touches {
            let location = t.locationInView(self)
            
            let line = BNRLine()
            line.begin = location
            line.end = location
            
            let key = NSValue(nonretainedObject: t)
            linesInProgress[key] = line
        }
        
        setNeedsDisplay()
    }
    
    override func touchesMoved(touches: NSSet!, withEvent event: UIEvent!) {
        // Let's put in a log statement to see the order of events
        NSLog("%@", __FUNCTION__)
        
        for t in touches {
            let key = NSValue(nonretainedObject: t)
            
            if let line = linesInProgress[key] {
                line.end = t.locationInView(self)
            }
        }
        
        setNeedsDisplay()
    }
    
    override func touchesEnded(touches: NSSet!, withEvent event: UIEvent!) {
        // Let's put in a log statement to see the order of events
        NSLog("%@", __FUNCTION__)
        
        for t in touches {
            let key = NSValue(nonretainedObject: t)
            
            if let line = linesInProgress[key] {
                finishedLines += line
            }
            linesInProgress.removeValueForKey(key)
        }
        
        setNeedsDisplay()
    }
    
    override func touchesCancelled(touches: NSSet!, withEvent event: UIEvent!) {
        // Let's put in a log statement to see the order of events
        NSLog("%@", __FUNCTION__)
        
        for t in touches {
            let key = NSValue(nonretainedObject: t)
            linesInProgress.removeValueForKey(key)
        }
        
        setNeedsDisplay()
    }
}