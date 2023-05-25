//
//  CoreDataManager.swift
//  ChatApp
//
//  Created by Giorgi Makadze on 18.05.2023.
//

import Foundation
import CoreData

class CoreDataManager: CoreData {
    
    
    func fetchObjects<Entity: NSManagedObject>(
        entityName: String,
        predicate: NSPredicate? = nil,
        sortDescriptors: [NSSortDescriptor]? = nil
    ) throws -> [Entity] {
        let fetchRequest = NSFetchRequest<Entity>(entityName: entityName)
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        
        do {
            let fetchedObjects = try managedContext.fetch(fetchRequest)
            return fetchedObjects
        } catch {
            throw error
        }
    }
    
    // MARK: - Storage Functions
    
    func createObject<Entity: NSManagedObject>(entityName: String) -> Entity {
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext)!
        let object = Entity(entity: entity, insertInto: managedContext)
        return object
    }
}
