//
//  CoreDataManager.swift
//  CoreData-Test
//
//  Created by Kaique Magno Dos Santos on 26/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import UIKit
import CoreData

public class CoreDataManager<T:NSManagedObject>:NSObject {
    
    // MARK: - Properties
    // MARK: Private
    private var modelName = "XPInvestimento"
    private(set) lazy var managedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        
        return managedObjectContext
    }()
    
    private lazy var managedObjectModel: NSManagedObjectModel = {
        guard let modelURL = Bundle.main.url(forResource: self.modelName, withExtension: "momd") else {
            fatalError("Unable to Find Data Model")
        }
        
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Unable to Load Data Model")
        }
        
        return managedObjectModel
    }()
    
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        
        let fileManager = FileManager.default
        let storeName = "\(self.modelName).sqlite"
        
        let documentsDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        let persistentStoreURL = documentsDirectoryURL.appendingPathComponent(storeName)
        
        do {
            /*
             - NSInferMappingModelAutomaticallyOption: If the value of this key is set to true, Core Data attempts to infer the mapping model for the migration based on the data model versions of the data model.
             - NSMigratePersistentStoresAutomaticallyOption: By setting the value of this key to true, we tell Core Data to automatically perform a migration if it detects an incompatibility.
             */
            let options = [NSInferMappingModelAutomaticallyOption:true,
                           NSMigratePersistentStoresAutomaticallyOption:true]
            
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                                              configurationName: nil,
                                                              at: persistentStoreURL,
                                                              options: nil)
        } catch {
            fatalError("Unable to Load Persistent Store")
        }
        
        return persistentStoreCoordinator
    }()
    
    // MARK: - Init
    override init(){
        super.init()
    }
    
    // MARK: - Functions
    // MARK: Private
    
    
    // MARK: Public
    func get(filter:NSPredicate? = nil) throws -> [T] {
        let entityName = String(describing: T.self)
        let fetchRequest = NSFetchRequest   <T>(entityName: entityName)
        
        return try self.managedObjectContext.fetch(fetchRequest)
    }
    
    func exist(predicate:NSPredicate) -> Bool {
        let entityName = String.init(describing: T.self)
        let fetchRequest = NSFetchRequest<T>(entityName: entityName)
        fetchRequest.predicate = predicate
        do {
            let count = try self.managedObjectContext.count(for: fetchRequest)
            return count >= 1
        } catch {
            return false
        }
    }
    
    
    /// Insert an NSManagedObject in the PersistentStore
    ///
    /// - Parameters:
    ///   - object: object which will be insert in the PersistentStore.
    ///   - predicate: the predicate which must be not fulfill to insert the object. Default value is `nil`
    func insert(object:T, predicate:NSPredicate = NSPredicate()) {
        let context = self.managedObjectContext
        
        if self.exist(predicate: predicate) == false {
            context.insert(object)
        }
        
    }
    
    func delete(object:T) {
        let context = self.managedObjectContext
        context.delete(object)
    }
    
    func saveContext () {
        let context = self.managedObjectContext
        if context.hasChanges {
            do {
                try context.save()
                print("Save successfully")
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}


