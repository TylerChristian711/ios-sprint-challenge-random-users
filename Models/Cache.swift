//
//  Cache.swift
//  Random Users
//
//  Created by Lambda_School_Loaner_218 on 1/17/20.
//  Copyright © 2020 Erica Sadun. All rights reserved.
//

import Foundation

class Cache<Key: Hashable, Value> {
    private var cache = [Key : Value]()
    
    private var queue = DispatchQueue(label: "Random User")
    
    
    func cache(value: Value, key: Key) {
        queue.async {
            self.cache[key] = value
        }
    }
    
    func value(key: Key) -> Value? {
        return queue.sync {
            cache[key]
        }
    }
    
    func contains(_ key: Key) -> Bool {
        return queue.sync {
        cache.keys.contains(key)
        }
    }
}
