//
//  BNRItem.swift
//  RandomItems
//
//  Created by David Kobilnyk on 7/5/14.
//  Copyright (c) 2014 David Kobilnyk. All rights reserved.
//

import Foundation

class BNRItem {
    var itemName: String
    var serialNumber: String
    var valueInDollars: Int
    var dateCreated: NSDate
    var description: String {
        return "\(self.itemName) (\(self.serialNumber)): Worth $\(self.valueInDollars), recorded on \(self.dateCreated)"
    }
    
    class func randomItem() {
        
        // Create an immutable array of three adjectives
        let randomAdjectiveList = ["Fluffy", "Rusty", "Shiny"]
        
        // Create an immutable array of three nouns
        let randomNounList = ["Bear", "Spork", "Mac"]
        
        // Get the index of a random adjective/noun from the lists
        // Note: The % operator, called the modulo operator, gives
        // you the remainder. So adjectiveIndex is a random number
        // from 0 to 2 inclusive.
        // Swift requires % arguments to be the same type. arc4random returns a UInt32.
        let adjectiveIndex = Int(arc4random()) % randomAdjectiveList.count
        let nounIndex = Int(arc4random()) % randomNounList.count
        
        let randomName = randomAdjectiveList[adjectiveIndex] + " " + randomNounList[nounIndex]
        
        let randomValue = Int(arc4random()) % 100
        
        let randomSerialNumber = ("0" + Int(arc4random()) % 10) +
            ("A" + Int(arc4random()) % 26) +
            ("0" + Int(arc4random()) % 10) +
            ("A" + Int(arc4random()) % 26) +
            ("0" + Int(arc4random()) % 10)
        
    }
    
    init(itemName: String, valueInDollars: Int, serialNumber: String) {
        self.itemName = itemName
        self.serialNumber = serialNumber
        self.valueInDollars = valueInDollars
        self.dateCreated = NSDate()
    }
    
    init(itemName: String) {
        self.init(itemName: itemName, valueInDollars: 0, serialNumber: "")
    }
    
    init() {
        self.init(itemName: "Item")
    }
}