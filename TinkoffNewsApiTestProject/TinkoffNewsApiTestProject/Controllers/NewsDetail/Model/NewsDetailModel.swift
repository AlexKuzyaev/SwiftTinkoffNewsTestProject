//
//  NewsDetailModel.swift
//  TinkoffNewsApiTestProject
//
//  Created by Александр Кузяев on 22.07.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import Foundation
import CoreData

final class NewsDetailModel: NSObject {

    // MARK: - Public Properties

    let newsId: String
    weak var output: NewsDetailModelOutput?

    // MARK: - Private Methods

    private var content: String?

    // MARK: - Initialization

    init(newsId: String) {
        self.newsId = newsId
        super.init()
    }
}

// MARK: - NewsDetailModelInput

extension NewsDetailModel: NewsDetailModelInput {

    func handleData(data: String) {
        content = data
        if let attributedString = data.htmlToAttributedString {
            output?.dataChanged(attributedString: attributedString)
        }
    }

    func getNewsId() -> String {
        return newsId
    }
}
