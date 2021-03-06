//
//  BNRItem.swift
//  HomePwner
//
//  Created by David Kobilnyk on 7/8/14.
//  Copyright (c) 2014 David Kobilnyk. All rights reserved.
//

import UIKit

class BNRItem {
    // Had to change these variables from let to var because they are set directly
    // in BNRDetailViewController.swift
    var itemName: String
    var serialNumber: String
    var valueInDollars: Int
    let dateCreated: NSDate // Leave this as a let since it never needs to change
    var itemKey: String
    var description: String { // Computed property instead of method
        return "\(self.itemName) (\(self.serialNumber)): Worth $\(self.valueInDollars), recorded on \(self.dateCreated)"
    }
    
    class func randomItem() -> BNRItem {
        
        // Define helper functions for creating a random serial number.
        // Interestingly, generating random characters seems more complicated
        //in Swift than in Objective-C. Sticking closer to Objective-C's way
        //didn't work for me and in fact caused Xcode to halt ("Building..."
        //forever). But I don't know -- maybe there's an easier way.
        func randomLetter() -> String {
            // Originally I coded a more generic function that took a starting
            //character and number of characters. But oddly UnicodeScalarValue
            //is only working on literals for me -- not on variables.
            let startingUnicodeScalarValue = UnicodeScalarValue("A")
            let numberOfLetters = 26
            let randomUnicodeScalarValue = Int(startingUnicodeScalarValue) + Int(rand()) % numberOfLetters
            return String(UnicodeScalar(randomUnicodeScalarValue))
        }
        func randomDigit() -> String {
            let startingUnicodeScalarValue = UnicodeScalarValue("0")
            let numberOfPossibleDigits = 10
            let randomUnicodeScalarValue = Int(startingUnicodeScalarValue) + Int(rand()) % numberOfPossibleDigits
            return String(UnicodeScalar(randomUnicodeScalarValue))
        }
        
        // Create an array of three adjectives
        let randomAdjectiveList = ["Fluffy", "Rusty", "Shiny"]
        // Create an array of three nouns
        let randomNounList = ["Bear", "Spork", "Mac"]
        // Get the index of a random adjective/noun from the lists
        // Note: The % operator, called the modulo operator, gives
        // you the remainder. So adjectiveIndex is a random number
        // from 0 to 2 inclusive.
        let adjectiveIndex = Int(rand()) % randomAdjectiveList.count
        let nounIndex = Int(rand()) % randomNounList.count
        
        let randomName = randomAdjectiveList[adjectiveIndex] + " " + randomNounList[nounIndex]
        let randomValue = Int(rand()) % 100
        
        let randomSerialNumber = randomLetter() + randomDigit() + randomLetter() + randomDigit() + randomLetter()

        let newItem = BNRItem(itemName: randomName, valueInDollars: randomValue, serialNumber: randomSerialNumber)
        return newItem
    }

    init(itemName: String, valueInDollars: Int, serialNumber: String) {
        self.itemName = itemName
        self.serialNumber = serialNumber
        self.valueInDollars = valueInDollars
        self.dateCreated = NSDate()
        
        // Create a NSUUID object - and get its string representation
        let uuid = NSUUID()
        let key = uuid.UUIDString
        itemKey = key
    }
    
    convenience init(itemName: String) {
        self.init(itemName: itemName, valueInDollars: 0, serialNumber: "")
    }
    
    convenience init() {
        self.init(itemName: "Item")
    }
    
    deinit {
        println("Destroyed: \(self)")
    }
}
