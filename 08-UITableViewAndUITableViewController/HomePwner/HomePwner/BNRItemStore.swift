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
}
