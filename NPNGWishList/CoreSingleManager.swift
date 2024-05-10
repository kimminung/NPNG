//
//  CoreSingleManager.swift
//  NPNGWishList
//
//  Created by 민웅킴 on 5/3/24.
//

import Foundation
import CoreData

class CoreSingleManager {
    
    static let shared: CoreSingleManager = .init()
    
    // Create a persistent container as a lazy variable to defer instantiation until its first use.
    lazy var persistentContainer: NSPersistentContainer = {
        
        // Pass the data model filename to the container’s initializer.
        let container = NSPersistentContainer(name: "Product")
        
        // Load any persistent stores, which creates a store if none exists.
        container.loadPersistentStores { _, error in
            if let error {
                // Handle the error appropriately. However, it's useful to use
                // `fatalError(_:file:line:)` during development.
                fatalError("Failed to load persistent stores: \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    //외부에서 생성하지 못하도록 생성자에 private 걸어줌
    private init() { }
}
