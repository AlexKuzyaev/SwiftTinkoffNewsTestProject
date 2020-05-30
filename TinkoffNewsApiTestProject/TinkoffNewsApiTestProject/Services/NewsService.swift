//
//  NewsService.swift
//  TinkoffNewsApiTestProject
//
//  Created by Александр Кузяев on 19.07.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import Foundation

final class NewsService: NSObject {

    // MARK: - Constants

    private enum Constants {
        enum Keys {
            static let payload = "payload"
            static let content = "content"
        }
    }

    // MARK: - Public Methods
    
    func getNews(from: Int = 0, to: Int = 20, completion: @escaping ResultDictClosure) {
        
        let path = Endpoints.news + "?first=\(from)&last=\(to)"

        guard let url = URL(string: path) else {
            completion(.error(Strings.errorDefaultDescription))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                if let error = error {
                    completion(.error(error.localizedDescription))
                    return
                }
                guard
                    let data = data,
                    let json = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers]) as? [String: AnyObject],
                    let items = json[Constants.Keys.payload] as? [[String: AnyObject]]
                else {
                    completion(.error(error?.localizedDescription ?? Strings.errorDefaultDescription))
                    return
                }
                completion(.success(items))
            } catch let error {
                completion(.error(error.localizedDescription))
            }
        }
        task.resume()
    }
    
    func getNewsContent(newsId: String, completion: @escaping ResultStringClosure) {
        
        let path = Endpoints.news_content + "?id=\(newsId)"
        
        guard let url = URL(string: path) else {
            completion(.error(Strings.errorDefaultDescription))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                if let error = error {
                    completion(.error(error.localizedDescription))
                    return
                }
                guard
                    let data = data,
                    let json = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers]) as? [String: AnyObject],
                    let payload = json[Constants.Keys.payload] as? [String: AnyObject],
                    let content = payload[Constants.Keys.content] as? String
                else {
                    completion(.error(Strings.errorDefaultDescription))
                    return
                }
                completion(.success(content))
            } catch let error {
                completion(.error(error.localizedDescription))
                return
            }
        }
        task.resume()
    }
    
}
