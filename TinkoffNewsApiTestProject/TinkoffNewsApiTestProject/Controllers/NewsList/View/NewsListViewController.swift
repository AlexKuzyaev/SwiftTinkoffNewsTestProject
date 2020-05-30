//
//  NewsListViewControllerModel.swift
//  TinkoffNewsApiTestProject
//
//  Created by Александр Кузяев on 18.07.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import UIKit

final class NewsListViewController: UITableViewController {

    // MARK: - Properties
    
    var output: NewsListViewOutput?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupRefreshControl()
    }
}

// MARK: - NewsListViewInput

extension NewsListViewController: NewsListViewInput {
    
    func updateData() {
        stopRefresh()
        tableView.reloadData()
    }
    
    func showError(error: String) {
        stopRefresh()
        showAlert(alertTitle: Strings.error, message: error)
    }

    func showNewsDetail(newsId: String) {
        let vc = NewsDetailModuleConfigurator().configure(newsId: newsId)
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UITableView methods

extension NewsListViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsListTableViewCell.className,
                                                     for: indexPath) as? NewsListTableViewCell
        else {
            return UITableViewCell()
        }

        if  let news = output?.getNews(index: indexPath.row),
            let title = news.title  {
            cell.update(title: title, counter: news.counter.toString())
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard
            let datasourceCount = output?.getDatasourceCount(),
            indexPath.row == datasourceCount - 1
        else {
            return
        }
        output?.loadMoreNews()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        output?.didSelectRowAtIndex(index: indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output?.getDatasourceCount() ?? 0
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

// MARK: - Private Methods

private extension NewsListViewController {

    func setupTableView() {
        tableView.register(UINib(nibName: NewsListTableViewCell.className, bundle: nil),        forCellReuseIdentifier: NewsListTableViewCell.className)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
    }

    func setupRefreshControl() {
        guard let refresh = tableView.refreshControl else {
            return
        }
        refresh.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
    }

    @objc
    func handleRefresh() {
        output?.didRefresh()
    }

    func stopRefresh() {
        tableView.refreshControl?.endRefreshing()
    }
}

