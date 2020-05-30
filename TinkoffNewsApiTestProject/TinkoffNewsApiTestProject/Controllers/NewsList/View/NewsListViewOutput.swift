//
//  NewsListViewOutput.swift
//  TinkoffNewsApiTestProject
//
//  Created by Александр Кузяев on 30.05.2020.
//  Copyright © 2020 Alexandr Kuzyaev. All rights reserved.
//

import Foundation

protocol NewsListViewOutput: class {
    func getDatasource() -> [NewsEntity]
    func getDatasourceCount() -> Int
    func getNews(index: Int) -> NewsEntity?
    func didRefresh()
    func didSelectRowAtIndex(index: Int)
    func loadMoreNews()
}
