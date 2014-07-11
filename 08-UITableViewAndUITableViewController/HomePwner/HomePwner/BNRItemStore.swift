//
//  BNRItemStore.swift
//  HomePwner
//
//  Created by David Kobilnyk on 7/8/14.
//  Copyright (c) 2014 David Kobilnyk. All rights reserved.
//

class BNRItemStore {
    var allItems: [BNRItem] = []
    
//    class let sharedStore = BNRItemStore()
    // Unfortunately, "Class variables not yet supported"
    
    func createItem() -> BNRItem {
        let item = BNRItem.randomItem()
        allItems += item
        return item
    }
}