//
//  NewsEntity.swift
//  TinkoffNewsApiTestProject
//
//  Created by Александр Кузяев on 19.07.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import Foundation
import CoreData

@objc(NewsEntity)
final class NewsEntity: BaseEntity {

    // MARK: - Constants

    private enum Constants {
        enum Keys {
            static let id = "id"
            static let text = "text"
            static let publicationDate = "publicationDate"
            static let milliseconds = "milliseconds"
        }
    }

    // MARK: - Public Methods

    // Updates or creates NewsEntity object
    static func new(dictionary: [String: AnyObject]) -> NewsEntity? {
        let context = CoreDataStack.instance.persistentContainer.viewContext

        guard
            let id = dictionary[Constants.Keys.id] as? String,
            let text = dictionary[Constants.Keys.text] as? String
        else {
            return nil
        }

        if let news = NewsEntity.findById(id: id) as? NewsEntity {
            // update existing entity
            news.title = text
            return news
        } else {
            // create new entity
            guard let newsEntity = NSEntityDescription.insertNewObject(forEntityName: NewsEntity.className, into: context) as? NewsEntity else {
                return nil
            }
            newsEntity.id = id
            newsEntity.title = text
            if  let publicationDate = dictionary[Constants.Keys.publicationDate] as? [String: AnyObject],
                let milliseconds = publicationDate[Constants.Keys.milliseconds] as? Double {
                newsEntity.milliseconds = milliseconds
            }
            return newsEntity
        }
    }

    func increaseCounter() {
        counter = counter + 1
        CoreDataStack.instance.saveContext()
    }
}
