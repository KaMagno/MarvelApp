//
//  CoreDataManager.swift
//  XPInvestimento
//
//  Created by Kaique Magno Dos Santos on 23/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import UIKit
import CoreData

public class CoreDataManager<T:NSManagedObject> {
    
    // MARK: - Properties
    // MARK: Private
    
    // MARK: Public
    static var persistentContainer: NSPersistentContainer {
        /**
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "XPInvestimento")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                
                Logger.logError(in: CoreDataManager.self, message: "Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }
    
    // MARK: - Init
    init(){
        
    }
    
    // MARK: - Functions
    // MARK: Private
    
    
    // MARK: Public
    func get(filter:NSPredicate?) throws -> [T] {
        let fetchRequest = NSFetchRequest<T>(entityName: T.entity().managedObjectClassName)
        
        fetchRequest.predicate = filter
        
        return try fetchRequest.execute()
    }
    
    func exist(predicate:NSPredicate) -> Bool {
        let entityName = String.init(describing: T.self)
        let fetchRequest = NSFetchRequest<T>(entityName: entityName)
        do {
            let count = try CoreDataManager.persistentContainer.viewContext.count(for: fetchRequest)
            return count == 1
        } catch {
            return false
        }
    }
    
    /**
     Functions responsible to save the CoreData context
     */
    static func saveContext () {
        let context = CoreDataManager.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                Logger.logError(in: self, message: "Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

