//
//  ServerManager.swift
//  TinkoffNewsApiTestProject
//
//  Created by Александр Кузяев on 19.07.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import Foundation

enum Result<T> {
    case Success(T)
    case Error(String)
}

class ServerManager: NSObject {
    
    static let instance = ServerManager()
    
    private override init() {}
    
    func getNews(from: Int = 0, to: Int = 20, completion: @escaping (Result<[[String: AnyObject]]>) -> Void) {
        
        let path = Endpoints.news + "?first=\(from)&last=\(to)"
        
        if let url = URL(string: path) {
            let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                guard error == nil else {
                    print("error \(error!.localizedDescription)")
                    return completion(.Error(error!.localizedDescription))
                }
                guard data != nil else {
                    return completion(.Error("No data"))
                }
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: [.mutableContainers]) as? [String: AnyObject] {
                        
                        guard let items = json["payload"] as? [[String: AnyObject]] else {
                            return completion(.Error(error?.localizedDescription ?? "No items"))
                        }
                        
                        DispatchQueue.main.async {
                            completion(.Success(items))
                        }
                    }
                } catch let error {
                    print("error \(error.localizedDescription)")
                    completion(.Error(error.localizedDescription))
                }
            }
            task.resume()
        }
    }
    
    func getNewsContent(newsId: String, completion: @escaping (Result<String>) -> Void) {
        
        let path = Endpoints.news_content + "?id=\(newsId)"
        
        if let url = URL(string: path) {
            let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                do {
                    guard error == nil else {
                        print("error \(error!.localizedDescription)")
                        return completion(.Error(error!.localizedDescription))
                    }
                    guard data != nil else {
                        return completion(.Error("No data"))
                    }
                    if let json = try JSONSerialization.jsonObject(with: data!, options: [.mutableContainers]) as? [String: AnyObject] {
                        
                        guard let payload = json["payload"] as? [String: AnyObject] else {
                            return completion(.Error(error?.localizedDescription ?? "No items"))
                        }
                        
                        guard let content = payload["content"] as? String else {
                            return completion(.Error(error?.localizedDescription ?? "No content"))
                        }
                        
                        DispatchQueue.main.async {
                            completion(.Success(content))
                        }
                    }
                } catch let error {
                    print("error \(error.localizedDescription)")
                }
            }
            task.resume()
        }
    }
    
}
