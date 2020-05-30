//
//  BaseEntity.swift
//  TinkoffNewsApiTestProject
//
//  Created by Александр Кузяев on 22.07.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import Foundation
import CoreData

class BaseEntity: NSManagedObject {

    // MARK: - Constants

    private enum Constants {
        static let id = "id"
    }

    // MARK: - Private Properties

    private static var mainContext: NSManagedObjectContext {
        return CoreDataStack.instance.getContext()
    }

    // MARK: - Class Methods

    class func primaryKey() -> String { return Constants.id }

    class func findById<T: BaseEntity>(id: String) -> T? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: className)
        fetchRequest.predicate = NSPredicate(format: "\(primaryKey()) = %@", id)

        guard let first = try? mainContext.fetch(fetchRequest).first as? T else {
            return nil
        }

        return first
    }

}


