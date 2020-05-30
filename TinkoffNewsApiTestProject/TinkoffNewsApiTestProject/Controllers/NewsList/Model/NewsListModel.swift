//
//  NewsListModel.swift
//  TinkoffNewsApiTestProject
//
//  Created by Александр Кузяев on 20.07.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import Foundation
import CoreData

final class NewsListModel: NSObject {

    // MARK: - Constants

    private enum Constants {
        enum Keys {
            static let milliseconds = "milliseconds"
        }
    }

    // MARK: - Public Properties

    weak var output: NewsListModelOutput?

    // MARK: - Private Properties

    private var datasource = [NewsEntity]()
    
    // MARK: - Initialization

    override init() {
        super.init()
        loadDatasource()
    }
}

// MARK: - NewsListModelInput

extension NewsListModel: NewsListModelInput {

    func handleData(data: [[String: AnyObject]]) {
        datasource = data.compactMap { NewsEntity.new(dictionary: $0) }
        CoreDataStack.instance.saveContext()
        loadDatasource()
        output?.dataChanged()
    }

    func increaseNewsCounter(news: NewsEntity) {
        news.increaseCounter()
        output?.dataChanged()
    }

    func getDatasource() -> [NewsEntity] {
        return datasource
    }
}

// MARK: - Private Methods

private extension NewsListModel {

    func loadDatasource() {
        let context = CoreDataStack.instance.getContext()
        let fetchRequest = NSFetchRequest<NewsEntity>(entityName: NewsEntity.className)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: Constants.Keys.milliseconds,
                                                         ascending: false)]
        do {
            let result = try context.fetch(fetchRequest)
            datasource = result
            output?.dataChanged()
        } catch let error as NSError {
            output?.showError(error: error.localizedDescription)
        }
    }
}
