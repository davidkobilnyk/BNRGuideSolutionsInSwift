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
    private(set) var allItems = [BNRItem]()
    
    class var sharedStore: BNRItemStore {
        struct Singleton {
            static let singleInstance: BNRItemStore = BNRItemStore()
        }
        return Singleton.singleInstance
    }
    
    // It's impossible to instantiate this class outside of this file
    private init() {}
    
    func createItem() -> BNRItem {
        let item = BNRItem.randomItem()
        allItems += [item]
        return item
    }
}
