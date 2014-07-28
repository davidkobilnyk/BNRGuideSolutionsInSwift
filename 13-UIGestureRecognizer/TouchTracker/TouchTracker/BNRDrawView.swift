//
//  BNRDrawView.swift
//  TouchTracker
//
//  Created by David Kobilnyk on 7/26/14.
//  Copyright (c) 2014 David Kobilnyk. All rights reserved.
//

import Foundation
import UIKit

class BNRDrawView: UIView, UIGestureRecognizerDelegate {
    // Can't appropriately initialize moveRecognizer before super.init because we
    // set target to self -- and self can't be used before super.init.
    // So we give moveRecognizer an optional type, but implicitly unwrap it because
    // we know it will be initialized by the end of init.
    let moveRecognizer: UIPanGestureRecognizer!
    var linesInProgress = [NSValue: BNRLine]()
    var finishedLines = [BNRLine]()
    
    weak var selectedLine: BNRLine?
    
    init(frame: CGRect) {
        
        super.init(frame: frame)
        
        backgroundColor = UIColor.grayColor()
        multipleTouchEnabled = true
        
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: "doubleTap:")
        doubleTapRecognizer.numberOfTapsRequired = 2
        doubleTapRecognizer.delaysTouchesBegan = true
        
        addGestureRecognizer(doubleTapRecognizer)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: "tap:")
        tapRecognizer.delaysTouchesBegan = true
        tapRecognizer.requireGestureRecognizerToFail(doubleTapRecognizer)
        addGestureRecognizer(tapRecognizer)
        
        let pressRecognizer = UILongPressGestureRecognizer(target: self, action: "longPress:")
        addGestureRecognizer(pressRecognizer)
        
        moveRecognizer = UIPanGestureRecognizer(target: self, action: "moveLine:")
        moveRecognizer.delegate = self
        moveRecognizer.cancelsTouchesInView = false
        addGestureRecognizer(moveRecognizer)
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    func strokeLine(line: BNRLine) {
        let bp = UIBezierPath()
        bp.lineWidth = 10
        bp.lineCapStyle = kCGLineCapRound
        
        bp.moveToPoint(line.begin)
        bp.addLineToPoint(line.end)
        bp.stroke()
    }
    
    func deleteLine(sender: AnyObject) {
        finishedLines = finishedLines.filter {$0 != self.selectedLine}
        selectedLine = nil
        setNeedsDisplay()
    }
    
    func moveLine(gr: UIPanGestureRecognizer) {
        // If we have not selected a line, we do not do anything here
        if var selectedLine = selectedLine {
            
            // When the pan recognizer changes its position...
            if gr.state == .Changed {
                // How far has the pan moved?
                let translation = gr.translationInView(self)
                
                // Add the translation to the current beginning and end points of the line
                var begin = selectedLine.begin
                var end = selectedLine.end
                begin.x += translation.x
                begin.y += translation.y
                end.x += translation.x
                end.y += translation.y
                
                // Set the new beginning and end points of the line
                selectedLine.begin = begin
                selectedLine.end = end
                
                // Redraw the screen
                setNeedsDisplay()
                
                gr.setTranslation(CGPointZero, inView: self)
            }
        }
    }
    
    override func drawRect(rect: CGRect) {
        // Draw finished lines in black
        UIColor.blackColor().set()
        for line in finishedLines {
            strokeLine(line)
        }
        
        UIColor.redColor().set()
        for (_, line) in linesInProgress {
            strokeLine(line)
        }
        
        if let selectedLine = selectedLine {
            UIColor.greenColor().set()
            strokeLine(selectedLine)
        }
    }
    
    func lineAtPoint(p: CGPoint) -> BNRLine? {
        // Find a line close to p
        for l in finishedLines {
            let start = l.begin
            let end = l.end
            
            // Check a few points on the line
            for var t: CGFloat = 0.0; t <= 1.0; t += 0.05 {
                let x = start.x + t * (end.x - start.x)
                let y = start.y + t * (end.y - start.y)
                
                // If the tapped point is within 20 points, let's return this line
                if (hypot(x - p.x, y - p.y) < 20.0) {
                    return l
                }
            }
        }
        
        // If nothing is close enough to the tapped point, then we did not select a line
        return nil
    }
    
    func longPress(gr: UIGestureRecognizer) {
        if gr.state == .Began {
            let point = gr.locationInView(self)
            selectedLine = lineAtPoint(point)
            
            if selectedLine {
                linesInProgress.removeAll(keepCapacity: true)
            }
        } else if gr.state == .Ended {
            selectedLine = nil
        }
        setNeedsDisplay()
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer!, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer!) -> Bool {
        if gestureRecognizer == moveRecognizer {
            return true
        }
        return false
    }
    
    func tap(gr: UITapGestureRecognizer) {
        println("Recognized tap")
        
        let point = gr.locationInView(self)
        selectedLine = lineAtPoint(point)
        
        if selectedLine {
            
            // Make ourselves the target of menu item action messages
            becomeFirstResponder()
            
            // Grab the menu controller
            let menu = UIMenuController.sharedMenuController()
            
            // Create a new "Delete" UIMenuItem
            let deleteItem = UIMenuItem(title: "Delete", action: "deleteLine:")
            
            menu.menuItems = [deleteItem]
            
            // Tell the menu where it should come from and show it
            menu.setTargetRect(CGRectMake(point.x, point.y, 2, 2), inView: self)
            menu.setMenuVisible(true, animated: true)
        } else {
            // Hide the menu if no line is selected
            UIMenuController.sharedMenuController().setMenuVisible(false, animated: true)
        }
        
        setNeedsDisplay()
    }
    
    func singleTap(gesture: UITapGestureRecognizer) {
        println("Recognized a single tap")
        
        let point = gesture.locationInView(self)
        
        // See if the user touched a line
        selectedLine = lineAtPoint(point)
        
        // Show a action menu bar when user selects a line
        if selectedLine {
            // Make ourselves the target of menu item action messages
            becomeFirstResponder()
            let menu = UIMenuController.sharedMenuController()
            let deleteItem = [UIMenuItem(title: "Delete", action: "deleteLine:")]
            menu.menuItems = deleteItem
            
            // Tell the menu where it should show itself
            menu.setTargetRect(CGRectMake(point.x, point.y, 2, 2), inView: self)
            menu.setMenuVisible(true, animated: true)
        }
        else {
            UIMenuController.sharedMenuController().setMenuVisible(false, animated: true)
        }
        
        setNeedsDisplay()
    }
    
    func doubleTap(gr: UITapGestureRecognizer) {
        println("Recognized Double Tap")
        linesInProgress.removeAll(keepCapacity: true)
        finishedLines.removeAll(keepCapacity: true)
        setNeedsDisplay()
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