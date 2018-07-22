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
    
    class func primaryKey() -> String { return "id" }
    
    class var className: String {
        return String(describing: self.self)
    }
}

//MARK: Contexts

var mainContext: NSManagedObjectContext {
    return CoreDataStack.instance.getContext()
}

extension BaseEntity {
    
    class func findById<T: BaseEntity>(id: String) -> T? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: className)
        fetchRequest.predicate = NSPredicate(format: "\(primaryKey()) = %@", id)
        
        if let first = try? mainContext.fetch(fetchRequest).first as? T {
            return first
        }
        
        return nil
    }
}


