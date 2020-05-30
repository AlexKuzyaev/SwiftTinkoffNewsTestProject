//
//  NewsDetailPresenter.swift
//  TinkoffNewsApiTestProject
//
//  Created by Александр Кузяев on 22.07.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import Foundation

class NewsDetailPresenter: NSObject {

    // MARK: - Public Properties

    weak var view: NewsDetailViewInput?

    // MARK: - Private Properties

    private let newsService: NewsService
    private let model: NewsDetailModelInput

    // MARK: - Initialization

    init(newsService: NewsService, model: NewsDetailModelInput) {
        self.newsService = newsService
        self.model = model
        super.init()
        updateDatasource()
    }
}

// MARK: -

extension NewsDetailPresenter {
    
    func updateDatasource() {
        view?.showActivityIndicatior(show: true)
        newsService.getNewsContent(newsId: model.getNewsId()) { (result) in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let content):
                    self?.model.handleData(data: content)
                case .error(let message):
                    self?.view?.showActivityIndicatior(show: false)
                    self?.view?.showError(error: message)
                }
            }
        }
    }
}

// MARK: - NewsDetailModelOutput

extension NewsDetailPresenter: NewsDetailModelOutput {
    
    func dataChanged(attributedString: NSAttributedString) {
        view?.showActivityIndicatior(show: false)
        view?.updateData(attributedString: attributedString)
    }
}

// MARK: - NewsDetailViewOutput

extension NewsDetailPresenter: NewsDetailViewOutput { }
