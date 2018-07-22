//
//  NewsListTableViewCell.swift
//  TinkoffNewsApiTestProject
//
//  Created by Александр Кузяев on 18.07.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import UIKit

class NewsListTableViewCell: UITableViewCell {
        
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var counterLabel: UILabel!
        
    func update(title: String, counter: String) {
        titleLabel.text = title.htmlToString
        counterLabel.text = counter
    }
}
