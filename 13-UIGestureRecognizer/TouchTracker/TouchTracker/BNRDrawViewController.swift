//
//  BNRDrawViewController.swift
//  TouchTracker
//
//  Created by David Kobilnyk on 7/26/14.
//  Copyright (c) 2014 David Kobilnyk. All rights reserved.
//

import Foundation
import UIKit

class BNRDrawViewController: UIViewController {
    
    override func loadView() {
        view = BNRDrawView(frame: CGRectZero)
    }
}