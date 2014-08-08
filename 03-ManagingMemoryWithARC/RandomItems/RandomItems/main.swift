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
items?.append(backpack)
var calculator: BNRItem? = BNRItem(itemName: "Calculator")
items?.append(calculator)

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