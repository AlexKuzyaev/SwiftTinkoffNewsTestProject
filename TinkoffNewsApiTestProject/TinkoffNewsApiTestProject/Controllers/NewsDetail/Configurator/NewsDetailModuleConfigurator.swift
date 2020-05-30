//
//  NewsDetailModuleConfigurator.swift
//  TinkoffNewsApiTestProject
//
//  Created by Александр Кузяев on 30.05.2020.
//  Copyright © 2020 Alexandr Kuzyaev. All rights reserved.
//

import UIKit

final class NewsDetailModuleConfigurator {

    // MARK: - Public Methods

    func configure(newsId: String) -> UIViewController {
        guard let view = UIStoryboard(name: NewsDetailViewController.className,
                                      bundle: nil).instantiateInitialViewController() as? NewsDetailViewController else {
            fatalError("Can't load NewsDetailViewController from storyboard, check that controller is initial view controller")
        }

        let model = NewsDetailModel(newsId: newsId)
        let presenter = NewsDetailPresenter(newsService: NewsService(), model: model)
        
        model.output = presenter
        presenter.view = view
        view.output = presenter

        return view
    }

}
