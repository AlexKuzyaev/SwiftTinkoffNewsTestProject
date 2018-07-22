//
//  NewsListControllerPresenter.swift
//  TinkoffNewsApiTestProject
//
//  Created by Александр Кузяев on 20.07.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import Foundation

protocol NewsListViewControllerPresenterDelegate: class {
    func updateData()
    func showError(error: String)
    func showNewsDetail(newsId: String)
}

class NewsListViewControllerPresenter: NSObject {
    
    private let model = NewsListViewControllerModel()
    weak var delegate: NewsListViewControllerPresenterDelegate!
    
    fileprivate var newsCounter = 0
    fileprivate let step = 20
    
    override init() {
        super.init()
        
        // setup model
        model.delegate = self
        model.setup()
        
        // setup view
        updateView()
        
        // update datasource
        updateDatasource()
    }
    
    func getDatasource() -> [News] {
        return model.getDatasource()
    }
    
    func getDatasourceCount() -> Int {
        return model.getDatasource().count
    }
    
    func getNews(index: Int) -> News {
        return model.getDatasource()[index]
    }
    
    func didRefresh() {
        updateDatasource()
    }
    
    func didSelectRowAtIndex(index: Int) {
        let news = getNews(index: index)
        model.increaseNewsCounter(news: news)
        if let id = news.id {
            self.delegate?.showNewsDetail(newsId: id)
        }
    }
    
    func loadMoreNews() {
        newsCounter = newsCounter + step
        updateDatasource()
    }
    
    fileprivate func updateView() {
        self.delegate?.updateData()
    }
}

extension NewsListViewControllerPresenter {
    
    fileprivate func updateDatasource() {
        ServerManager.instance.getNews(from: newsCounter, to: newsCounter + step) { (result) in
            switch result {
            case .Success(let data):
                DispatchQueue.main.async { [weak self] in
                    self?.model.handleData(data: data)
                }
            case .Error(let message):
                DispatchQueue.main.async { [weak self] in
                    self?.delegate?.showError(error: message)
                }
            }
        }
    }
}

extension NewsListViewControllerPresenter: NewsListViewControllerModelDelegate {
    
    func dataChanged() {
        updateView()
    }
    
    func showError(error: String) {
        showError(error: error)
    }
}
