//
//  NewsListModelInput.swift
//  TinkoffNewsApiTestProject
//
//  Created by Александр Кузяев on 30.05.2020.
//  Copyright © 2020 Alexandr Kuzyaev. All rights reserved.
//

import Foundation

protocol NewsListModelInput: class {
    func handleData(data: [[String: AnyObject]])
    func increaseNewsCounter(news: NewsEntity)
    func getDatasource() -> [NewsEntity]
}
