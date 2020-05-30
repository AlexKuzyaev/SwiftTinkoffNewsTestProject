//
//  CoreDataStack.swift
//  TinkoffNewsApiTestProject
//
//  Created by Александр Кузяев on 21.07.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataStack: NSObject {

    // MARK: - Constants

    private enum Constants {
        static let containerName = "TinkoffNewsApiTestProject"
    }

    // MARK: - Properties
    
    static let instance = CoreDataStack()

    // MARK: - Initialization

    private override init() {}
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: Constants.containerName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func getContext() -> NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Core Data Saving support
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
