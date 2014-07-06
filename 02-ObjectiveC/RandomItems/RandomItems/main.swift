//
//  main.swift
//  RandomItems
//
//  Created by David Kobilnyk on 7/5/14.
//  Copyright (c) 2014 David Kobilnyk. All rights reserved.
//

import Foundation

items = []
for _ in 0..10 {
    let item = BNRItem.randomItem()
    items += item
}

for item in items {
    print(item)
}