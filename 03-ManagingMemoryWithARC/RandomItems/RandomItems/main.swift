//
//  main.swift
//  RandomItems
//
//  Created by David Kobilnyk on 7/5/14.
//  Copyright (c) 2014 David Kobilnyk. All rights reserved.
//

import Foundation

// Create a mutable array object
var items: [BNRItem?]? = []

var backpack: BNRItem? = BNRItem(itemName: "Backpack")
// need to get a variable unwrapped items; using ! gives us a constant/immutable unwrapped items
if var actualItems = items {
    actualItems += backpack
    // have to assign actualItems back to items because items wasn't actually modified
    items = actualItems
}

var calculator: BNRItem? = BNRItem(itemName: "Calculator")
if var actualItems = items {
    actualItems += calculator
    items = actualItems
}

backpack!.containedItem = calculator

backpack = nil
calculator = nil

if var actualItems = items {
    for item in actualItems {
        println(item!.description)
    }
}

// Destroy the mutable array object
println("Setting items to nil")
items = nil