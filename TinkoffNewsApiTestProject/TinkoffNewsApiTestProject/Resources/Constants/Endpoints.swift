//
//  Endpoints.swift
//  TinkoffNewsApiTestProject
//
//  Created by Александр Кузяев on 23.07.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import Foundation

private let baseUrl = "https://api.tinkoff.ru/"
private let version = "v1/"

struct Endpoints {
    
    // News list
    static let news = baseUrl + version + "news"
    
    // News details
    static let news_content = baseUrl + version + "news_content"
}
