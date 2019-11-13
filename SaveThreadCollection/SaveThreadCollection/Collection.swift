//
//  Collection.swift
//  SaveThreadCollection
//
//  Created by Давид on 11/11/2019.
//  Copyright © 2019 David. All rights reserved.
//

import Foundation

class Collection {
    
    private var collection = [0]
    
    private let concurrentQueue = DispatchQueue(label: "com.collection.barrier",
                                                qos: .unspecified,
                                                attributes: .concurrent,
                                                autoreleaseFrequency: .never,
                                                target: nil)
    
    func addNewValue() {
        concurrentQueue.async(flags: .barrier) {
            let randomInt = Int.random(in: 1...200)
            self.collection.append(randomInt)
            print("Barrier did set \(randomInt) \n\(self.collection)")
        }
    }
    
    func removeValue() {
        concurrentQueue.sync {
            let index = self.collection.count
            let randomValueToDelete = Int.random(in: 0..<index)
            let deletedValue = self.collection.remove(at: randomValueToDelete)
            print("Count of numbers in array = \(index). Index to delete = \(randomValueToDelete)")
            print("deleted value = \(deletedValue)")
        }
    }
}
