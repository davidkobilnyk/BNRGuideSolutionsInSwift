//
//  BNRImageStore.swift
//  HomePwner
//
//  Created by David Kobilnyk on 7/21/14.
//  Copyright (c) 2014 David Kobilnyk. All rights reserved.
//

import Foundation
import UIKit

class BNRImageStore {
    class var sharedStore: BNRImageStore {
        struct Singleton {
            static let singleInstance: BNRImageStore = BNRImageStore()
        }
        return Singleton.singleInstance
    }
    
    var dictionary = [String: UIImage]()
    
    func setImage(image: UIImage?, forKey key:String) {
        dictionary[key] = image
        // Note that a dictionary can take an optional type even if its value type is non-optional.
        // e.g., UIImage? even though its type is [String: UIImage] not [String: UIImage?]
    }
    
    func imageForKey(key: String) -> UIImage? {
        return dictionary[key]
    }
    
    func deleteImageForKey(key: String) {
        // In Swift, we don't need to check if key is nil since we made key a non-optional type
        dictionary.removeValueForKey(key)
    }
}