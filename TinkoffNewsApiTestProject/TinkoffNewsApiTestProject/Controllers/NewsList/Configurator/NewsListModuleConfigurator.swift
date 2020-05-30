//
//  NewsListModuleConfigurator.swift
//  TinkoffNewsApiTestProject
//
//  Created by Александр Кузяев on 30.05.2020.
//  Copyright © 2020 Alexandr Kuzyaev. All rights reserved.
//

import UIKit

final class NewsListModuleConfigurator {

    // MARK: - Public Methods

    func configure() -> UIViewController {
        guard let view = UIStoryboard(name: NewsListViewController.className,
                                      bundle: nil).instantiateInitialViewController() as? NewsListViewController else {
            fatalError("Can't load NewsListViewController from storyboard, check that controller is initial view controller")
        }

        let model = NewsListModel()
        let presenter = NewsListPresenter(newsService: NewsService(), model: model)

        model.output = presenter
        presenter.view = view
        view.output = presenter

        return view
    }

}
