//
//  NewsModel.swift
//  TinkoffNewsApiTestProject
//
//  Created by Александр Кузяев on 19.07.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import Foundation
import CoreData

@objc(News)
class News: BaseEntity { }

extension News {
    
    // Updates or creates News object
    static func new(dictionary: [String: AnyObject]) -> News? {
        let context = CoreDataStack.instance.persistentContainer.viewContext
        
        if let id = dictionary["id"] as? String,
            let text = dictionary["text"] as? String {
            if let news = News.findById(id: id) as? News {
                news.title = text
            } else {
                if let newsEntity = NSEntityDescription.insertNewObject(forEntityName: "News", into: context) as? News {
                    newsEntity.id = id
                    newsEntity.title = text
                    if let publicationDate = dictionary["publicationDate"] as? [String: AnyObject] {
                        if let milliseconds = publicationDate["milliseconds"] as? Double {
                            newsEntity.milliseconds = milliseconds
                        }
                    }
                    return newsEntity
                }
            }
        }
        return nil
    }
    
    func increaseCounter() {
        counter = counter + 1
        CoreDataStack.instance.saveContext()
    }
}
