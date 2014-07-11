//
//  main.swift
//  RandomItems
//
//  Created by David Kobilnyk on 7/5/14.
//  Copyright (c) 2014 David Kobilnyk. All rights reserved.
//

import Foundation

// Create a mutable array object
var items: [BNRItem?] = []

var backpack: BNRItem? = BNRItem(itemName: "Backpack")
items += backpack
// tried making items [BNRItem?]?, but then I get: "Immutable value of type '[BNRItem?]' only has mutating members named 'append'"

var calculator: BNRItem? = BNRItem(itemName: "Calculator")
items += calculator

backpack!.containedItem = calculator

backpack = nil
calculator = nil
// deinits are not getting called. hmmm ...

for item in items {
    println(item!.description)
}

// Destroy the mutable array object
println("Setting items to nil")
//items = nil