//
//  NewsListPresenter.swift
//  TinkoffNewsApiTestProject
//
//  Created by Александр Кузяев on 20.07.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import Foundation

final class NewsListPresenter: NSObject {

    // MARK: - Properties

    weak var view: NewsListViewInput?

    // MARK: - Private Properties

    private let newsService: NewsService
    private let model: NewsListModelInput
    private let step = 20
    private var newsCounter = 0

    // MARK: - Initialization
    
    init(newsService: NewsService, model: NewsListModelInput) {
        self.newsService = newsService
        self.model = model
        super.init()
        updateView()
        updateDatasource()
    }
}

// MARK: - NewsListViewOutput

extension NewsListPresenter: NewsListViewOutput {

    func getDatasource() -> [NewsEntity] {
        return model.getDatasource()
    }

    func getDatasourceCount() -> Int {
        return model.getDatasource().count
    }

    func getNews(index: Int) -> NewsEntity? {
        return model.getDatasource()[index]
    }

    func didRefresh() {
        updateDatasource()
    }

    func didSelectRowAtIndex(index: Int) {
        guard let news = getNews(index: index) else {
            return
        }
        model.increaseNewsCounter(news: news)
        if let id = news.id {
            view?.showNewsDetail(newsId: id)
        }
    }

    func loadMoreNews() {
        newsCounter = newsCounter + step
        updateDatasource()
    }
}

// MARK: - Private Methods

private extension NewsListPresenter {
    
    func updateDatasource() {
        newsService.getNews(from: newsCounter, to: newsCounter + step) { (result) in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let data):
                    self?.model.handleData(data: data)
                case .error(let message):
                    self?.view?.showError(error: message)
                }
            }
        }
    }

    func updateView() {
        self.view?.updateData()
    }
}

// MARK: - NewsListModelOutput

extension NewsListPresenter: NewsListModelOutput {
    
    func dataChanged() {
        updateView()
    }
    
    func showError(error: String) {
        view?.showError(error: error)
    }
}
