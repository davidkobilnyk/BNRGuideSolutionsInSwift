//
//  BNRHypnosisViewController.swift
//  HypnoNerd
//
//  Created by David Kobilnyk on 7/7/14.
//  Copyright (c) 2014 David Kobilnyk. All rights reserved.
//

import UIKit

class BNRHypnosisViewController: UIViewController {
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
        
        // Set it as *the* view of this view controller
        self.view = backgroundView
    }
    
    override func viewDidLoad() {
        // Always call the super implementation of viewDidLoad
        super.viewDidLoad()
        
        println("BNRHypnosisViewController loaded its view")
    }
}