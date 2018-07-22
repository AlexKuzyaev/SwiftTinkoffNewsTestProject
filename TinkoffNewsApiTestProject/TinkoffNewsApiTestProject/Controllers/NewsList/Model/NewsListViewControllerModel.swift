//
//  NewsListControllerModel.swift
//  TinkoffNewsApiTestProject
//
//  Created by Александр Кузяев on 20.07.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import Foundation
import CoreData
import UIKit

protocol  NewsListViewControllerModelDelegate: class {
    func dataChanged()
    func showError(error: String)
}

class NewsListViewControllerModel: NSObject {
    
    private var datasource = [News]()
    weak var delegate: NewsListViewControllerModelDelegate!
    
    // MARK: - Setup -
    
    func setup() {
        loadDatasource()
    }
    
    // MARK: - Load -
    
    private func loadDatasource() {
        self.fetchData()
    }
    
    private func fetchData() {
        let context = CoreDataStack.instance.getContext()
        let fetchRequest = NSFetchRequest<News>(entityName: "News")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "milliseconds", ascending: false)]
        
        do {
            let result = try context.fetch(fetchRequest)
            datasource = result
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            delegate?.showError(error: error.localizedDescription)
        }
    }
    
    // MARK: - Update -
    
    func handleData(data: [[String: AnyObject]]) {
        datasource = data.flatMap { News.new(dictionary: $0) }
        CoreDataStack.instance.saveContext()
        self.loadDatasource()
        self.delegate?.dataChanged()
    }
    
    func increaseNewsCounter(news: News) {
        news.increaseCounter()
        self.delegate?.dataChanged()
    }
    
    // MARK: - Access -
    
    func getDatasource() -> [News] {
        return datasource
    }
}
