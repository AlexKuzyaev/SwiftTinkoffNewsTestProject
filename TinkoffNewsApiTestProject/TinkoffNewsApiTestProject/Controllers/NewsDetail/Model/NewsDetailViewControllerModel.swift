//
//  NewsDetailViewControllerModel.swift
//  TinkoffNewsApiTestProject
//
//  Created by Александр Кузяев on 22.07.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import Foundation
import CoreData
import UIKit

protocol  NewsDetailViewControllerModelDelegate: class {
    func dataChanged(attributedString: NSAttributedString)
}

class NewsDetailViewControllerModel: NSObject {
    
    private var content: String! {
        didSet {
            if let attributedString = content.htmlToAttributedString {
                self.delegate?.dataChanged(attributedString: attributedString)
            }
        }
    }
    weak var delegate: NewsDetailViewControllerModelDelegate!
    
    // MARK: - Update -
    
    func handleData(data: String) {
        content = data
    }
}
