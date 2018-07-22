//
//  NewsListViewControllerModel.swift
//  TinkoffNewsApiTestProject
//
//  Created by Александр Кузяев on 18.07.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import UIKit

class NewsListViewController: UITableViewController {
    
    let presenter = NewsListViewControllerPresenter()
    
    fileprivate let cellReuseIdentifier = "NewsListTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.presenter.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupRefreshControl()
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: Nib.newsListTableViewCell, bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    private func setupRefreshControl() {
        if let refresh = tableView.refreshControl {
            refresh.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        }
    }
    
    @objc private func handleRefresh() {
        presenter.didRefresh()
    }
    
    func showNewsDetail(newsId: String) {
        let presenter = NewsDetailViewControllerPresenter(newsId: newsId)
        navigationController?.pushViewController(presenter.viewController, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension NewsListViewController: NewsListViewControllerPresenterDelegate {
    
    func updateData() {
        stopRefresh()
        tableView.reloadData()
    }
    
    func showError(error: String) {
        stopRefresh()
        showAlert(alertTitle: "Error", message: error)
    }
    
    private func stopRefresh() {
        if let refreshControl = tableView.refreshControl,
            refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
    }
}

extension NewsListViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! NewsListTableViewCell
        let news = presenter.getNews(index: indexPath.row)
        if let title = news.title {
            cell.update(title: title, counter: "\(news.counter)")
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == presenter.getDatasourceCount() - 1 {
            presenter.loadMoreNews()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didSelectRowAtIndex(index: indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getDatasourceCount()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

