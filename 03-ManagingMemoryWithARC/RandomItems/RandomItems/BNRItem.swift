//
//  BNRItem.swift
//  RandomItems
//
//  Created by David Kobilnyk on 7/5/14.
//  Copyright (c) 2014 David Kobilnyk. All rights reserved.
//

import Foundation

class BNRItem {
    var containedItem: BNRItem? = nil {
        // willSet and didSet are Swift property observers that get called
        //when the property's value changes
        didSet { // use didSet property observer instead of setContainedItem
            if let definiteContainedItem = containedItem {
                definiteContainedItem.container = self
            }
        }
    }
    weak var container: BNRItem?
    
    let itemName: String
    let serialNumber: String
    let valueInDollars: Int
    let dateCreated: NSDate
    var description: String { // Swift Computed property instead of method
        return "\(self.itemName) (\(self.serialNumber)): Worth $\(self.valueInDollars), recorded on \(self.dateCreated)"
    }
    
    class func randomItem() -> BNRItem {
        
        // Define helper functions for creating a random serial number.
        // Interestingly, generating random characters seems more complicated
        //in Swift than in Objective-C. Sticking closer to Objective-C's way
        //didn't work for me and in fact caused Xcode to halt ("Building..."
        //forever). But I don't know -- maybe there's an easier way.
        func randomLetter() -> Character {
            // Originally I coded a more generic function that took a starting
            //character and number of characters. But oddly UnicodeScalarValue
            //is only working on literals for me -- not on variables.
            let startingUnicodeScalarValue = UnicodeScalarValue("A")
            let numberOfLetters = 26
            let randomUnicodeScalarValue = Int(startingUnicodeScalarValue) + Int(arc4random()) % numberOfLetters
            return Character(UnicodeScalar(randomUnicodeScalarValue))
        }
        func randomDigit() -> Character {
            let startingUnicodeScalarValue = UnicodeScalarValue("0")
            let numberOfPossibleDigits = 10
            let randomUnicodeScalarValue = Int(startingUnicodeScalarValue) + Int(arc4random()) % numberOfPossibleDigits
            return Character(UnicodeScalar(randomUnicodeScalarValue))
        }
        
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
        
        let randomSerialNumber = randomLetter() + randomDigit() + randomLetter() + randomDigit() + randomLetter()
        
        let newItem = BNRItem(itemName: randomName, valueInDollars: randomValue, serialNumber: randomSerialNumber)
        return newItem
        
    }
    
    init(itemName: String, valueInDollars: Int, serialNumber: String) {
        self.itemName = itemName
        self.serialNumber = serialNumber
        self.valueInDollars = valueInDollars
        self.dateCreated = NSDate()
    }
    
    convenience init(itemName: String) {
        self.init(itemName: itemName, valueInDollars: 0, serialNumber: "")
    }
    
    convenience init() {
        self.init(itemName: "Item")
    }
    
    deinit { // deinit doesn't seem to be getting called
        println("Destroyed: \(self.description)")
    }
}