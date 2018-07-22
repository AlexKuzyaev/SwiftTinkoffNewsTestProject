//
//  NewsDetailViewControllerPresenter.swift
//  TinkoffNewsApiTestProject
//
//  Created by Александр Кузяев on 22.07.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import Foundation

class NewsDetailViewControllerPresenter: NSObject {
    
    fileprivate var newsId: String!
    
    private let model = NewsDetailViewControllerModel()
    let viewController = NewsDetailViewController.instance()
    
    init(newsId: String) {
        super.init()
        
        // setup model
        model.delegate = self
        self.newsId = newsId
        
        // setup view
        viewController.presenter = self
        
        // update datasource
        updateDatasource()
    }
}

extension NewsDetailViewControllerPresenter {
    
    func updateDatasource() {
        viewController.showActivityIndicatior(show: true)
        ServerManager.instance.getNewsContent(newsId: newsId) { (result) in
            switch result {
            case .Success(let content):
                self.model.handleData(data: content)
            case .Error(let message):
                DispatchQueue.main.async { [weak self] in
                    self?.viewController.showActivityIndicatior(show: false)
                    self?.viewController.showError(error: message)
                }
            }
        }
    }
}

extension NewsDetailViewControllerPresenter: NewsDetailViewControllerModelDelegate {
    
    func dataChanged(attributedString: NSAttributedString) {
        self.viewController.showActivityIndicatior(show: false)
        self.viewController.updateData(attributedString: attributedString)
    }
}
