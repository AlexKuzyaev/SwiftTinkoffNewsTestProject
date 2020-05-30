//
//  NewsDetailViewInput.swift
//  TinkoffNewsApiTestProject
//
//  Created by Александр Кузяев on 30.05.2020.
//  Copyright © 2020 Alexandr Kuzyaev. All rights reserved.
//

import Foundation

protocol NewsDetailViewInput: LoaderDisplayable, ErrorDisplayable {
    func updateData(attributedString: NSAttributedString)
}
