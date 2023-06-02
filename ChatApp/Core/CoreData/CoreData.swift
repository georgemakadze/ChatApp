//
//  CoreData.swift
//  ChatApp
//
//  Created by Giorgi Makadze on 18.05.2023.
//

import Foundation
import CoreData

class CoreData {
    let name : String
    
    init(name: String) {
        self.name = name
    }
    
    private lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.name)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                print("error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    lazy var managedContext: NSManagedObjectContext = self.container.viewContext
    
    func saveContext() {
        guard managedContext.hasChanges else { return }
        do {
            try managedContext.save()
        }catch let error as NSError {
            print("error \(error), \(error.userInfo)")
        }
        
    }
}





