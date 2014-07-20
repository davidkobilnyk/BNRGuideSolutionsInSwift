//
//  BNRItemStore.swift
//  HomePwner
//
//  Created by David Kobilnyk on 7/8/14.
//  Copyright (c) 2014 David Kobilnyk. All rights reserved.
//

// For a discussion of the singleton pattern in Swift,
// see https://github.com/hpique/SwiftSingleton/blob/master/README.md
class BNRItemStore {
    class var sharedStore: BNRItemStore {
        struct Singleton {
            static let singleInstance: BNRItemStore = BNRItemStore()
        }
        return Singleton.singleInstance
    }
    
    var allItems = [BNRItem]()
    
    func createItem() -> BNRItem {
        let item = BNRItem.randomItem()
        allItems += item
        return item
    }
    
    func removeItem(item: BNRItem) {
        // Filter down to objects that do not have the same object
        // reference as item. The !== operator compares the object
        // references of the two objects.
        allItems = allItems.filter({$0 !== item})
    }
    
    func moveItemAtIndex(fromIndex: Int, toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        // Get pointer to object being moved so you can re-insert it
        var item = allItems[fromIndex]
        
        // Remove item from array
        allItems.removeAtIndex(fromIndex)
        
        // Insert item in array at new location
        allItems.insert(item, atIndex: toIndex)
    }
}
